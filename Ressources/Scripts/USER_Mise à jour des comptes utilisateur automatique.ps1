######################################################################################################
#                                                                                                    #
#   Mise à jour des comptes utilisateur automatiquement avec fichier CSV                             #
#                                                                                                    #
######################################################################################################

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
$Users = Import-Csv -Path $File -Delimiter ";" -Header "Prenom","Nom","Societe","Site","Departement","Service","fonction","Manager_Prenom","Manager_Nom","Nom_de_PC","Marque_PC","Date_de_naissance","Telephone_fixe","Telephone_portable","teletravail"

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

        # Mise à jour des informations dans Active Directory
        Set-ADUser -Identity $ADUser.SamAccountName @UpdateParams

        Write-Host "Mise à jour réussie pour l'utilisateur : $SamAccountName" -ForegroundColor Green
    }
    Else
    {
        Write-Host "Utilisateur introuvable : $SamAccountName" -ForegroundColor Yellow
    }

    $Count++
    Start-Sleep -Milliseconds 100
}
