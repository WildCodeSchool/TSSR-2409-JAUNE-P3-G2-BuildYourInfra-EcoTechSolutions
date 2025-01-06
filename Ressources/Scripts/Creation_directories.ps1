# Définition du chemin de base
$BaseDir = "E:\EcoTechSolutions"

# Fonction pour créer un dossier
function Create-Dir {
    param (
        [string]$DirPath
    )
    New-Item -ItemType Directory -Path $DirPath -Force | Out-Null
    Write-Output "Créé : $DirPath"
}

# Création de l'arborescence
Create-Dir "$BaseDir\Communication\Directrice_Communication"
Create-Dir "$BaseDir\Communication\Communication_interne"
Create-Dir "$BaseDir\Communication\Relation_medias"

Create-Dir "$BaseDir\Developpement\Directeur_Developpement"
Create-Dir "$BaseDir\Developpement\Analyse_et_conception"
Create-Dir "$BaseDir\Developpement\Developpement"
Create-Dir "$BaseDir\Developpement\Recherche_et_prototype"
Create-Dir "$BaseDir\Developpement\Test_et_qualite"

Create-Dir "$BaseDir\Direction\Assistant_de_direction"
Create-Dir "$BaseDir\Direction\CEO"

Create-Dir "$BaseDir\DRH\Agent_RH"
Create-Dir "$BaseDir\DRH\Responsable_Recrutement"

Create-Dir "$BaseDir\DSI\Responsable_SI"
Create-Dir "$BaseDir\DSI\Exploitation"


Create-Dir "$BaseDir\Finance_et_comptabilite\Comptabilite"
Create-Dir "$BaseDir\Finance_et_comptabilite\Finance"
Create-Dir "$BaseDir\Finance_et_comptabilite\Fiscalite"

Create-Dir "$BaseDir\Service_commercial\Directeur_commercial"
Create-Dir "$BaseDir\Service_commercial\ADV"
Create-Dir "$BaseDir\Service_commercial\B2B"
Create-Dir "$BaseDir\Service_commercial\Service_achat"
Create-Dir "$BaseDir\Service_commercial\Service_client"

Create-Dir "$BaseDir\Users"

Write-Output "Arborescence générée avec succès"
