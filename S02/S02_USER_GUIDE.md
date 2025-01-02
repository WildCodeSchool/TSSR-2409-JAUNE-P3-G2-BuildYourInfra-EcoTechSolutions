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
