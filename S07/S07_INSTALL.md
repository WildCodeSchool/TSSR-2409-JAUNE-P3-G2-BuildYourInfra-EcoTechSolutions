# SPRINT 7
## Mise en place d'un serveur de messagerie IRedMail

### Sommaire

1) Documentation

2) Installation


## 1. Documentation


**IVROGNE**
* Template : `Debian` / Type : `CT`.
* Configuration IP : `10.10.255.10/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 20GO` / SWAP `512MO` 
* Processeur : `1`.
* RAM : `4Go`.
* Fonction : `Serveur mail`. 
 
Avant de démarrer notre conteneur, nous allons sur le DNS manager de notre serveur DNS (ici *DORYPHORE*), *Forward Lookup Zones*, *ecotechsolutions.lan* pour :
 - Créer un **Host name A** ivrogne : 10.10.255.10\
 ![Image](../Ressources/Images/Iredmail/iredmail_1.png)
 - Créer un **MX** : ivrogne : IVROGNE.ecotechsolutions.lan\
 ![Image](../Ressources/Images/Iredmail/iredmail_2.png)
  
Nous démarrons alors le conteneur puis :
 - ``apt update && apt upgrade -y``
 - Dans le fichier ``/etc/hosts`` nous modifions pour écrire: \
 `-127.0.0.1 ivrogne.ecotechsolutions.lan  ivrogne  localhost  localhost.localdomain`\
 `-127.0.1.1 ivrogne.ecotechsolutions.lan`\
 ![Image](../Ressources/Images/Iredmail/iredmail_3.png)
 - Dans le fichier `/etc/hostname` nous plaçons le nom en FQDN (Full Qualified Domain Name) \
 `-ivrogne`\
 ![Image](../Ressources/Images/Iredmail/iredmail_4.png)
Faire un **reboot** du serveur.\
Vérifier si tous est bon en tapant `hostname -f`.\
 ![Image](../Ressources/Images/Iredmail/iredmail_5.png)

## Installation

Nous pouvons alors procéder à l'installation de iRedMail. Voici les premiers pas :
  
 - Nous tapons la ligne de commande suivante : `wget https://github.com/iredmail/iRedMail/archive/refs/tags/1.7.1.tar.gz`.
 - Nous extrayons avec la commande suivante : `tar -xzf *.tar.gz`
 - On se rend dans le dossier iRedMail-* : `cd iRedMail-*`
 - Un fois placé dans ce dossier, nous exécutons le script : ``bash iRedMail.sh``
  
Nous voici alors en présence de l'assistant d'installation. 

Pour commencer l'installation, validez avec **< YES >**.

![Image](../Ressources/Images/Iredmail/iredmail_6.png)

Pour le chemin du stockage du courrier, nous le laissons par défaut, continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_7.png)

Pour le serveur web, sélectionnez **Nginx** et continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_8.png)

Pour la base de donnée des mails, sélectionnez **OpenLDAP** et  continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_9.png)

Pour le suffixe LDAP, entrez le domaine comme suit, continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_10.png)

Saisissez le mot de passe Administrateur mail "_Azerty1*_" , continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_11.png)

Saisissez le nom domaine comme suit, continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_12.png)

Saisissez le mot de passe Administrateur "_Azerty1*_" , continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_13.png)

Pour les options, sélectionnez: **_Roundcubemail_**,**_SOGo_**, **_netdata_**, **_iRedAdmin_** et **_Fail2ban_**. Continuez avec **< NEXT >**.

![Image](../Ressources/Images/Iredmail/iredmail_14.png)

Nous avons un récapitulatif des paramètres de iRedmail, avec une question "continue? [y|N], si tous est bon **y** \
![Image](../Ressources/Images/Iredmail/iredmail_15.png)

L'installation et la configuration sont terminées. 
Aux questions _File: /etc/nftables.conf, with SSHD ports: 22_ et _Restart firewall now (with ssh port: 22)?_ , validez les deux questions avec **y**.

![Image](../Ressources/Images/Iredmail/iredmail_16.png)

Faire un **reboot** du serveur.

Connectons-nous à la page de connexion de _Roundcube Webmail_ avec l'adresse IP **10.10.255.10/mail/**. Saisissez le nom d'utilisateur "_postmaster@ecotechsolutions.lan_" et le mot de passe "_Azerty1*_" et cliquez sur **CONNEXION**.

![Image](../Ressources/Images/Iredmail/iredmail_17.png)

Voici la page d'accueuil de _Roundcube Webmail_.

![Image](../Ressources/Images/Iredmail/iredmail_18.png)


Connectons-nous à la page de connexion de _iRedAdmin_ avec l'adresse IP **10.10.255.10/iredadmin/**. Saisissez le nom d'utilisateur _postmaster@ecotechsolutions.lan_ et le mot de passe _Azerty1*_ et cliquez sur **CONNEXION**.

![Image](../Ressources/Images/Iredmail/iredmail_19.png)

Pour Créer un utilisateur, allez sur l'onglet **+Ajouter**.

![Image](../Ressources/Images/Iredmail/iredmail_20.png)

Pour créer l'utilisateur, remplir tout les champs contenant une étoile rouge et cliquez sur **Ajouter** en bas de page.

![Image](../Ressources/Images/Iredmail/iredmail_21.png)

Une fois créee, vérifions en allant sur l'onglet **Domaines et Comptes**

![Image](../Ressources/Images/Iredmail/iredmail_22.png)

Retournons sur la page d'accueuil de _Roundcube Webmail_ pour verifier que l'utilisateur crée apparait bien dans les contacts.

![Image](../Ressources/Images/Iredmail/iredmail_23.png)

Créons un mail test vers notre nouveau contact et cliquez sur **Envoyer**.

![Image](../Ressources/Images/Iredmail/iredmail_24.png)

Connectons-nous sur un compte créé précédemment.

![Image](../Ressources/Images/Iredmail/iredmail_25.png)

Notre contact a bien reçu le mail test que nous avons envoyé.

![Image](../Ressources/Images/Iredmail/iredmail_26.png)

La création et la configuration de l'adresse mail est operationelle.

Après avoir déployé par **GPO**, l'installation du logiciel **Thunderbird** sur nos postes clients.\
Nous nous rendons sur le poste client *cdupont*  de notre domaine.

Une fois Thunderbird ouvert, nous procédons aux réglages suivants (de telle sorte à "lier" le serveur mail à notre client mail installé sur le poste; cela permet d'éviter à l'utilisateur de se rendre directement sur le serveur pour consulter ses emails) :
  
On se rend dans **Paramètres** > **Paramètres des comptes** > **Paramètres serveur** : ici nous spécifions le nom DNS de notre serveur mail (conteneur IVROGNE),*ivrogne.ecotechsolutions.lan* qui écoute sur le port 143 (IMAP non sécurisé).Nous validons :

![Image](../Ressources/Images/Iredmail/iredmail_27.png)
  
Ce qui génère un redémarrage de l'application pour tenir compte des modifications. Nous entrons le mot de passe de l'utilisateur en question :

![Image](../Ressources/Images/Iredmail/iredmail_28.png)
  
Nous avons connecté le client au serveur mail !

![Image](../Ressources/Images/Iredmail/iredmail_29.png)
