######################################################################################################
#                                                                                                    #
#   Création USER automatiquement avec fichier (avec suppression protection contre la suppression)   #
#                                                                                                    #
######################################################################################################

$FilePath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)

### Parametre(s) à modifier

$File = "$FilePath\Utilisateurs1.csv"

### Main program

Clear-Host
If (-not(Get-Module -Name activedirectory))
{
    Import-Module activedirectory
}

$Users = Import-Csv -Path $File -Delimiter ";" -Header "Prenom","Nom","Societe","Site","Departement","Service","fonction","Manager-Prenom","Manager-Nom","Nom_de_PC","Marque_PC","Date_de_naissance","Telephone_fixe","Telephone_portable","teletravail"
$ADUsers = Get-ADUser -Filter * -Properties *
$count = 1
Foreach ($User in $Users)
{
    Write-Progress -Activity "Création des utilisateurs dans l'OU" -Status "%effectué" -PercentComplete ($Count/$Users.Length*100)
    $Name              = "$($User.Nom) $($User.Prenom)"
    $DisplayName       = "$($User.Nom) $($User.Prenom)"
    $SamAccountName    = $($User.Prenom.substring(0,1).tolower()) + $($User.Nom.ToLower())
    $UserPrincipalName = (($User.prenom.substring(0,1).tolower() + $User.nom.ToLower()) + "@" + (Get-ADDomain).Forest)
    $GivenName         = $User.Prenom
    $Surname           = $User.Nom
    $OfficePhone       = $User.Telephone_fixe
    $MobilePhone       = $User.Telephone_portable
    $EmailAddress      = $UserPrincipalName
       If ( $User.Service -eq "" )
        {
        $Path              = "ou=$($User.Departement),ou=Ecotech_users,dc=ecotechsolutions,dc=fr"
        }
    Else
        {
        $Path              = "ou=$($User.Service),ou=$($User.Departement),ou=Ecotech_users,dc=ecotechsolutions,dc=fr"
        }

    $Company           = $User.Societe
    $JobTitle          = $User.fonction
    $Department         = "$($User.Departement) - $($User.Service)"


    
    If (($ADUsers | Where {$_.SamAccountName -eq $SamAccountName}) -eq $Null)
    {
        New-ADUser -Name $Name -DisplayName $DisplayName -SamAccountName $SamAccountName -UserPrincipalName $UserPrincipalName `
        -GivenName $GivenName -Surname $Surname -OfficePhone $OfficePhone -MobilePhone $MobilePhone  -EmailAddress $EmailAddress `
        -Path $Path -AccountPassword (ConvertTo-SecureString -AsPlainText Azerty1* -Force) -Enabled $True `
        -OtherAttributes @{Company = $Company;Department = $Department} -Title $JobTitle  -ChangePasswordAtLogon $True
        
        Write-Host "Création du USER $SamAccountName" -ForegroundColor Green
    }
    Else
    {
        Write-Host "Le USER $SamAccountName existe déjà" -ForegroundColor Black -BackgroundColor Yellow
    }
    $Count++
    sleep -Milliseconds 100
}
