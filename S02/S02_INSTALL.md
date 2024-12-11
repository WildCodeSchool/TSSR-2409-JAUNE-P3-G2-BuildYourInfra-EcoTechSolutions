# SPRINT 2 INSTALL
## Création de la VM Serveur DORYPHORE sur Proxmox ainsi que la configuration des rôles AD, DNS, et DHCP

---

## Étapes de création de la VM

### 1. Créer une nouvelle VM
1. **Cliquez sur `Créer VM`.**
2. **Configurer les paramètres généraux :**
   - **ID de la VM :** `577`.
   - **Nom de la VM :** `G2-WinSRV2022-GUI`.
   - Cliquez sur `Suivant`.

3. **Configurer le support ISO :**
   - **Stockage :** Sélectionnez le stockage contenant votre ISO.
   - **ISO :** Sélectionnez l'image de Windows Server 2022.
   - Cliquez sur `Suivant`.

4. **Configurer le système d'exploitation :**
   - **Type d'OS :** `Microsoft Windows`.
   - **Version :** `Win 10`.
   - Cliquez sur `Suivant`.

5. **Configurer le matériel de disque dur :**
   - **Stockage :** Sélectionnez le stockage voulu.
   - **Taille du disque :** `50 Go` ou plus.
   - Cliquez sur `Suivant`.

6. **Configurer le matériel processeur :**
   - **Socket :** `1`.
   - **Cores :** `2` ou plus.
   - Cliquez sur `Suivant`.

7. **Configurer la mémoire vive :**
   - **RAM :** `4096 Mo` minimum.
   - Cliquez sur `Suivant`.

8. **Configurer le réseau :**
   - **Bridge :** `vmbr555`.
   - **Mode réseau :** `VirtIO`.
   - Cliquez sur `Terminer`.

---

### 2. Démarrer et installer le système d'exploitation
1. **Démarrez la VM :**
   - Sélectionnez la VM `577` (G2-WinSRV2022-GUI).
   - Cliquez sur `Démarrer`.

2. **Lancez l’installation de Windows Server 2022 :**
   - Suivez l'assistant d'installation.
   - Sélectionnez l'édition `Desktop Experience` pour une interface graphique.
   - Configurez les partitions et installez le système.

---

### 3. Configurer le réseau
1. **Attribuer l'adresse IP :**
   - Ouvrez les paramètres réseau.
   - Configurez l’adresse IP statique : `10.10.255.1`.
   - Masque de sous-réseau : `255.255.255.0`.
   - Passerelle : `10.10.255.254`.
   - DNS préféré : `127.0.0.1`.

2. **Vérifiez la connectivité réseau :**
   - Ouvrez l’invite de commande en tant qu’administrateur.
   - Tapez la commande suivante pour afficher les paramètres réseau du serveur :
     ```bash
     ipconfig /all
     ```
     - Vérifiez que l’adresse IP statique est configurée correctement.
     - Vérifiez également la passerelle (`10.10.255.254`) et le serveur DNS (`127.0.0.1`).

3. **Tester la connectivité vers la passerelle :**
   - Pingez la passerelle pour vérifier que le serveur peut la joindre :
     ```bash
     ping 10.10.255.254
     ```
     - Si la passerelle répond, vous verrez des réponses avec des temps en millisecondes.

4. **Tester la résolution DNS locale :**
   - Effectuez une requête DNS sur le serveur pour vérifier que le DNS fonctionne :
     ```bash
       nslookup EcotechSolutions.lan
     ```
     - Le serveur DNS local (`127.0.0.1`) doit répondre avec l’adresse IP du serveur AD.
   - Vérifiez également un nom d’hôte externe :
     ```bash
     nslookup google.com
     ```
     - Une réponse valide indique que le serveur peut résoudre des noms externes.

5. **Tester la connectivité Internet :**
   - Pingez une adresse IP publique pour vérifier que le serveur peut sortir sur Internet :
     ```bash
     ping 8.8.8.8
     ```
     - Cela teste uniquement la connectivité réseau sans passer par le DNS.
   - Pingez un nom de domaine pour tester à la fois le DNS et la connectivité :
     ```bash
     ping google.com
     ```
     - Si cette commande réussit, la connectivité Internet et la résolution DNS sont correctes.

6. **Vérifier la connectivité réseau entre le serveur et un poste client :**
   - Depuis le poste client, pingez l’adresse IP du serveur :
     ```bash
     ping 10.10.255.1
     ```
     - Une réponse positive indique que le client peut communiquer avec le serveur.
   - Pingez depuis le serveur vers le poste client (en utilisant son adresse IP attribuée par le DHCP ou statique).

---

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
   - Ouvrez une invite de commande et tapez : `nslookup EcotechSolutions.lan`.
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

