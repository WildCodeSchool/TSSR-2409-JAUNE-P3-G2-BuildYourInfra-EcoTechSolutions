
### CREATION DE LA STRATEGIE DE GROUPE (GPO)



a) Mappage du dossier Département à l’ouverture de session

- Ouvrez le gestionnaire de serveur et cliquez « tools » - « Group Policy Management »
- Déployer votre nom de domaine , puis l'OU Ecotech_users
- Faites un clic droit sur l'OU département et cliquez « Create a GPO in this domain, and Link it here… » :
- Nommer GPO \
  (lien GPO_Mappage_Dep1.png)
- Faites un clic droit sur votre objet GPO créé et cliquez « Edit »
- Dans « User Configuration », déployez la rubrique « Windows Setting »
- Sélectionnez « Drive Maps » et faites un clic droit « New » - « Mapped Drive » :\
  (lien GPO_Mappage_Dep2)
- Complétez la fenêtre ainsi : \

  (lien GPO_Mappage_Dep3.png)
- Cliquez l’onglet « Common » et activez la case « Run in logged-on user's security context (user policy option) » et validez vos choix :\
   (lien GPO_Mappage_Dep4.png) 

b) Mappage du dossier Service à l’ouverture de session

- Ouvrez le gestionnaire de serveur et cliquez « tools » - « Group Policy Management »
- Déployer votre nom de domaine , puis l'OU Ecotech_users
- Faites un clic droit sur l'OU Service et cliquez « Create a GPO in this domain, and Link it here… » :
- Nommer GPO \
  (lien GPO_Mappage_Serv1.png)
- Faites un clic droit sur votre objet GPO créé et cliquez « Edit »
- Dans « User Configuration », déployez la rubrique « Windows Setting »
- Sélectionnez « Drive Maps » et faites un clic droit « New » - « Mapped Drive » :\
  (lien GPO_Mappage_Serv2.png)
- Complétez la fenêtre ainsi : \
  (lien GPO_Mappage_Serv3.png)
- Cliquez l’onglet « Common » et activez la case « Run in logged-on user's security context (user policy option) » et validez vos choix :\
   (lien GPO_Mappage_Serv4.png)
