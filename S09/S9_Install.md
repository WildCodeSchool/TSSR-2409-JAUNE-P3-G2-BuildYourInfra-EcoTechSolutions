## 🚀 Installation de FreePBX sur Debian 12 dans Proxmox avec 3CX sur Windows 10

### **1. Création d’une VM Debian 12 sur Proxmox**
1. **Créer une nouvelle VM** dans Proxmox :
   - **Nom** : `FreePBX`
   - **OS** : Debian 12 
   - **CPU** : 2 vCPU
   - **RAM** : 2 Go (ou plus selon besoins)
   - **Disque** : 20 Go 
   - **Réseau** : Bridge 
2. **Démarrer l’installation de Debian 12** :
   - Choisir une **installation minimale** avec SSH.
   - Configurer un **utilisateur root** et une **IP statique**.
   - Redémarrer la VM après installation.
     
3. **Configurer le conteneur** :
   - Activer Nesting pour la compatibilité Asterisk.
   - Configurer un utilisateur root et une IP statique.
---

### **2. Installation de FreePBX sur Debian 12**
1. **Mettre à jour le système** :
   ```bash
   apt update && apt upgrade -y
   ```
2. **Installer les prérequis** :
   ```bash
   apt install -y sudo curl gnupg2 wget sox mariadb-server apache2 php php-cli php-mysql php-curl php-xml php-mbstring php-zip php-gd php-bcmath
   ```
3. **Installer Asterisk** :
   ```bash
   wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
   tar xvf asterisk-20-current.tar.gz
   cd asterisk-20.*/
   ./configure && make && make install && make samples && make config
   ```
4. **Installer FreePBX** :
   ```bash
   cd /usr/src/
   wget https://mirror.freepbx.org/modules/packages/freepbx/freepbx-16.0-latest.tgz
   tar xvf freepbx-16.0-latest.tgz
   cd freepbx
   ./install -n
   ```
5. **Démarrer FreePBX** :
   ```bash
   systemctl enable apache2 mariadb
   systemctl restart apache2 mariadb
   fwconsole restart
   ```
6. **Accéder à l’interface Web** : `http://[IP_FreePBX]`.

---

### **3. Installation du client 3CX sur Windows 10**
1. **Télécharger le client 3CX** depuis [https://www.3cx.com/](https://www.3cx.com/).
2. **Lancer l’installation** et suivre l’assistant.
3. **Configurer un compte SIP FreePBX** :
   - Serveur SIP : `IP_FreePBX`
   - Nom d’utilisateur : `Extension FreePBX`
   - Mot de passe : `Mot de passe de l’extension`
4. **Tester les appels entre extensions**.

---

## 1. Créer des extensions SIP dans FreePBX

### 1.1. Créer l'extension pour Client 1 (Extension 1001)

1. Connectez-vous à l'interface web de FreePBX :
   - Ouvrez un navigateur et entrez l'adresse de votre serveur FreePBX, par exemple :
     ```
     http://10.10.255.14
     ```
2. Allez dans **Applications** → **Extensions**
3. Cliquez sur **Add Extension** et choisissez **PJSIP Extension** (ou **Chan SIP** si vous préférez, mais **PJSIP** est recommandé).
4. Configurez l’extension :
   - **User Extension** : `1001`
   - **Display Name** : `Client 1`
   - **Secret (Mot de passe SIP)** : Choisissez un mot de passe fort ou laissez-le généré automatiquement.
5. Cliquez sur **Submit** puis sur **Apply Config** pour sauvegarder.

### 1.2. Créer l'extension pour Client 2 (Extension 1002)

1. Allez dans **Applications** → **Extensions**
2. Cliquez à nouveau sur **Add Extension** et choisissez **PJSIP Extension**.
3. Configurez l’extension :
   - **User Extension** : `1002`
   - **Display Name** : `Client 2`
   - **Secret (Mot de passe SIP)** : Choisissez un mot de passe fort ou laissez-le généré automatiquement.
4. Cliquez sur **Submit** puis sur **Apply Config** pour sauvegarder.

---

## 2. Configurer les clients 3CX

### 2.1. Télécharger et installer 3CX sur les deux ordinateurs 

1. Téléchargez le client 3CX depuis le [site officiel de 3CX](https://www.3cx.com/).
2. Installez le client 3CX sur les deux machines.

### 2.2. Configurer l'extension sur 3CX pour Client 1

1. Ouvrez l’application 3CX.
2. Ajoutez un **nouveau compte SIP**.
3. Entrez les informations suivantes pour **Client 1** :
   - **SIP Server** : `10.10.255.14` (l'adresse IP de votre serveur FreePBX)
   - **Username** : `1001` (L'extension de Client 1)
   - **Password** : Le mot de passe généré pour l'extension 1001 dans FreePBX
   - **Port SIP** : `5060` (par défaut pour PJSIP, ou `5160` pour Chan SIP)
4. Cliquez sur **Save** ou **Connect**.

### 2.3. Configurer l'extension sur 3CX pour Client 2

1. Ouvrez l’application 3CX sur le second appareil.
2. Ajoutez un **nouveau compte SIP**.
3. Entrez les informations suivantes pour **Client 2** :
   - **SIP Server** : `10.10.255.14` (l'adresse IP de votre serveur FreePBX)
   - **Username** : `1002` (L'extension de Client 2)
   - **Password** : Le mot de passe généré pour l'extension 1002 dans FreePBX
   - **Port SIP** : `5060` (par défaut pour PJSIP, ou `5160` pour Chan SIP)
4. Cliquez sur **Save** ou **Connect**.

---

## 3. Tester les appels entre les deux clients 3CX

1. Depuis **Client 1**, composez l'extension `1002`.
2. Depuis **Client 2**, composez l'extension `1001`.

✅ Si tout est configuré correctement, vous devriez pouvoir vous appeler entre les deux clients.
