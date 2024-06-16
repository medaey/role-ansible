# Ansible pour l'Automatisation des Services

## Qu'est-ce qu'Ansible ?

Ansible est un outil d'automatisation qui permet d'installer et de configurer efficacement des machines à travers des recettes écrites en YAML. Il simplifie la gestion des configurations et des déploiements en utilisant SSH et Python.

__ℹ Info : il existe des outils similaires (Chef, Puppet, SaltStack, Fabric, Terraform)__
## Avantages d'Ansible

- **Simplicité** : Écrit en YAML, facile à apprendre et à lire.
- **Homogénéité** : Uniformise la configuration des machines.
- **Versatilié** : Utilise uniquement SSH et Python.

## Prérequis

Pour utiliser ce projet, vous devez installer Ansible et les modules de la communauté :

```bash
apt install ansible
ansible-galaxy collection install community.general
```

Assurez-vous d'adapter ces commandes selon votre distribution Linux (par exemple, utilisez `yum` pour CentOS/RHEL).

## Exemple d'Utilisation

Pour exécuter le rôle `my-tools` sur les machines définies dans votre fichier d'inventaire :

```bash
ansible-playbook playbooks/my-tools.yml
```

Assurez-vous que vos machines cibles sont correctement configurées dans l'inventaire et qu'elles appartiennent au groupe correspondant au rôle `my-tools`.

## Gestion des Clés SSH

Avant d'exécuter vos playbooks, assurez-vous que votre clé SSH est ajoutée à l'agent SSH :

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
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

### Source
- [Ansible](https://www.ansible.com/)