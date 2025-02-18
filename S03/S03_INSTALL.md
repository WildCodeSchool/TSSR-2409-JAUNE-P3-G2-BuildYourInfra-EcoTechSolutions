# SPRINT 3 INSTALL
## Installation et Configuration du service SSH sur conteneur Debian

**BOUGRE**
* Template : `Debian 12` / Type : `conteneur`.
* Configuration IP : `10.10.255.3/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `1`.
* RAM : `512Go`.
* Fonction : `GLPI` / `SSH`.

## Installation et Configuration du Service GLPI sur conteneur Debian

**BOUGRE**
* Template : `Debian 12` / Type : `conteneur`.
* Configuration IP : `10.10.255.3/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `1`.
* RAM : `512Go`.
* Fonction : `GLPI` / `SSH`.


## Création GPO dans l'Active Directory

**DORYPHORE**
* Template : `Windows Server 2022` / Type : `VM`.
* Configuration IP : `10.10.255.1/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `2`.
* RAM : `4Go`.
* Fonction : `DHCP` / `DNS` / `ADDS`.

Rendez-vous à l'annexe [GPO](../Ressources/fichiers/gpo.md) et [création de GPO](../Ressources/fichiers/GPO_Mappage_Departements_et_Services.md)


___


# Installation GLPI sur serveur Debian 12

## 1. Apache

```Bash
# MAJ
apt update && apt upgrade -y

# Installation Apache
apt install apache2 -y

# Activation d'Apache au démarrage de la machine
systemctl enable apache2
```

## 2. MariaDB

```Bash
# Installation de la BDD
apt install mariadb-server -y
```

## 3. PHP

```Bash
# Installation des dépendances
apt install ca-certificates apt-transport-https software-properties-common lsb-release curl lsb-release -y

# Ajout du dépôt pour PHP 8.1 :
# wget -qO /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
# echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
curl -sSL https://packages.sury.org/php/README.txt | bash -x
apt update

# Installation de PHP 8.1
apt install php8.1 -y

# Installation des modules annexes
apt install php8.1 libapache2-mod-php -y

apt install php8.1-{ldap,imap,apcu,xmlrpc,curl,common,gd,mbstring,mysql,xml,intl,zip,bz2} -y
```

## 4. MariaDB

```Bash
# Installation de Mariadb
mysql_secure_installation
```

À part `Change the root password?`, répondre `Y` à toutes les questions.

```Bash
# Configuration de la base de données
mysql -u root -p
```

Dans la configuration de Mariadb, mettre :

```sql
# Nom de la BDD : glpidb
create database glpidb character set utf8 collate utf8_bin;

# Compte d accès à la BDD glpidb : glpi
# mot de passe du compte glpi : Azerty1*
grant all privileges on glpidb.* to glpi@localhost identified by "Azerty1*";

flush privileges;
quit
```

## 5. Ressources de GLPI dans Github

```Bash
# Téléchargement des sources
wget https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz

# Création du dossier pour glpi
mkdir /var/www/html/ecotechsolutions.lan

# Décompression du contenu téléchargé
tar -xzvf glpi-10.0.15.tgz

# Copie du dossier décompréssé vers le nouveau crée
cp -R glpi/* /var/www/html/ecotechsolutions.lan

# Suppression du fichier index.php dans /var/www/html
rm /var/www/html/index.html

# Droits d'accès aux fichiers
chown -R www-data:www-data /var/www/html/ecotechsolutions.lan
chmod -R 775 /var/www/html/glpi.lab.lan
```

## 6. Configuration de PHP

```bash
# Edition du fichier /etc/php/8.1/apache2/php.ini
nano /etc/php/8.1/apache2/php.ini
```

Modification des paramètres :
```c
memory_limit = 64M 
file_uploads = on
max_execution_time = 600
session.auto_start = 0
session.use_trans_sid = 0
```

Redémarrer le serveur.

