# Déploiement de l'agent GLPI sur Windows via GPO

## Prérequis

- **Serveur GLPI 10** : Assurez-vous que votre serveur GLPI est opérationnel et accessible en HTTPS.
- **Accès administrateur** : Vous devez disposer des droits d'administrateur sur votre domaine Active Directory.
- **Partage réseau** : Un partage réseau accessible en lecture par les ordinateurs du domaine pour héberger le package MSI de l'agent GLPI.

## Étape 1 : Activer l'inventaire dans GLPI

1. Connectez-vous à l'interface d'administration de GLPI.
2. Naviguez vers **"Administration"** > **"Inventaire"**.
3. Cochez l'option **"Activer l'inventaire"**.
4. Cliquez sur **"Sauvegarder"** pour enregistrer les modifications.

## Étape 2 : Préparer le package MSI de l'agent GLPI

1. **Téléchargement** :
   - Rendez-vous sur le [GitHub de l'agent GLPI](https://github.com/glpi-project/glpi-agent/releases) et téléchargez la dernière version du package MSI correspondant à votre architecture (32 ou 64 bits).

2. **Partage réseau** :
   - Copiez le fichier MSI téléchargé dans un dossier sur `C:\Ecotech_Dossier\Logiciel\`.
   - Partagez ce dossier sur le réseau avec les permissions suivantes :
     - **Partage** : `Logiciel$`
     - **Permissions de partage** :
       - Groupe **"Ordinateurs du domaine"** : Lecture seule
       - Groupe **"Admins du domaine"** : Contrôle total

## Étape 3 : Créer et configurer la GPO pour déployer l'agent GLPI

1. **Création de la GPO** :
   - Ouvrez la console **"Gestion des stratégies de groupe"**.
   - Créez une nouvelle GPO nommée, par exemple, **"Déploiement Agent GLPI"**.
   - Liez cette GPO à l'Unité d'Organisation (OU) contenant les ordinateurs cibles.

2. **Déploiement du package MSI** :
   - Éditez la GPO nouvellement créée.
   - Naviguez vers **"Configuration de l'ordinateur"** > **"Stratégies"** > **"Paramètres du logiciel"** > **"Installation de logiciel"**.
   - Faites un clic droit et sélectionnez **"Nouveau"** > **"Package"**.
   - Dans la fenêtre qui s'ouvre, entrez le chemin UNC du package MSI, par exemple `\\10.10.255.1\C$\Ecotech_Dossier\Logiciel\glpi-agent-1.11-x64.msi`.
   - Choisissez le mode d'installation **"Assigné"** et validez.

3. **Configuration de l'agent via le Registre Windows** :
   - Toujours dans l'éditeur de GPO, naviguez vers **"Configuration de l'ordinateur"** > **"Stratégies"** > **"Paramètres Windows"** > **"Paramètres de sécurité"** > **"Stratégies du registre"**.
   - Faites un clic droit et sélectionnez **"Ajouter une clé de registre"**.
   - Ajoutez la clé suivante : `HKEY_LOCAL_MACHINE\SOFTWARE\GLPI-Agent`.
   - Dans cette clé, créez les valeurs suivantes :
     - **Nom** : `server`
       - **Type** : REG_SZ
       - **Données** : URL de votre serveur GLPI, par exemple `https://10.10.255.3/glpi.ecotechsolutions.lan/front/inventory.php`.
     - **Nom** : `no_ssl_check`
       - **Type** : REG_DWORD
       - **Données** : `0` (pour désactiver la vérification SSL) ou `1` (pour l'activer).

## Étape 4 : Tester le déploiement

1. Sur un ordinateur cible, exécutez la commande suivante pour forcer la mise à jour des stratégies de groupe :

   ```bash
   gpupdate /force
   ```

2. Redémarrez l'ordinateur.
3. Vérifiez que l'agent GLPI est installé en consultant la liste des programmes installés ou en recherchant le service **"GLPI Agent"**.
4. Assurez-vous que l'ordinateur apparaît dans l'inventaire de votre serveur GLPI.
