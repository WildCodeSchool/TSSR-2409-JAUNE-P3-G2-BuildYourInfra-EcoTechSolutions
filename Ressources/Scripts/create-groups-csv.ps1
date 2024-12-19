# Ce script permet de créer des groupes Active Directory à partir d'un fichier CSV
# Le CSV doit contenir au minimum les colonnes : Name, Description, Path (chemin OU)

# Définition des paramètres
param(
    [Parameter(Mandatory=$true)]
    [string]$CSVPath
)

# Fonction pour vérifier si un groupe existe déjà
function Test-ADGroup {
    param([string]$groupName)
    try {
        Get-ADGroup -Identity $groupName
        return $true
    }
    catch {
        return $false
    }
}

# Importation du module Active Directory
try {
    Import-Module ActiveDirectory
}
catch {
    Write-Error "Impossible de charger le module Active Directory. Erreur : $_"
    exit 1
}

# Vérification de l'existence du fichier CSV
if (-not (Test-Path $CSVPath)) {
    Write-Error "Le fichier CSV spécifié n'existe pas : $CSVPath"
    exit 1
}

# Import du fichier CSV
try {
    $groupsToCreate = Import-Csv -Path $CSVPath -Delimiter ";" -Encoding UTF8
}
catch {
    Write-Error "Erreur lors de la lecture du fichier CSV : $_"
    exit 1
}

# Compteurs pour le rapport
$created = 0
$skipped = 0
$errors = 0

# Création des groupes
foreach ($group in $groupsToCreate) {
    # Vérification des champs obligatoires
    if (-not ($group.Name -and $group.Path)) {
        Write-Warning "Ligne ignorée : Name ou Path manquant"
        $skipped++
        continue
    }

    # Vérification si le groupe existe déjà
    if (Test-ADGroup -groupName $group.Name) {
        Write-Warning "Le groupe $($group.Name) existe déjà"
        $skipped++
        continue
    }

    # Préparation des paramètres pour New-ADGroup
    $groupParams = @{
        Name = $group.Name
        Path = $group.Path
        GroupScope = if ($group.Scope) { $group.Scope } else { "Global" }
        GroupCategory = if ($group.Category) { $group.Category } else { "Security" }
    }

    # Ajout de la description si elle existe
    if ($group.Description) {
        $groupParams.Add("Description", $group.Description)
    }

    # Création du groupe
    try {
        New-ADGroup @groupParams
        Write-Host "Groupe créé avec succès : $($group.Name)" -ForegroundColor Green
        $created++
    }
    catch {
        Write-Error "Erreur lors de la création du groupe $($group.Name) : $_"
        $errors++
    }
}

# Affichage du rapport final
Write-Host "`nRapport de création des groupes :" -ForegroundColor Cyan
Write-Host "Groupes créés : $created"
Write-Host "Groupes ignorés : $skipped"
Write-Host "Erreurs : $errors"
