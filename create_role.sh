#!/bin/bash

# Vérifie si un argument a été fourni
if [ $# -eq 0 ]; then
    echo "Usage: ./create_role.sh <role_name>"
    exit 1
fi

# Récupère le nom du rôle à partir de l'argument
role_name=$1

# Création du rôle avec ansible-galaxy
mkdir -p roles
cd roles
ansible-galaxy role init $role_name
cd ../

# Création du répertoire pour les playbooks s'il n'existe pas encore
mkdir -p playbooks

# Création du fichier de playbook associé au rôle
cat << EOF > playbooks/$role_name.yml
---
- hosts: $role_name
  become: yes
  roles:
    - $role_name
EOF


# Création du fichier main.yml associé au playbooks
cat << EOF > roles/$role_name/tasks/main.yml
---
- name: Inclure les tâches spécifiques pour les autres distributions
  include_tasks: setup-{{ ansible_os_family }}-{{ ansible_distribution_version }}.yml
  when: ansible_distribution != "Alpine"

- name: Inclure les tâches spécifiques pour Alpine
  include_tasks: setup-{{ ansible_os_family }}-{{ ansible_distribution_version.split('.')[:2] | join('.') }}.yml
  when: ansible_distribution == "Alpine"
EOF

echo "- Playbook $role_name.yml created on playbooks folder"