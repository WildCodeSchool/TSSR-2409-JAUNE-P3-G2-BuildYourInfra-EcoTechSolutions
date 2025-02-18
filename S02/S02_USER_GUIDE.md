# SPRINT 2 USER GUIDE
# Configuration de Windows 10 pour rejoindre un domaine Active Directory

## Étapes de configuration

### 1. Vérifier les paramètres réseau

1. Assurez-vous que la machine a une adresse IP correcte et qu'elle peut résoudre le domaine via DNS.
2. Configurez les paramètres DNS pour pointer vers le contrôleur de domaine Active Directory.
   - Ouvrez les **Paramètres réseau** > **Modifier les options d'adaptateur**.
   - Faites un clic droit sur votre adaptateur réseau > **Propriétés** > **Protocole Internet version 4 (TCP/IPv4)**.
   - Configurez le serveur DNS pour utiliser l'adresse IP du contrôleur de domaine.

### 2. Joindre la machine au domaine

1. Ouvrez les **Paramètres système avancés** :
   - Cliquez sur **Démarrer** > Tapez "sysdm.cpl" et appuyez sur Entrée.
2. Dans l'onglet **Nom de l'ordinateur**, cliquez sur **Modifier**.
3. Sélectionnez **Domaine** et entrez le nom du domaine (ex. : `ecotechSolutions.lan`).
4. Cliquez sur **OK**. Vous serez invité à entrer les informations d'identification d'un utilisateur ayant les permissions pour ajouter une machine au domaine.
   - Exemple d'utilisateur : `admin@ecotechSolutions.lan`.

5. Une fois la machine jointe, redémarrez le poste pour appliquer les modifications.

### 3. Vérifier la connexion au domaine

1. Après le redémarrage, connectez-vous en utilisant un compte utilisateur du domaine :
   - Nom d'utilisateur : `ecotechSolutions\\username`
   - Mot de passe : **Mot de passe du domaine**

2. Vérifiez que le profil utilisateur est créé et que les permissions fonctionnent correctement.



## Configuration des rôles AD, DNS et DHCP

### 1. Configuration de l'Active Directory (AD)

#### Étape 1 : Ajouter le rôle AD DS
1. Ouvrez **Gestionnaire de serveur**.
2. Cliquez sur **Ajouter des rôles et fonctionnalités**.
3. Suivez l’assistant :
   - **Type d'installation :** Installation basée sur un rôle ou une fonctionnalité.
   - **Serveur :** Sélectionnez le serveur local.
   - **Rôles :** Cochez **Services de domaine Active Directory (AD DS)**.
   - Confirmez l’ajout des fonctionnalités nécessaires et installez.

#### Étape 2 : Promouvoir le serveur en contrôleur de domaine
1. Une fois le rôle AD DS installé, cliquez sur l'alerte dans le gestionnaire de serveur.
2. Sélectionnez **Promouvoir ce serveur en contrôleur de domaine**.
3. Configurez l’AD :
   - **Déploiement :** Sélectionnez **Ajouter une nouvelle forêt**.
   - **Nom de domaine racine :** `EcotechSolutions.lan`.
4. Configurez les paramètres DNS :
   - Le serveur configurera automatiquement le rôle DNS.
5. Configurez le mot de passe du mode de restauration DSRM.
6. Suivez les étapes et redémarrez le serveur après la promotion.

#### Étape 3 : Vérification de l'installation
1. Ouvrez **Outils > Utilisateurs et ordinateurs Active Directory**.
2. Vérifiez que le domaine **EcotechSolutions.lan** est visible.
3. Créez une unité d’organisation (OU) pour la gestion des utilisateurs et des groupes :
   - Par exemple : **OU = Utilisateurs, OU = Groupes, OU = Ordinateurs**.

---

### 2. Configuration du rôle DNS

#### Étape 1 : Configuration de base du DNS
1. Le rôle DNS est automatiquement configuré avec AD DS.
2. Ouvrez **Outils > DNS** pour vérifier :
   - La zone principale **EcotechSolutions.lan** doit être créée.
   - Vérifiez les enregistrements automatiques : `NS`, `A`, et autres enregistrements nécessaires.

#### Étape 2 : Ajouter des enregistrements manuels
1. Pour ajouter un enregistrement A :
   - Cliquez droit sur la zone **EcotechSolutions.lan** > **Nouvel hôte (A ou AAAA)**.
   - Entrez le nom et l’adresse IP correspondante.
2. Ajoutez des enregistrements PTR dans la zone de recherche inversée :
   - Assurez-vous que la recherche inversée est configurée (zone `10.10.255.x`).

#### Étape 3 : Test du DNS
1. Utilisez **nslookup** pour tester les enregistrements :
   - Ouvrez une invite de commande et tapez : `nslookup Ecotechsolutions.lan`.
   - Vérifiez que le serveur DNS répond correctement.

---

### 3. Configuration du rôle DHCP

#### Étape 1 : Ajouter le rôle DHCP
1. Ouvrez **Gestionnaire de serveur**.
2. Cliquez sur **Ajouter des rôles et fonctionnalités**.
3. Suivez l’assistant :
   - **Rôles :** Cochez **DHCP Server**.
   - Confirmez l’ajout des fonctionnalités nécessaires et installez.

