. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\creation_user_on_OU_script.ps1"

function CreateOU {
    $OUName = Read-Host -Prompt "Quel nom voulez-vous attribuer à votre OU"
    if ($OUName.Length -eq 0) {
        Write-Host "Vous n'avez pas saisie de nom"
    } else {
        $domainName = "proxmoxat"
        $DC= "fr"
        $path = "DC=$domainName,DC=$DC"
        New-ADOrganizationalUnit -Name $OUName -Path "$path"
        Write-Host "`n Votre OU $OUName à bien été créée`n"
        ExitOrContinueProgram
    }
}

function RemoveOU {
    $OU = SelectOU -str "que vous voulez supprimer"
    $OUPath = GetOUPath -OU $OU

    ## Il faut déprotéger l'Unité d'Organisation avant de la supprimer, sinon accès refusé
    Get-ADOrganizationalUnit -Identity "$OUPath" | Set-ADOrganizationalUnit –ProtectedFromAccidentalDeletion $false

    Remove-ADOrganizationalUnit -Identity "$OUPath" -Recursive

    ExitOrContinueProgram
}
