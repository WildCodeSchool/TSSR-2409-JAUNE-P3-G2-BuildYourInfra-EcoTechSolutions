$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Paramètre(s) à modifier

$File = "$FilePath\Liste_Employes_Sortant.csv"

### Programme principal

Clear-Host
If (-not(Get-Module -Name activedirectory))
{
    Import-Module activedirectory
}

$Users = Import-Csv -Path $File -Delimiter ";" -Header "Prenom","Nom","Societe","Site","Departement","Service","fonction","Manager-Prenom","Manager-Nom","Nom_de_PC","Marque_PC","Date_de_naissance","Telephone_fixe","Telephone_portable","teletravail"
$TargetOU = "OU=Ecotech_A_Supprimer,DC=ecotechsolutions,DC=lan" 
$Today = (Get-Date -Format "yyyy-MM-dd")  # Date actuelle au format ISO

$count = 1
Foreach ($User in $Users)
{
    Write-Progress -Activity "Traitement des utilisateurs" -Status "% effectué" -PercentComplete ($count / $Users.Length * 100)
    
    $SamAccountName = $($User.Prenom.substring(0,1).tolower()) + $($User.Nom.ToLower())
    
    # Vérifier si l'utilisateur existe dans Active Directory
    Try {
        $ADUser = Get-ADUser -Filter {SamAccountName -eq $SamAccountName} -Properties SamAccountName,Description
        If ($ADUser) {
            # Mettre à jour la note avec la date de désactivation
            Set-ADUser -Identity $ADUser -Description "Désactivé le $Today"
            
            # Désactiver le compte utilisateur
            Disable-ADAccount -Identity $ADUser
            
            # Déplacer l'utilisateur dans l'OU cible
            Move-ADObject -Identity $ADUser.DistinguishedName -TargetPath $TargetOU
            
            Write-Host "Le compte utilisateur $SamAccountName a été désactivé et déplacé dans $TargetOU" -ForegroundColor Green
        } Else {
            Write-Host "Le compte utilisateur $SamAccountName n'existe pas dans Active Directory" -ForegroundColor Yellow
        }
    } Catch {
        Write-Error "Erreur pour l'utilisateur $SamAccountName : $_"
    }
    
    $count++
    Start-Sleep -Milliseconds 100
}
