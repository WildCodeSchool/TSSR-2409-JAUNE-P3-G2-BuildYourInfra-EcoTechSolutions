# 🏠 Guide Utilisateur PingCastle

**PingCastle** est un outil d’audit de sécurité permettant d’évaluer la vulnérabilité d’un environnement **Active Directory (AD)**. Il génère des rapports détaillés sur les risques et propose des recommandations pour améliorer la sécurité.

🔗 **Documentation officielle** : [PingCastle](https://www.pingcastle.com/)

---

## 🔹 1. Présentation de PingCastle
**PingCastle** permet :
- De réaliser un **audit de sécurité** d'Active Directory.
- D’évaluer les **risques liés aux contrôleurs de domaine**.
- De générer un **rapport de conformité** basé sur des critères Microsoft.
- De détecter les **failles de configuration et vulnérabilités**.

📌 **Modes d'analyse disponibles** :
- **HealthCheck** : Analyse complète de la sécurité AD.
- **Graph** : Visualisation des relations entre comptes et droits AD.
- **Conso** : Vérification de la consommation des ressources AD.
- **Map** : Cartographie des domaines AD.

---

## 📊 2. Lancer un Audit Active Directory
### 📌 Mode HealthCheck (Evaluation globale)
1. **Ouvrir l’invite de commande (cmd) avec des droits administrateur**.
2. Exécuter la commande :
   ```bash
   PingCastle.exe --healthcheck
   ```
3. Sélectionner l’option **1** pour analyser le domaine courant.
4. Attendre la fin du processus et récupérer le rapport généré au format **HTML**.

### 📌 Mode Graph (Analyse des permissions et relations)
1. Exécuter la commande :
   ```bash
   PingCastle.exe --graph
   ```
2. Sélectionner une **entité AD** (ex. : un utilisateur ou un groupe).
3. Générer un **graphe des permissions et relations**.

### 📌 Mode Map (Cartographie des forêts Active Directory)
1. Exécuter :
   ```bash
   PingCastle.exe --map
   ```
2. Obtenir une **vue d’ensemble des forêts AD** et des relations de confiance.

---

## 📁 3. Interprétation des Résultats
### 🔴 Indicateurs de Risque
PingCastle attribue un **score de sécurité** basé sur plusieurs critères :
- **0 - 50** : Faible risque
- **50 - 75** : Risque modéré (recommandé de corriger les alertes)
- **75 - 100** : Risque élevé (mesures correctives urgentes)

📌 **Éléments analysés** :
- **Mots de passe faibles** 🔑
- **Comptes avec des droits élevés** 🛡️
- **Anomalies dans les configurations AD** ⚠️
- **Permissions et délégations non sécurisées** 🔍

### 📊 Lecture du Rapport HTML
1. Ouvrir le fichier HTML généré.
2. Analyser les sections :
   - **Vue d’ensemble** : Score global et recommandations.
   - **Risques critiques** : Actions à prioriser.
   - **Graphiques** : Analyse des relations entre comptes.

---

## 🔧 4. Recommandations & Remédiations
### ✅ Bonnes pratiques
- **Appliquer le principe du moindre privilège** (réduire les droits administrateurs).
- **Mettre à jour les contrôleurs de domaine**.
- **Éliminer les comptes obsolètes** et ceux avec des mots de passe faibles.
- **Désactiver les protocoles non sécurisés** (ex. : NTLMv1).

### 📚 Ressources supplémentaires
- **Microsoft Security Compliance Toolkit** : [lien](https://learn.microsoft.com/en-us/windows/security/threat-protection/security-compliance-toolkit-10)
- **Guide Microsoft AD Security** : [lien](https://learn.microsoft.com/en-us/windows-server/security/)

---
