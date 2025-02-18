# 📘 Guide Utilisateur FreePBX

FreePBX est une interface web qui permet de gérer un système de téléphonie basé sur **Asterisk**. Ce guide couvre l'utilisation de FreePBX sans installation.

🔗 **Documentation officielle** : [FreePBX Wiki](https://wiki.freepbx.org/)

---

## 🔹 1. Connexion à FreePBX
1. **Accéder à l’interface web**  
   - Ouvrez un navigateur et entrez l’URL de votre serveur FreePBX (exemple : `http://votre-ip`).
   - Connectez-vous avec vos identifiants administrateurs.

2. **Tableau de bord**  
   - Vue d’ensemble des appels actifs, de l’état des trunks et des files d’attente.
   - Vérification des mises à jour et des alertes système.

---

## 📞 2. Gestion des Extensions (Utilisateurs)
### ➕ Ajouter une extension
1. Allez dans **Applications > Extensions**.
2. Cliquez sur **Ajouter une extension SIP ou PJSIP**.
3. Renseignez :
   - **Numéro de l'extension**
   - **Nom de l'utilisateur**
   - **Mot de passe**
4. Cliquez sur **Soumettre**, puis **Appliquer les changements**.

### ✏️ Modifier une extension
- Sélectionnez une extension existante.
- Ajustez les paramètres (ex. : permissions, code PIN, renvoi d’appel).
- Enregistrez et appliquez les modifications.

---

## 📡 3. Configuration des Trunks (Lignes téléphoniques)
### ➕ Ajouter un Trunk SIP
1. Accédez à **Connectivité > Trunks**.
2. Cliquez sur **Ajouter un Trunk SIP**.
3. Renseignez :
   - **Nom du Trunk**
   - **Détails du fournisseur SIP (hôte, identifiants, codecs)**
4. Appliquez les paramètres.

### ✅ Vérifier l’état du Trunk
- Accédez à **Statut du Système** pour voir si le Trunk est enregistré.

---

## 📜 4. Création des Règles d’Appels
### 📥 Routage des appels entrants
1. Aller dans **Connectivité > Routes entrantes**.
2. **Créer une nouvelle route** en spécifiant :
   - DID (numéro entrant)
   - Destination (ex. : standard automatique, extension spécifique).
3. **Sauvegarder et appliquer**.

### 📤 Routage des appels sortants
1. Aller dans **Connectivité > Routes sortantes**.
2. **Créer une nouvelle route** :
   - Définir un préfixe (ex. : 0 pour les appels externes).
   - Associer un **Trunk SIP**.
3. **Appliquer les changements**.

---

## 🎙️ 5. Configuration d'un Standard Automatique (IVR)
1. **Accédez à** **Applications > IVR**.
2. **Ajoutez un nouvel IVR** :
   - **Message vocal** (généré ou téléversé).
   - **Options de menu** (ex. : `1` pour service client, `2` pour ventes).
   - **Destination de chaque choix** (ex. : extension, file d’attente).
3. **Sauvegardez et appliquez**.

---

## ⏳ 6. Gestion des Files d’Attente
1. **Accédez à** **Applications > Files d’attente**.
2. **Créer une file d’attente** :
   - Numéro de file.
   - Liste des agents disponibles.
   - Stratégie de distribution des appels.
3. **Associez cette file aux appels entrants** via le **routage des appels**.

---

## 📊 7. Surveillance et Journaux d’Appels
### 📑 Historique des appels
- Accédez à **Rapports > CDR Reports**.
- Filtrez les appels par extension, date ou statut.

### 🎙️ Enregistrement des appels
- Activez l'enregistrement sur une extension via **Applications > Extensions**.
- Accédez aux enregistrements sous **Rapports > Enregistrements d’appels**.

---

## 🔧 8. Administration et Maintenance
### 🔄 Mises à jour FreePBX
- Accédez à **Admin > Updates** pour appliquer les mises à jour système.

### 👤 Gestion des permissions utilisateur
- **Admin > User Management** pour créer des utilisateurs avec accès limité.

### 💾 Sauvegarde et restauration
- **Admin > Backup & Restore** pour créer et restaurer des sauvegardes.

---
 ## Tester les appels entre les deux clients 3CX

1. Depuis **Client 1**, composez l'extension `1002`.
2. Depuis **Client 2**, composez l'extension `1001`.
