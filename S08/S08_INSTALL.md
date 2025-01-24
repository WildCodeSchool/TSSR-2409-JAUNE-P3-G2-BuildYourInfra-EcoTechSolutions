# SPRINT 8 INSTALL
## Installation d'un serveur de mise à jour WSUS sur une wm windows server 2022
## I. Installation du rôle WSUS
Avant de démarrer l’installation, intégrez le serveur WSUS au domaine Active Directory.

Ouvrez le « Gestionnaire de serveur », cliquez sur « Gérer » puis « Ajouter des rôles et fonctionnalités ».

Passez le premier écran, et comme « Type d’installation », prenez la première option. Poursuivez.

Concernant l’étape « Rôles de serveurs », choisissez « Windows Server Update Services » tout en bas de la liste. L’assistant vous demande si vous souhaitez installer les dépendances, notamment les outils d’administration afin d’avoir la console de gestion, ainsi que le serveur web IIS qui est indispensable au bon fonctionnement de WSUS. Cliquez sur « Ajouter des fonctionnalités » pour valider.

Note : sur certaines versions de Windows Server, le rôle s’appelle « Service WSUS ».

À l’étape suivante, cliquez tout simplement sur « Suivant ».

Cochez les cases « WID Connectivity » et « WSUS Services », tout en sachant qu’il y a deux possibilités pour la base de données WSUS.

En effet, il y a l’option par défaut « WID Connectivity », où WID correspond à « Windows Internal Database », une alternative à SQL Server Express qui est intégrée à Windows. Dans une très grande majorité des cas, la base WID est utilisée. C’est le choix que je vous propose de faire dès à présent.

Indiquez l’emplacement des données WSUS, notamment les fichiers de mises à jour. Je vous recommande d’utiliser un volume dédié sur votre serveur, plutôt que le disque « C ». Par exemple, le volume « W: » au sein du dossier « WSUS », tout en sachant qu’un dossier « WsusContent » sera créé.

L’assistant nous informe qu’un serveur Web « IIS » va être mis en place sur notre serveur. C’est un prérequis, car WSUS s’appuie sur un site et des connexions HTTP/HTTPS pour distribuer les mises à jour aux clients. Cliquez sur « Suivant ».

Cliquez sur « Suivant », il n’y a pas de modifications à apporter.

Cliquez sur « Installer » pour démarrer l’installation de WSUS et des fonctionnalités associées.

En temps normal, l’installation ne prend que quelques minutes, mais elle ne s’arrête pas là. Au sein du « Gestionnaire de serveur », nous pouvons remarquer un avertissement en haut à droite : il faut démarrer les tâches de post-installation de WSUS en cliquant sur le lien.

Patientez pendant ce temps : WSUS crée la base de données. Si vous obtenez une erreur lors de ces étapes de post-installation, je vous invite à regarder les logs à cet emplacement :

C:\Users\<utilisateur>\AppData\Local\Temp\WSUS_PostInstall_<date>.log

# II. Configuration de base de WSUS

WSUS est installé sur notre serveur et la base de données est créée, que ce soit via WID ou SQL Server. Désormais, nous pouvons lancer la console « Services WSUS » afin d’effectuer la configuration de base.

Cliquez sur « Suivant » / « Next » pour commencer.

Si vous souhaitez participer du programme d’amélioration de Microsoft Update, cochez l’option, sinon décochez cette option. Poursuivez.

Sur quelle source notre serveur WSUS doit-il s’appuyer pour se synchroniser et obtenir les nouvelles mises à jour ? Deux options : à partir des serveurs de Microsoft Update (Synchronize from Microsoft Update) ou à partir d’un autre serveur WSUS (Synchronize from another Windows Server Update Services server).

La seconde option est nécessaire dans le cas d’une architecture multisite avec un serveur WSUS maître et des serveurs WSUS secondaires, ici nous allons choisir Microsoft Update.

Si vous utilisez un proxy pour accéder à Internet et qu’il doit être déclaré, c’est le moment. Sinon, poursuivez sans cocher l’option.

Note : les communications avec les serveurs de Microsoft Update s’effectuent en HTTPS avec le port 443. Veillez à autoriser ce flux au sein de votre réseau.

Cliquez sur « Démarrer la connexion » / « Start Connecting » pour que notre serveur WSUS se connecte sur les serveurs Microsoft Update. Cela va lui permettre de récupérer la liste des systèmes d’exploitation et logiciels pris en charge, les types de mises à jour, et les langages disponibles. Cette opération est assez longue… Je dirais même que vous avez le temps de prendre un café.

Une fois l’étape précédente terminée, la barre de progression sera pleine et le bouton « Suivant » / « Next » sera accessible.

La prochaine étape consiste à choisir les langues de mises à jour. Si vous utilisez seulement des systèmes d’exploitation en français pour vos postes de travail et vos serveurs, vous pouvez choisir « Français » (ou « French »).

Si vous utilisez Windows en FR sur les postes de travail et en version EN pour les serveurs, choisissez également « Anglais » (ou « English »).

Poursuivez une fois votre choix effectué, tout en sachant que vous pouvez le modifier à tout moment.

Nous devons sélectionner les produits pour lesquels nous souhaitons synchroniser les mises à jour. La liste est très longue et très complète (Exchange, Office, Edge, SQL Server, etc…), vous devez cocher les produits correspondants à ceux que vous utilisez !

Remarque : plus vous sélectionnez de produits, plus votre serveur WSUS aura des données à stocker.

Pour Windows Server 2019 et supérieur, il suffit de cocher « Windows Server 2019 ». Il y a également des catégories de produits correspondantes aux pilotes et aux packs de langues.

L’étape suivante concerne la classification des mises à jour, c’est-à-dire les types de mises à jour qu’il faut synchroniser sur le serveur WSUS. Les catégories « Mises à jour critique », « Mise à jour de la sécurité » et « Mise à jour » permettent d’obtenir les mises à jour mensuelles publiées par Microsoft, tandis que la catégorie « Mises à jour de définitions » correspond aux mises à jour Windows Defender.

Dans un environnement où il y a la volonté de distribuer les mises à niveau de Windows via WSUS, il sera nécessaire de cocher l’option « Upgrades ».

La synchronisation des mises à jour avec les serveurs Microsoft Update doit être planifiée afin d’être sûr de recevoir les dernières mises à jour. De préférence, cette synchronisation sera planifiée la nuit afin de ne pas perturber la production (gestion de la bande passante). Par exemple, une fois par jour à 02:00 du matin comme sur l’exemple ci-dessous.

Cochez l’option « Commencer la synchronisation initiale » / « Begin initial synchronization » si vous souhaitez réaliser une première synchronisation dès maintenant.

Cliquez sur « Terminer » / « Finish » : l’initialisation de WSUS est terminée !

Dans la console WSUS, si l’on clique sur la section « Synchronisations » à gauche, nous pouvons voir que la synchronisation est en cours puisqu’elle est sur l’état « En cours » / « Running ».


