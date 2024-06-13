Mes rôles ansible pour d'automatiser la mise en place de services.

# Ansible c'est quoi ?

L'on peut voir Ansible comme la suite logique des scripts bash c'est le niveau supérieur de l'automatisation.

C'est un outil qui permet d'installer et de configuré une ou plusieurs machines au travers de recettes écrites en Langage YAML. Ces recettes contiennent une série de tâches à exécuter, des conditions, des variables, etc.

L'une des forces d'Ansible et qui n'a besoin que de ssh et python3 pour pouvoir fonctionner.

Bref, Ansible permet d'installer, configuré de magniére homogène une machine, des services ou toute une architecture en un temps-record !!

ℹ Info : il existe des outils similaires (Chef, Puppet, SaltStack, Fabric, Terraform)

source : https://www.ansible.com/


## Introduction
Ce dépôt github est ma vision de l'utilisation d'ansible à savoir respecter l'arborescence standardisée par ansible-galaxy, mais revisiter afin de tenir compte des environnements Linux utilisant plusieurs types des distributions.

### Exemple d'Utilisation:
`ansible-playbook lamp.yml -i inventory`
Cette commande lance le rôle lamp sur les machines listées dans le fichier d'inventaire (inventory). Cela implique que les machines cibles doivent être définies dans le fichier inventory et appartenir au groupe lamp.

### Crée un role
Pour crée de nouveau role ansible le script create_role.sh et la pour cela
```bash
chmod +x create_role.sh
./create_role.sh <role_name>
```


### Utilisation du Fichier .yml
Le fichier `.yml` à la racine du rôle est utilisé pour lancer le rôle. Ce fichier utilise des variables, et leur fonctionnement est basé sur le nom du fichier pour déterminer le répertoire et les sous-répertoires et tasks à appeler pour effectuer l'installation.
```
ansible-playbook playbooks/my-tools.yml
```

### Variables:
Les variables utilisées dans le fichier `.yml` contiennent des informations spécifiques au rôle, telles que des configurations, des chemins, etc. Il est précisé dans ces variables que le rôle ne sera appliqué qu'aux machines présentes dans le fichier d'inventaire (inventory) et faisant partie du groupe portant le même nom que le fichier `.yml`. Cela permet de cibler spécifiquement les machines sur lesquelles vous souhaitez appliquer ce rôle.
