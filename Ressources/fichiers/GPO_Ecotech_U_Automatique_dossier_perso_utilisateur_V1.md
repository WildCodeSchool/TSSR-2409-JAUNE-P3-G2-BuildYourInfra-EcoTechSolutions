### PREPARATION DU DOSSIER DE PARTAGE AVEC LES ENTREES D’AUTORISATIONS

- Ouvrez une session administrateur sur votre serveur Windows 2022
- dans le lecteur E:\ aller au dossier « Users ».
- Partagez ce dossier et ajouter le symbole dollar « **$** » après le nom de partage pour cacher le nom de partage :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage1.png) 
- Cliquez sur « Autorisations »
- Supprimez le groupe « Averyone » des autorisations et cliquez le bouton « Ajouter » :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage2.png) 
- Cliquez le bouton « Avanced » :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage3.png)
- Cliquez le bouton « Check Names » et sélectionnez « Administrator » et « Authenticated Users » :\ 
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage4.png)
- Accordez un contrôle total sur ce partage pour les utilisateurs sélectionnés et validez vos choix :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage5.png)
- Le dossier est maintenant partagé :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage6.png) 
-  Cliquez l’onglet « Sécurity » et accédez aux réglages avancés en cliquant le bouton « Avanced » :\
-  Cliquez le bouton `Disable inheritance` :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage7.png)
-  Cliquez sur `Remove all inherited permissions from this object` :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage8.png)
-  Une fois la liste des entrées d’autorisations vide, cliquez le bouton `add` :\
  ![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage9.png)
- Nous allons maintenant devoir ajouter des autorisations spécifiques :\
- Cliquez sur le lien `Select a principal`:\
 ![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage10.png)
- Taper « CREATOR OWNER », cliquer `OK`:\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage11.png)
- selectionner `Full control`, puis `OK`,\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage12.png)
- Cliquez sur le lien `Select a principal`:\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage10.png)
- Taper « SYSTEM », cliquer `OK`:\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage13.png)
- selectionner `Full control`, puis `OK`,\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage14.png)  
- Cliquez sur le lien `Select a principal`:\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage10.png)
- Taper « Authenticated Users», cliquer `OK`:\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage15.png)
- selectionner `Full control`, puis `OK`,\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_Partage16.png) 

 
### CREATION DE LA STRATEGIE DE GROUPE (GPO)

a) Création automatique du dossier utilisateur dans le partage « Users$ »
- Ouvrez le gestionnaire de serveur et cliquez « tools » - « Group Policy Management »
- Faites un clic droit sur votre nom de domaine et cliquez « Create e GPO in this domain, and Link it here… » :
- Nommer GPO \
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO1.png)
- Faites un clic droit sur votre objet GPO créé et cliquez « Edit »
- Dans « User Configuration », déployez la rubrique « Windows Setting »
- Cliquez « Folder » , « New », « Folder ».\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO4.png)
- Complétez la fenêtre en spécifiant bien l’emplacement où seront créés les dossiers utilisateurs (cet
emplacement correspond à l’espace de partage précédemment configuré):\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO5.png)
- Cliquez l’onglet « Common » et activez la case « Run in logged-on user's security context (user policy option) » et validez vos choix :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO6.png)

b) Mappage du dossier personnel de l’utilisateur à l’ouverture de session

- Sélectionnez « Drive Maps » et faites un clic droit « New » - « Mapped Drive » :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO7.png)
- Complétez la fenêtre ainsi : \
 ``ATTENTION, il est important, ici, de bien
respecter la syntaxe !
Indiquez le nom de partage vers le dossier
« utilisateurs » tel qu’il a été défini au
départ et n’oubliez pas d’ajouter le $
Ajoutez la variable « %LogonUser% `` \
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO8.png)
- Cliquez l’onglet « Common » et activez la case « Run in logged-on user's security context (user policy option) » et validez vos choix :\
![GPO](../Images/GPO_Automatique_dossier_perso/Dossier_GPO9.png) 

