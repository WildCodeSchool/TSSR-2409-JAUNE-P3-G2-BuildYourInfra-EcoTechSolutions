# SPRINT 8 INSTALL

## 🚀Installation d'un serveur de mise à jour WSUS sur une VM Windows Server 2022

## I. Installation du rôle WSUS

Avant de démarrer l’installation, intégrez le serveur WSUS au domaine Active Directory.

1. Ouvrez le **Gestionnaire de serveur**, cliquez sur **Gérer** puis **Ajouter des rôles et fonctionnalités**.
2. Passez le premier écran, et comme **Type d’installation**, prenez la première option. Poursuivez.
3. Concernant l’étape **Rôles de serveurs**, choisissez **Windows Server Update Services** tout en bas de la liste.
4. L’assistant vous demande d’installer les dépendances (outils d’administration, serveur web IIS). Cliquez sur **Ajouter des fonctionnalités**.
   > **Note** : Sur certaines versions de Windows Server, le rôle s’appelle **Service WSUS**.
5. À l’étape suivante, cliquez sur **Suivant**.
6. Cochez les cases **WID Connectivity** et **WSUS Services**. Deux options sont possibles pour la base de données WSUS :
   - **WID Connectivity** (Windows Internal Database, par défaut et recommandée).
   - **SQL Server Express** (si nécessaire pour des configurations avancées).
7. Indiquez l’emplacement des données WSUS (ex. : `W:\WSUS`). Un dossier `WsusContent` sera créé automatiquement.
8. Un serveur Web **IIS** est requis pour WSUS. Cliquez sur **Suivant**.
9. Cliquez sur **Suivant** sans modifier les paramètres.
10. Cliquez sur **Installer** pour démarrer l’installation.

L’installation prend quelques minutes. Une fois terminée, un avertissement apparaît dans le **Gestionnaire de serveur** pour finaliser la post-installation. Cliquez sur le lien pour démarrer cette tâche.

> **Remarque** : En cas d’erreur, consultez les logs situés dans :
> `C:\Users\<utilisateur>\AppData\Local\Temp\WSUS_PostInstall_<date>.log`

---

## II. Configuration de base de WSUS

WSUS est installé et la base de données est créée. Nous allons maintenant effectuer la configuration de base.

1. Ouvrez la console **Services WSUS** et cliquez sur **Suivant**.
2. Choisissez si vous souhaitez participer au programme d’amélioration de Microsoft Update.
3. Sélectionnez la source de synchronisation WSUS :
   - **Microsoft Update** (par défaut).
   - **Un autre serveur WSUS** (si architecture multisite avec serveur maître et secondaires).
4. Configurez un **proxy** si nécessaire.
   > **Note** : WSUS communique avec Microsoft Update via **HTTPS (port 443)**. Vérifiez vos règles réseau.
5. Cliquez sur **Démarrer la connexion** pour récupérer la liste des produits et langues disponibles. Cette opération peut prendre du temps.
6. Sélectionnez les **langues** des mises à jour (`Français`, `Anglais` ou autres selon vos besoins).
7. Sélectionnez les **produits** pour lesquels WSUS doit gérer les mises à jour (Windows Server, Office, SQL, etc.).
   > **Remarque** : Plus vous sélectionnez de produits, plus WSUS consommera de stockage.
8. Sélectionnez les **types de mises à jour** à synchroniser :
   - **Mises à jour critiques**
   - **Mises à jour de sécurité**
   - **Mises à jour générales**
   - **Mises à jour de définitions (Windows Defender)**
   - **Upgrades** (si gestion des mises à niveau Windows requise).
9. Planifiez la **synchronisation** des mises à jour (ex. : une fois par jour à 02:00 du matin).
10. Cochez **Commencer la synchronisation initiale** si vous souhaitez synchroniser immédiatement.
11. Cliquez sur **Terminer**.

L’initialisation de WSUS est terminée !

Dans la console WSUS, sous **Synchronisations**, vous pouvez vérifier que la synchronisation est en cours (`En cours` / `Running`).
