######################################################################################################
#                                                                                                    #
#    Mise à jour des comptes utilisateur automatiquement avec fichier CSV  et logs                   #
#                                                                                                    #
######################################################################################################

function Log {
    param (
        [string]$Message,
        [string]$Level = "INFO",
        [string]$LogDir = "E:\LogsPowerShell"  # Dossier de stockage des logs
    )

    # Création du dossier s'il n'existe pas
    if (!(Test-Path -Path $LogDir)) {
        New-Item -ItemType Directory -Path $LogDir -Force | Out-Null
    }

    # Définition du fichier log (nommé avec la date)
    $LogFile = "$LogDir\script-$(Get-Date -Format 'yyyy-MM-dd').log"

    # Obtenir le fichier et la ligne d'appel
    $Caller = (Get-PSCallStack)[1]  # 1 = appelant direct
    $CallerInfo = "$($Caller.ScriptName):$($Caller.ScriptLineNumber)"

    # Format du log
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogMessage = "[$Timestamp] [$Level] $CallerInfo - $Message"

    # Écriture dans le fichier et affichage dans la console
    $LogMessage | Tee-Object -FilePath $LogFile -Append
}

# Exemples d'utilisation
Log "Ceci est un message d'information"
Log "Attention, ceci est un avertissement" -Level "WARNING"
Log "Erreur critique détectée" -Level "ERROR"

# Début du script
Write-Log -Message "Début du script."

try {
    # Exemple d'opération réussie
    Write-Log -Message "Une opération a été effectuée avec succès."

    # Exemple d'avertissement
    Write-Log -Message "Une situation potentiellement problématique." -Level "WARNING"

    # Exemple d'erreur
    # Uncommenter pour simuler une erreur : throw "Erreur simulée"
    #throw "Une erreur simulée s'est produite."
} catch {
    Write-Log -Message "Une erreur est survenue : $_" -Level "ERROR"
    exit 1
}
Write-Log -Message "Fin du script."
 

$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Paramètre(s) à modifier

$File = "$FilePath\Utilisateurs2.csv"

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory))
{
    Import-Module activedirectory
}

# Importation des utilisateurs depuis le fichier CSV
$Users = Import-Csv -Path $File -Delimiter ";" -Header "Prenom","Nom","Societe","Site","Departement","Service","fonction","Manager_Prenom","Manager_Nom","Nom_de_PC","Marque_PC","Date_de_naissance","Telephone_fixe","Telephone_portable","teletravail","IpPhone"

$count = 1

Foreach ($User in $Users)
{
    Write-Progress -Activity "Mise à jour des utilisateurs dans l'OU" -Status "% effectué" -PercentComplete ($Count / $Users.Length * 100)

    # Création des informations de base pour retrouver l'utilisateur
    $SamAccountName = $($User.Prenom.substring(0,1).tolower()) + $($User.Nom.ToLower())
    $ADUser = Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -Properties *

    If ($ADUser)
    {
        # Mise à jour des propriétés de l'utilisateur
        $UpdateParams = @{
            DisplayName       = "$($User.Nom) $($User.Prenom)"
            GivenName         = $User.Prenom
            Surname           = $User.Nom
            OfficePhone       = $User.Telephone_fixe
            MobilePhone       = $User.Telephone_portable
            ipPhone           = $User.IpPhone   # Ajout du champ IP Phone
            EmailAddress      = "$($User.Prenom.substring(0,1).tolower())$($User.Nom.ToLower())@" + (Get-ADDomain).Forest
            Company           = $User.Societe
            Title             = $User.fonction
            Department        = "$($User.Departement) - $($User.Service)"
            Manager           =  if ($User.Manager_Prenom -and $User.Manager_Nom) {
                ($User.Manager_Prenom.Substring(0,1).ToLower()) + $User.Manager_Nom.ToLower()
            } else {
              Write-Host "pas de Manager pour : $SamAccountName" -ForegroundColor red
            }
        }

        # Mise à jour des informations standards
        Set-ADUser -Identity $ADUser.SamAccountName @UpdateParams -ErrorAction SilentlyContinue


        # Mise à jour des attributs personnalisés
        if ($User.IpPhone) {
        Set-ADUser -Identity $ADUser.SamAccountName -Replace @{ipPhone=$User.IpPhone} -ErrorAction SilentlyContinue

        }

        Write-Host "Mise à jour réussie pour l'utilisateur : $SamAccountName" -ForegroundColor Green
    }
    Else
    {
        Write-Host "Utilisateur introuvable : $SamAccountName" -ForegroundColor Yellow
    }

    $Count++
    Start-Sleep -Milliseconds 100
}