#### Étape 2 : Configurer le rôle DHCP
1. Une fois installé, ouvrez **Outils > DHCP**.
2. Configurez une nouvelle étendue :
   - Cliquez droit sur IPv4 > **Nouvelle étendue**.
   - **Nom :** Étendue principale.
   - **Plage d’adresses :** `10.10.255.10` à `10.10.255.100`.
   - **Masque de sous-réseau :** `255.255.255.0`.
   - **Passerelle par défaut :** `10.10.255.254`.
   - **Serveur DNS :** `10.10.255.1` (adresse du serveur DORYPHORE).
   - Terminez la configuration.

#### Étape 3 : Activer l'étendue
1. Cliquez droit sur l’étendue créée et sélectionnez **Activer**.

#### Étape 4 : Test du DHCP
1. Configurez un poste client en **IP automatique**.
2. Vérifiez que le poste reçoit une IP dans la plage spécifiée, ainsi que la configuration DNS et la passerelle.

---

# Configuration de Debian 12 en tant que membre d'un Active Directory

## Étapes de configuration

### 1. Mettre à jour le système

```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Installer les paquets nécessaires

```bash
sudo apt -y install realmd libnss-sss libpam-sss sssd sssd-tools adcli samba-common-bin oddjob oddjob-mkhomedir packagekit
sudo apt install -y realmd sssd sssd-tools adcli samba-common krb5-user packagekit
```

Lors de l'installation de `krb5-user`, il vous sera demandé de configurer le domaine Kerberos. Entrez le nom de votre domaine Active Directory en majuscules (par exemple : `ECOTECHSOLUTIONS.LAN`).

### 3. Découverte du domaine Active Directory

Vérifiez que le domaine est accessible :

```bash
realm discover ecotechsolutions.lan
```

Remplacez `ecotechsolutions.lan` par le nom de votre domaine. Vous devriez voir des informations sur le domaine si tout est correctement configuré.

### 4. Joindre la machine au domaine

Pour joindre la machine au domaine :

```bash
sudo realm join --user=Administrator ecotechsolutions.lan 
```

Remplacez `admin@ecotechsolutions.lan` par un compte utilisateur ayant les droits nécessaires pour ajouter une machine au domaine. Vous serez invité à entrer le mot de passe de cet utilisateur.

### 5. Vérifier l'intégration

Une fois que la commande est terminée, vérifiez que la machine est bien membre du domaine :

```bash
realm list
```

Le domaine devrait apparaître dans la liste avec des informations comme les paramètres d'intégration et de connexion.

### 6. Configurer SSSD

Éditez le fichier de configuration SSSD :

```bash
sudo nano /etc/sssd/sssd.conf
```
Configuration :

```
[sssd]
domains = ecotechsolutions.lan
config_file_version = 2
services = nss, pam

[domain/ecotechsolutions.lan]
ad_domain = ecotechsolutions.lan
krb5_realm = ECOTECHSOLUTIONS.LAN
realmd_tags = manages-system joined-with-samba
id_provider = ad
access_provider = ad
fallback_homedir = /home/%u
default_shell = /bin/bash
ldap_id_mapping = true
```

Assurez-vous que les permissions sur le fichier sont correctes :

```bash
sudo chmod 600 /etc/sssd/sssd.conf
```

Redémarrez SSSD :

```bash
sudo systemctl restart sssd
```

### 8. Tester la connexion

Essayez de vous connecter avec un utilisateur du domaine :

```bash
su - username@ecotechsolutions.lan
```

Remplacez `username@ecotechsolutions.lan` par le compte d'un utilisateur du domaine. Si tout est configuré correctement, l'utilisateur devrait être en mesure de se connecter.


# Configuration de Windows Server Core 2022 en tant que contrôleur de domaine secondaire

## Étapes de configuration

### 1. Configurer les paramètres réseau

Utilisez `sconfig` pour configurer les paramètres réseau de base :

1. Lancez l'outil de configuration en exécutant :
   ```cmd
   sconfig
   ```
2. Configurez :
   - Nom de la machine (option 2).
   - Paramètres IP statiques (option 8).
   - Configuration DNS pour pointer vers le contrôleur de domaine principal.


### 2. Joindre le serveur au domaine

Joignez le serveur au domaine Active Directory :

1. Exécutez la commande suivante :
   ```cmd
   Add-Computer -DomainName ecotechsolutions.lan -Credential ecotechSolutions\\admin
   ```
   Remplacez `ecotechsolutions\\admin` par un compte utilisateur avec des droits suffisants.

2. Redémarrez le serveur après avoir joint le domaine :
   ```cmd
   Restart-Computer
   ```

### 3. Installer les rôles nécessaires

Installez les rôles et fonctionnalités requis pour un contrôleur de domaine secondaire :

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

### 4. Promouvoir le serveur en tant que contrôleur de domaine

Configurez le serveur pour qu'il devienne un contrôleur de domaine secondaire :

1. Exécutez la commande suivante :
   ```powershell
   Install-ADDSDomainController -DomainName "ecotechsolutions.lan" -InstallDns -Credential (Get-Credential)
   ```
2. Fournissez les informations d'identification d'un utilisateur(`ecotechsolutions.lan\Administrator + MDP`) ayant des permissions administratives dans Active Directory.

3. Le serveur sera automatiquement redémarré après l'installation.

### 5. Vérifier la configuration

Après le redémarrage, vérifiez que le serveur est correctement configuré comme contrôleur de domaine secondaire :

1. Vérifiez la réplication Active Directory :
   ```powershell
   Repadmin /replsummary
   ```
