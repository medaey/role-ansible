## Ansible Role: RUSTDESK
Ce rôle Ansible installe et configure un serveur Rustdesk, un outil de prise en main à distance auto-hébergé.

Rustdesk est une solution de prise en main à distance auto-hébergée, comparable à des outils comme UltraVNC ou TeamViewer. Ce rôle Ansible simplifie le déploiement et la configuration d’un serveur Rustdesk, y compris la gestion des clés pour l’authentification des connexions.

### Fonctionnalités
  - Installation de Rustdesk : Télécharge et installe la version spécifiée de Rustdesk.
  - Configuration : Génère les clés SSH nécessaires et configure le serveur.
  - Service : Crée et gère les service `hbbr` et `hbbs` Rustdesk.
  - Sécurité : La clé publique est générée et stockée pour l’authentification dans `/var/lib/rustdesk/id_ed25519.pub`.