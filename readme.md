Liste des role ansible que j'ai crée

# Préparer sont environement

Pour crée un environement de test j'utilise multipass qui est outils en ligne de commande pour crée plusieur machine virtuelle facilement.

Pour installer multipass sous linux & man utiliser snap ou brew pour windows un .exe est disponible sur le site officiel  https://multipass.run

```
multipass launch 22.04 -n ansible-master -c 2 -m 1G
multipass launch 22.04 -n ansible-srv1 -c 2 -m 1G
multipass launch 20.04 -n ansible-srv2 -c 2 -m 1G
multipass launch 18.04 -n ansible-srv3 -c 2 -m 1G
multipass launch 22.04 -n ansible-srv4 -c 2 -m 1G

multipass shell ansible-master

sudo apt update && sudo apt upgrade -y && sudo apt install ansible -y
```