# SPRINT 3 INSTALL
## Installation et Configuration du service SSH sur conteneur Debian

**BOUGRE**
* Template : `Debian 12` / Type : `conteneur`.
* Configuration IP : `10.10.255.3/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `1`.
* RAM : `512Go`.
* Fonction : `GLPI` / `SSH`.

## Installation et Configuration du Service GLPI sur conteneur Debian

**BOUGRE**
* Template : `Debian 12` / Type : `conteneur`.
* Configuration IP : `10.10.255.3/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `1`.
* RAM : `512Go`.
* Fonction : `GLPI` / `SSH`.


## Création GPO dans l'Active Directory

**DORYPHORE**
* Template : `Windows Server 2022` / Type : `VM`.
* Configuration IP : `10.10.255.1/24` / Passerelle : `10.10.255.254` / Carte réseau : `vmbr555`.
* Hard Disk : `1 HDD 32GO` (Système + Dossiers Partagés) 
* Processeur : `2`.
* RAM : `4Go`.
* Fonction : `DHCP` / `DNS` / `ADDS`.

Rendez-vous à l'annexe [GPO](../Ressources/fichiers/gpo.md) et [création de GPO](../Ressources/fichiers/GPO_Mappage_Departements_et_Services.md)
