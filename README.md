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

#### Crée un nouveau role
Dupliquer et renomer le fichier `exemple.yml` a la racine portant par exemple toto.yml, puis crée un dossier afin de recevoir les role en fonction des distribution
```bash
cp exemple.yml toto.yml
mkdir toto
cd toto
ansible-galaxy role init toto-debian
ansible-galaxy role init toto-alpine
ansible-galaxy role init toto-redhat
```

Il vous restera a crée un groupe portant le même nom que le fichier `.yml` dans le fichier inventaire `inventory`
```ini
[toto]
120 ansible_host=120.local ansible_user=root
121 ansible_host=121.local ansible_user=root
```

Il vous reste simplement à ajuster les fichiers tasks/main.yml en fonction de la distribution choisie, en utilisant la structure de rôle que vous venez de créer avec Ansible Galaxy. Cette structure prend en compte les variables, les templates, les handlers, etc.



Comment organiser vos rôles, comment les structurer pour différentes distributions, et comment les exécuter en utilisant le fichier `.yml` ?

### Structure des Rôles:
Chaque rôle est structuré avec un fichier .yml à la racine du rôle (par exemple, lamp.yml). Il existe également un répertoire associé au rôle (par exemple, `lamp/`) qui contient plusieurs sous-répertoires spécifiques à différentes distributions (par exemple, `lamp-debian/` et `lamp-alpine/`).
```
├── lamp.yml
└── lamp/
    ├── lamp-debian/
    │   └── tasks/
    │       └── main.yml
    └── lamp-alpine/
        └── tasks/
            └── main.yml
```

### Utilisation du Fichier .yml
Le fichier `.yml` à la racine du rôle est utilisé pour lancer le rôle. Ce fichier utilise des variables, et leur fonctionnement est basé sur le nom du fichier pour déterminer le répertoire et les sous-répertoires et tasks à appeler pour effectuer l'installation.

### Variables:
Les variables utilisées dans le fichier `.yml` contiennent des informations spécifiques au rôle, telles que des configurations, des chemins, etc. Il est précisé dans ces variables que le rôle ne sera appliqué qu'aux machines présentes dans le fichier d'inventaire (inventory) et faisant partie du groupe portant le même nom que le fichier `.yml`. Cela permet de cibler spécifiquement les machines sur lesquelles vous souhaitez appliquer ce rôle.