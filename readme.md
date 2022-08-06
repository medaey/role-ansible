# Liste des role ansible

Ce depon contient les role que j'ai crée pou l'outis ansible afin d'aumatisite l'intallation  et la gestion de configuration sur des multiple seveur.

# Préparer sont environement

Crée un environement de test j'utilise l'outils en ligne de commande multipass pour crée plusieur machines virtuelle rapidement. Multpass s'install sous linux & mac a l'aide de snap ou brew pour windows un setup.exe est disponibel sur le site officiel https://multipass.run

```
multipass launch 22.04 -n ansible-master -c 2 -m 1G
multipass launch 22.04 -n ansible-srv1 -c 2 -m 1G
multipass launch 20.04 -n ansible-srv2 -c 2 -m 1G
multipass launch 18.04 -n ansible-srv3 -c 2 -m 1G
multipass launch 22.04 -n ansible-srv4 -c 2 -m 1G

multipass shell ansible-master

sudo apt update && sudo apt upgrade -y && sudo apt install ansible -y
```