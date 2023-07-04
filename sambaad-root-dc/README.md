[TOC]

# Role ansible pour crée un contrôleur de domaine sambaAD root

Le but est de crée une foret de contrôleur de contrôleur domaine avec qui ressemble a ceci avec un root et deux enfant avec sambaAD.

![image-20230701014022537](./assets/image-20230701014022537.png)



### Change le hostname

```
nano /etc/hostname
```

```
root.quest.com
```

```
nano /etc/hosts
```

```
127.0.0.1       localhost
192.168.1.133   root.quest.com     root
```

Vérifie que le hostname a bien changer

```
hostname
hostname -f
```

### Fix ip statique

```
nano /etc/network/interfaces
```

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto enp0s3
iface enp0s3 inet static
        address 192.168.1.110
        netmask 255.255.255.0
        network 192.168.1.0
        broadcast 192.168.1.255
        gateway 192.168.1.1
```

### Finaliser votre configuration de base

- Après le redémarrage, configurer la langue du système en anglais afin de faciliter la recherche de problèmes dans les logs :

  ```
  apt-get install -y locales-all
  localectl set-locale LANG=en_US.utf8
  localectl status
  ```

- Désactiver avahi-daemon (protocole mDNS / bonjour) :

  ```
  systemctl stop avahi-daemon.service avahi-daemon.socket
  systemctl disable avahi-daemon.service avahi-daemon.socket
  ```

- Mettre à jour Debian et installer les utilitaires d’administration nécessaires :

  ```
  apt-get update -y
  apt-get install -y wget sudo screen nmap telnet tcpdump rsync net-tools dnsutils htop apt-transport-https vim gnupg lsb-release
  ```

### Installer les paquets

Pour plus de confort, vous pouvez définir un dépôt apt et rajouter notre clé publique GPG :

```
wget -O tissamba-pubkey.gpg  http://samba.tranquil.it/tissamba-pubkey.gpg
sha256sum tissamba-pubkey.gpg
   bd0f7140edd098031fcb36106b24a6837b067f1c847f72cf262fa012f14ce2dd  tissamba-pubkey.gpg
apt-key add tissamba-pubkey.gpg
echo "deb https://samba.tranquil.it/debian/samba-4.13/ $(lsb_release -c -s) main" > /etc/apt/sources.list.d/tissamba.list
```

```
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install samba winbind libnss-winbind krb5-user smbclient ldb-tools python3-crypto
unset DEBIAN_FRONTEND
```



### Configurer Kerberos

Le `default_realm` doit absolument être écrit en **lettres MAJUSCULES** !!

```
nano /etc/krb5.conf
```

```
[libdefaults]
  default_realm = QUEST.COM
  dns_lookup_kdc = true
  dns_lookup_realm = false
```

### Configurer Samba

```bash
# Effacer le fichier /etc/smb/smb.conf s’il a déjà été généré (il sera régénéré par la commande d’instanciation)
rm -f /etc/samba/smb.conf
# Configurer Samba avec le rôle de contrôleur de domaine. Dans la ligne qui suit, vous penserez à changer à la fois le nom du royaume kerberos, et le nom court du domaine (nom netbios)
samba-tool domain provision --realm=QUEST.COM --domain=QUEST --server-role=dc
#Ré-initialiser le mot de passe administrator
samba-tool user setpassword administrator
# Poseidon!
```

- Vérifier la ligne `dns forwarder = xxx.xxx.xxx.xxx` dans votre fichier `/etc/samba/smb.conf`. Elle doit pointer vers un serveur DNS valide, par ex :

  ```
  dns forwarder = 1.1.1.1
  ```

- Reconfigurer la résolution DNS pour la machine locale. Dans le fichier `/etc/resolv.conf` de l’interface réseau, remplacer la ligne suivante :

  ```
  nano /etc/resolv.conf
  ```

  ```
  search quest.com
  nameserver 127.0.0.1
  ```

```bash
#supprimer et le remplacer par un lien symbolique vers le fichier /etc/krb5.conf
rm -f /var/lib/samba/private/krb5.conf
ln -s /etc/krb5.conf /var/lib/samba/private/krb5.conf
#Activer Samba pour qu’il démarre automatiquement au prochain reboot 
systemctl unmask samba-ad-dc
systemctl enable samba-ad-dc
systemctl disable samba winbind nmbd smbd
systemctl mask samba winbind nmbd smbd
#Redémarrer la machine
reboot
```

```bash
#Après redémarrage, tester que le kerberos est bien configuré
kinit administrator
klist
#Tester les DNS
dig @localhost google.fr
dig @localhost quest.com
dig -t SRV @localhost _ldap._tcp.quest.com
```



# Installer et configurer Bind-DLZ pour Samba-AD

```bash
#Installer le paquet Bind
apt-get install bind9
```

Modifier la section options du fichier `/etc/bind/named.conf.options`

```bash
nano /etc/bind/named.conf.options
```

```
options {
  directory "/var/cache/bind";

  forwarders {
          1.1.1.1;
  };

  allow-query {  any;};

  dnssec-validation no;

  auth-nxdomain no;    # conform to RFC1035
  listen-on-v6 { any; };

  tkey-gssapi-keytab "/var/lib/samba/bind-dns/dns.keytab";

  minimal-responses yes;
};
```

Modifier la section local du fichier `/etc/bind/named.conf.local` 

```
nano  /etc/bind/named.conf.local
```

```
dlz "quest.com" {
# For BIND 9.10.0
database "dlopen /usr/lib/x86_64-linux-gnu/samba/bind9/dlz_bind9_10.so";
};
```

Désactiver le bind en IPv6 sur le réseau local, dans `/etc/default/bind9`

```
nano /etc/default/bind9
```

```
# run resolvconf?
RESOLVCONF=no

# startup options for the server
OPTIONS="-4 -u bind"
```

```
nano /etc/samba/smb.conf
```

```
server services = -dns
```

```bash
#Créer deux répertoires dans /var/lib/samba
mkdir /var/lib/samba/bind-dns
mkdir /var/lib/samba/bind-dns/dns
#Configurer les mises à jour dynamiques des entrées DNS
samba_upgradedns --dns-backend=BIND9_DLZ
#Enfin relancer les services samba et bind
systemctl restart samba-ad-dc
systemctl restart bind9
```

## Vérifier la bonne configuration de Bind et de DLZ

```bash
#Vérifier que c’est bien le serveur bind qui écoute sur le port 53
netstat -tapn | grep 53
#Tester les DNS
dig @localhost google.fr
dig @localhost quest.com
dig -t SRV @localhost _ldap._tcp.quest.com
```

# Installer et configurer NTP pour Samba-AD sur Debian

```bash
#Installer les paquets NTP
apt-get install ntpdate ntp
ntpdate -bu pool.ntp.org
```

Rajouter les lignes suivantes à `/etc/ntp.conf` pour gérer le NTP signé utilisé par les postes windows

```
nano /etc/ntp.conf
```

```
ntpsigndsocket /var/lib/samba/ntp_signd
restrict default mssntp
```

```bash
#Changer le propriétaire du répertoire contenant la socket samba servant à authentifier le service NTP
chgrp ntp /var/lib/samba/ntp_signd
#Relancer NTP 
systemctl restart ntp
```

*sources:*

https://www.howtoforge.com/tutorial/debian-10-buster-minimal-server/

https://samba.tranquil.it/doc/fr/index.html

