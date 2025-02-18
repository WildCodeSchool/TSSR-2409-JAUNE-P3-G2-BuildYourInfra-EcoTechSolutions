# SPRINT 6 INSTALLATION DE ZABBIX

# Installation des Dépendances

```bash
apt install sudo gpg curl wget
```

# Installation de PostgreSQL

Dans un premier temps, nous allons installer les dépôts PostgreSQL et désactiver les dépôts PostgreSQL système par défaut. Lorsque le message suivant apparaît :
**« Ce script activera le dépôt APT PostgreSQL sur apt.postgresql.org sur votre système. Le nom de code de la distribution utilisé sera bookworm-pgdg. »**
appuyez sur **Entrée** pour continuer et confirmer l'installation depuis le dépôt officiel.

```bash
apt install -y postgresql-common
/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
```

Ensuite, nous installons PostgreSQL, ici dans sa version actuellement prise en charge, la version 17.

```bash
apt -y install postgresql-17
```

Lancer PostgreSQL et configurer son démarrage automatique au démarrage du système :

```bash
systemctl enable postgresql --now
```

# Installation du Serveur Zabbix et de ses Composants

La base de données étant maintenant installée, nous pouvons procéder à l'installation du serveur Zabbix et de tous ses composants.

Ajoutons les dépôts Zabbix et vidons le cache d'installation.

```bash
wget https://repo.zabbix.com/zabbix/7.2/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_7.2+debian12_all.deb
dpkg -i zabbix-release_latest_7.2+debian12_all.deb
apt update
```

Nous installons tous les composants nécessaires de Zabbix.

Dans ce cas, nous utiliserons Zabbix Agent 2 comme agent principal de supervision, recommandé pour ses nombreuses fonctionnalités supplémentaires.

```bash
apt install zabbix-server-pgsql zabbix-frontend-php php8.2-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent2 zabbix-web-service
```

# Initialisation de la Base de Données

Commencez par créer un utilisateur de base de données pour Zabbix. Pendant le processus, un mot de passe d'accès sera demandé. Ensuite, créez une base de données vide et attribuez les autorisations nécessaires.

```bash
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix
```

À ce stade, nous pouvons importer le schéma et les données par défaut. Le mot de passe saisi précédemment sera de nouveau demandé.

```bash
zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix
```

# Installation de TimescaleDB

Procédons à l'installation de TimescaleDB en ajoutant d'abord son dépôt officiel.

```bash
curl -s https://packagecloud.io/install/repositories/timescale/timescaledb/script.deb.sh | sudo bash
```

Installez TimescaleDB :

```bash
apt install timescaledb-2-postgresql-17 timescaledb-2-loader-postgresql-17
```

Exécutez l'utilitaire `timescaledb-tune`, en définissant une valeur plus élevée pour le nombre maximum de connexions (`--max-conns`), ici 125 pour des tests. 

Cet utilitaire ajuste les paramètres par défaut de PostgreSQL pour optimiser les performances et configure correctement les paramètres de PostgreSQL afin de fonctionner avec TimescaleDB.

De plus, l’utilitaire nous aidera à sélectionner le fichier de configuration PostgreSQL actuel et valide, et configurera automatiquement le chargement des bibliothèques TimescaleDB.

Veuillez répondre **"oui"** (`y`) à toutes les questions. Notez que le tuner automatique suppose que PostgreSQL fonctionne sur un serveur dédié, donc certains paramètres peuvent nécessiter des ajustements.


```bash
timescaledb-tune --pg-config /usr/bin --max-conns=125
```

Redémarrez ensuite le service PostgreSQL :

```bash
systemctl restart postgresql
```

Créez et activez TimescaleDB :

```bash
echo "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;" | sudo -u postgres psql zabbix
cat /usr/share/zabbix/sql-scripts/postgresql/timescaledb/schema.sql | sudo -u zabbix psql zabbix
```

# Configuration du Serveur Zabbix

Ouvrez le fichier de configuration du serveur Zabbix situé à :

```bash
nano /etc/zabbix/zabbix_server.conf
```

Modifiez les paramètres suivants comme indiqué ci-dessous :

```bash
...
DBPassword=motdepasse
StartReportWriters=1
WebServiceURL=http://localhost:10053/report
...
```

Configurez les packages linguistiques pour l'interface de Zabbix :

```bash
sed -i '/# fr_FR.UTF-8 UTF-8/s/^# //' /etc/locale.gen
sed -i '/# en_US.UTF-8 UTF-8/s/^# //' /etc/locale.gen
locale-gen
```

Redémarrez les services liés et configurez-les pour un démarrage automatique :

```bash
systemctl restart zabbix-server zabbix-web-service zabbix-agent2 apache2
systemctl enable zabbix-server zabbix-web-service zabbix-agent2 apache2
```

