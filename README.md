# Ansible pour l'Automatisation des Services

## Qu'est-ce qu'Ansible ?

Ansible est un outil d'automatisation qui permet d'installer et de configurer efficacement des machines à travers des recettes écrites en YAML. Il simplifie la gestion des configurations et des déploiements en utilisant SSH et Python.

__ℹ Info : il existe des outils similaires (Chef, Puppet, SaltStack, Fabric, Terraform)__
## Avantages d'Ansible

- **Simplicité** : Écrit en YAML, facile à apprendre et à lire.
- **Homogénéité** : Uniformise la configuration des machines.
- **Versatilié** : Utilise uniquement SSH et Python.

## Prérequis

Pour utiliser ce projet, vous devez installer  Git, Ansible et les modules de la communauté ansible-galaxy :

```bash
sudo apt install ansible git
ansible-galaxy collection install community.general
git clone https://github.com/medaey/role-ansible.git
cd role-ansible/
```

Assurez-vous d'adapter ces commandes selon votre distribution Linux (par exemple, utilisez `yum` pour CentOS/RHEL).

## Exemple d'Utilisation

Avant tout, je vous invite à regarder et modifier le contenu du dossier `inventories`. Ce dossier contient la liste des machines qui seront administrées via Ansible.
Pour exécuter le rôle `my_tools` sur les machines définies dans votre fichier d'inventaire :

Assurez-vous que vos machines cibles sont correctement configurées dans l'inventaire et qu'elles appartiennent bien au groupe correspondant au rôle `my_tools`.

```bash
# Démarrer l'agent SSH
eval "$(ssh-agent -s)"

# Ajouter votre clé SSH RSA
ssh-add ~/.ssh/id_ed25519

# Executer une playbook
ansible-playbook playbooks/ssh.yml -i inventory/hosts.ini
```

Vous pouvez toujour effectuer un ping sur vos machines pour vérifier quelle soit bien disponible.
```bash
ansible all -m ping
```

## Gestion des Clés SSH

Pour éviter de devoir saisir votre passphrase à chaque fois que vous vous connectez a une machine, vous pouvez ajouter votre clé privée à l'agent SSH de votre système local. Assurez-vous que l'agent SSH est démarré :

#### Clés SSH ED25519

Si vous utilisez une clé SSH ED25519, voici comment vous pouvez la gérer :

```bash
# Démarrer l'agent SSH
eval "$(ssh-agent -s)"

# Ajouter votre clé SSH ED25519
ssh-add ~/.ssh/id_ed25519
```

#### Autres Clés SSH (par exemple, SHA)
Si vous utilisez d'autres types de clés SSH (par exemple, RSA), voici comment vous pouvez les gérer :

```bash
# Démarrer l'agent SSH
eval "$(ssh-agent -s)"

# Ajouter votre clé SSH RSA
ssh-add ~/.ssh/id_rsa
```

Cela permet à Ansible de se connecter aux machines cibles de manière sécurisée.

## Création de Nouveaux Rôles

Pour créer un nouveau rôle Ansible à l'aide du script `create_role.sh` :

```bash
chmod +x create_role.sh
./create_role.sh <nom_du_role>
```

Le script `create_role.sh` génère une structure de rôle standard conforme aux bonnes pratiques d'Ansible.

---

En suivant ces instructions, votre projet Ansible sera prêt à automatiser efficacement la mise en place de services sur vos infrastructures.

---

## 🧪 Tests avec Molecule

Ce rôle utilise [Molecule](https://molecule.readthedocs.io/) avec le driver **Docker** pour tester la configuration sur plusieurs distributions simultanément (Debian 12, Alpine 3.18+, Rocky Linux 9).

### Pré-requis
* Docker
* Python 3 & Ansible
* Molecule & Molecule-plugins[docker]

### Commandes de base

| Commande | Description |
| :--- | :--- |
| `molecule list` | Affiche l'état des instances de test. |
| `molecule create` | Crée les conteneurs de test. |
| `molecule converge` | Applique le rôle Ansible sur les instances. |
| `molecule verify` | Exécute les tests de vérification. |
| `molecule reset` | Supprime et recrée les instances (utile en cas d'erreur). |
| `molecule destroy` | Supprime toutes les instances de test. |
| `molecule test` | Exécute le cycle complet (create, converge, verify, destroy). |

### Debugging (Accès aux conteneurs)

Si tu souhaites inspecter manuellement les fichiers générés dans un conteneur spécifique :

```bash
# Exemple pour se connecter à Alpine 3.18
molecule login --host ssh-alpine-318

# Une fois à l'intérieur, vérifie la config :
cat /etc/ssh/sshd_config
exit
```

## 🔗 Sources & Documentation

*   [Documentation Officielle Ansible](https://docs.ansible.com/)
*   [Dépôt GitHub du Projet](https://github.com/medaey/role-ansible)