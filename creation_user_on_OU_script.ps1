## Création de constante 
$allOUName = Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Select Name  

## Fonction permettant l'interaction avec l'utilisateur
function GetUserInformation {
    $userName = Read-Host -Prompt 'Saisir votre Prénom'
    $userSurname = Read-Host -Prompt 'Saisir votre Nom de famille'
    $userMail = Read-Host -Prompt 'Saisir votre addresse mail'
    $OU = SelectOU
    $accountName = $userName[0] + "." + $userSurname
    $defaultPassword = "atoutweb-2022"
    Write-Output ('Your name is : ' + $userName + ' your mail is : ' + $userMail + ' and your OU is : ' + $userOU)
    Write-Output ('Your default password is :' + $defaultPassword)
    CreateUser -name $userName -surname $userSurname -mail $userMail -OU $OU -accountName $accountName -password $defaultPassword 
    Exit
}

function SelectOU {
    Write-Host "Vous devrez saisir votre Unité d'organisation avec un chiffre : "
       for ($index = 0; $index -le ($allOUName.Length-1); $index++) {
        Write-Host $index " : " $allOUName[$index].Name
   }
   $userOU = Read-Host -Prompt "Saisir votre Unité d'organisation"
   return $userOU
}

function CreateUser {
    param(
        [string] $name,
        [string] $surname,
        [string] $mail,
        [string] $OU,
        [string] $accountName,
        [string] $password
    )
    $path = InsertUserInOU -OU $OU
    $userName = $name + " " + $surname
    $allInformation = @($name, $userName, $mail, $OU)
    $OUUser = AttributeOU -OU $OU
    $group = $OUUser
    $principalAccountName = ($accountName + "@proxmoxat.fr")

    try {
        ## Vérification de la longueur de chaque réponse de l'utilisateur pour ne pas laisser de donnée vide
        Foreach($item in $allInformation){
            If($item.Length -eq 0) {
                Write-Warning "Vous n'avez rien entré comme valeur veuillez recommencer"
                GetUserInformation
                Exit
            }
        }
        ## Ajout d'un utilisateur dans un OU qui lui ai destiné
        New-ADUser -Name $userName -GivenName $name -Surname $surname -Displayname $userName -SamAccountName $accountName -UserPrincipalName $principalAccountName  -EmailAddress $mail -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -path "$path" -Enabled $true
        Add-ADGroupMember -Identity $group -Members $accountName
    }
    ## Gestion d'exception
    catch {
        Write-Warning $_
    }
}

## Fonction récupérant le nom de l'OU qui est destiné à l'utilisateur
function AttributeOU {
    param(
        [string] $OU
    )
    $specificOU = ""
    try {
        Set-Variable -Name "specificOU" -Value ($allOUName[$OU].Name)
    } catch {
        Write-Warning "L'OU ne corresponds pas"
    }
    return $specificOU
}

## Fonction renvoyant le Path de l'OU de l'utilisateur 
function InsertUserInOU {
    param(
        [string] $OU
    )
    $OUUser = AttributeOU -OU $OU
    $domainName = "proxmoxat"
    $DC= "fr"
    $pathToChange = "DC=$domainName,DC=$DC"
    $finallyPath = ""
    try {
        $finallyPath + "OU=" + $OUUser + "," + $pathToChange
        return $finallyPath
    }
    catch {
        Write-Warning "Problème d'OU"
    }
}


<#function RegisterUser {
    $numberUsers = Read-Host -Prompt("Combien d'utilisateur voulez-vous enregistrer ?")
    for($index = 0; $index -le $numberUsers-1; $index++) {
        Write-Output ("A vous l'utilisateur " + ($index+1) + " d'entrer vos informations")
        GetUserInformation
        
    }
}#>

##GetUserInformation
