# SPRINT 7 USER GUIDE
# Installation de Redmine sur un conteneur LXC sous Proxmox

## Prérequis

- Un serveur Proxmox avec accès administrateur.
- Une image Debian 12 pour LXC.
- Un accès internet pour récupérer les paquets nécessaires.
- Un conteneur LXC avec les paramètres suivants :
  - **Nom du conteneur** : `ACCAPAREUR`
  - **Propriétaire** : Groupe 2 (EcotechSolutions)
  - **OS** : Debian 12
  - **Login** : `root` ou `wilder`
  - **Mot de passe** : `Azerty1*`
  - **Adresse IP** : `10.10.255.9/24` (interface `vmbr555`)

## Création du Conteneur LXC

### Étape 1 : Création du conteneur

1. Se connecter à l'interface web de Proxmox.
2. Aller dans `Datacenter` → `Nœud Proxmox` → `CT`.
3. Cliquer sur `Créer CT` et remplir les champs :
   - **Nom du conteneur** : `ACCAPAREUR`
   - **Mot de passe** : `Azerty1*`
   - **Système d'exploitation** : Debian 12 (choisir un template téléchargé)
   - **Réseau** : IP statique `10.10.255.9/24`, passerelle selon votre configuration
4. Valider et démarrer le conteneur.

## Installation de Redmine

### Étape 2 : Connexion au conteneur

```bash
ssh root@10.10.255.9
```
Mot de passe : `Azerty1*`

### Étape 3 : Mise à jour et installation des prérequis

```bash
apt update && apt upgrade -y
apt install -y apache2 mariadb-server libapache2-mod-passenger \
           imagemagick libmagickwand-dev curl git
```

### Étape 4 : Installation de la base de données MariaDB

```bash
systemctl enable --now mariadb
mysql_secure_installation
```

Créer une base de données et un utilisateur pour Redmine :

```bash
mysql -u root -p <<EOF
CREATE DATABASE redmine CHARACTER SET utf8mb4;
CREATE USER 'redmine'@'localhost' IDENTIFIED BY 'RedminePass123';
GRANT ALL PRIVILEGES ON redmine.* TO 'redmine'@'localhost';
FLUSH PRIVILEGES;
EOF
```

### Étape 5 : Installation de Redmine

```bash
apt install -y redmine redmine-mysql
ln -s /usr/share/redmine/public /var/www/html/redmine
chown -R www-data:www-data /usr/share/redmine /var/www/html/redmine
```

Configurer Apache pour Redmine (`/etc/apache2/sites-available/redmine.conf`) :

```bash
<VirtualHost *:80>
    ServerAdmin admin@localhost
    DocumentRoot /var/www/html/redmine

    <Directory "/var/www/html/redmine">
        RailsEnv production
        PassengerResolveSymlinksInDocumentRoot on
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/redmine_error.log
    CustomLog ${APACHE_LOG_DIR}/redmine_access.log combined
</VirtualHost>
```

Activer le site et redémarrer Apache :

```bash
a2ensite redmine.conf
a2enmod passenger
systemctl restart apache2
```

## Accès à Redmine

Une fois l’installation terminée, accéder à l’interface web :

```
http://10.10.255.9/redmine
```

- **Login** : `admin`
- **Mot de passe** : `admin`
