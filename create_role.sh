#!/bin/bash

# Vérifie si un argument a été fourni
if [ $# -eq 0 ]; then
    echo "Usage: ./create_role.sh <role_name>"
    exit 1
fi

# Récupère le nom du rôle à partir de l'argument
role_name=$1

# Création du rôle avec ansible-galaxy
ansible-galaxy role init $role_name

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

echo "- Playbook $role_name.yml created on playbooks folder"
