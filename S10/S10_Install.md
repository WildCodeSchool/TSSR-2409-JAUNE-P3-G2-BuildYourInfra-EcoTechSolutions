# SPRINT 10 INSTALL

# 🔍 Audit Active Directory avec PingCastle

## **1️⃣ Télécharger et installer PingCastle**
1. **Aller sur le site officiel** :  
   👉 [https://www.pingcastle.com/download/](https://www.pingcastle.com/download/)  
2. **Télécharger** `PingCastle.zip`  
3. **Extraire le fichier ZIP** dans un dossier, par exemple : C:\PingCastle
4. **Ouvrir le dossier extrait** et **double-cliquer sur** `PingCastle.exe`.

---

## **2️⃣ Audits disponibles**
Une fois PingCastle ouvert, plusieurs options sont disponibles.

### **📌 Health Check (Analyse globale de l'AD)**
#### 📍 Où le trouver ?  
- **Ouvrir** `PingCastle.exe`
- **Cliquer sur le numéro correspondant à** `Health Check`
- **Entrer le nom du domaine** (`ecotechsolutions.lan`)
- **Lancer l'analyse**

#### 🔹 Que fait cette analyse ?  
✅ Vérifie l’état global de la sécurité de l’Active Directory.  
✅ Analyse plusieurs critères de sécurité :
- Vulnérabilités connues
- Configuration des comptes
- Politiques de mots de passe
- Problèmes liés aux GPO
- Risques d’élévation de privilèges

✅ Génère un **rapport HTML détaillé** avec :
- Une **note globale de sécurité** (score de risque)
- Une **synthèse des failles détectées**
- Des **recommandations pour renforcer la sécurité**

#### 📁 Où trouver le rapport ?  
Le rapport est automatiquement enregistré dans le **dossier où PingCastle est exécuté**.  
Ouvre le fichier **HTML** avec un navigateur.

---

### **📌 Active Directory Map (Cartographie AD)**
#### 📍 Où le trouver ?  
- **Ouvrir** `PingCastle.exe`
- **Cliquer sur le numéro correspondant à** `AD Map`
- **Entrer le domaine** (`ecotechsolutions.lan`)
- **Générer la carte**

#### 🔹 Que fait cette analyse ?  
✅ Génère une **vue graphique** de la structure de l’Active Directory, incluant :
- Les **relations entre les domaines et forêts**
- Les **liens de confiance** (trust relationships)
- Les dépendances entre les contrôleurs de domaine

✅ Utile pour :
- Comprendre la structure AD
- Identifier des relations de confiance potentiellement dangereuses
- Visualiser les chemins d’attaque possibles

#### 📁 Où trouver le rapport ?  
Le fichier graphique est **généré automatiquement** et peut être ouvert avec un navigateur.

---

### **📌 Privilege Escalation (Élévation de privilèges)**
#### 📍 Où le trouver ?  
- **Ouvrir** `PingCastle.exe`
- **Cliquer sur le numéro correspondant à** `Privilege Escalation`
- **Sélectionner l’utilisateur à analyser**

#### 🔹 Que fait cette analyse ?  
✅ Recherche des **failles permettant une élévation de privilèges** :  
- Comptes avec **trop de permissions**
- Accès mal configuré sur des objets AD
- Relations de confiance exploitables

✅ Identifie les **comptes à haut risque** pouvant compromettre la sécurité du domaine.

#### 📁 Où trouver le rapport ?  
Un rapport HTML détaillé est **automatiquement généré** et peut être ouvert avec un navigateur.

---

### **📌 Cleansing (Nettoyage des comptes obsolètes)**
#### 📍 Où le trouver ?  
- **Ouvrir** `PingCastle.exe`
- **Cliquer sur le numéro correspondant à** `Cleansing`
- **Sélectionner les types de comptes à analyser**  

#### 🔹 Que fait cette analyse ?  
✅ Identifie les **comptes utilisateurs et machines à risque**, notamment :  
- **Comptes inactifs** depuis plusieurs mois  
- **Comptes avec un mot de passe qui n'expire jamais**  
- **Comptes sans activité** récente  
- **Utilisateurs ayant des permissions non justifiées**  

✅ Fournit des recommandations pour :
- **Désactiver ou supprimer les comptes obsolètes**
- **Forcer un changement de mot de passe**
- **Réduire les risques liés aux comptes dormants**
---

  








