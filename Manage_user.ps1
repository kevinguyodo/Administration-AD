. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\creation_user_on_OU_script.ps1"

function RemoveUser {
    Write-Host "Cette fonction supprime un utilisateur"
}

function MoveUserOU {

    Write-Host "Les utilisateurs présents dans l'AD sont les suivants :"
    $SamAccountName = Get-ADUser -Filter * | Select SamAccountName, DistinguishedName
    for ($index = 0; $index -le ($SamAccountName.Length-1); $index++) {
        Write-Host $index " : " $SamAccountName[$index].SamAccountName ($SamAccountName[$index].DistinguishedName -split ",",3)[1]
    }
    $OU = SelectOU -str "qui sera la nouvelle de l'utilisateur"
    $NewOUPath = GetOUPath -OU $OU
   $IdUser = Read-Host -Prompt "Saisir le numéro d'utilisateur à déplacer"
   $IdUser = $IdUser -as [int]
   Get-ADUser -Identity $SamAccountName[$IdUser].SamAccountName | Move-ADObject -TargetPath "$NewOUPath"
   Write-Host $SamAccountName[$IdUser].SamAccountName " a été bougé dans " $NewOUPath "`n"
   ExitOrContinueProgram
    

}
