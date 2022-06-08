function Create_OU {
    $OUName = Read-Host -Prompt "Quel nom voulez-vous attribuer à votre OU"
    if ($OUName.Length -eq 0) {
        Write-Host "Vous n'avez pas saisie de nom"
    } else {
        $domainName = "proxmoxat"
        $DC= "fr"
        $path = "DC=$domainName,DC=$DC"
        New-ADOrganizationalUnit -Name $OUName -Path "$path"
    }
}

function Remove_OU {
    $OUName = Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name | Out-String
    Write-Host "Les Unitées d'Organisations présents actuellement sont les suivants"
    Write-Host
    Write-Host $OUName

    $OUToRemove = Read-Host -Prompt "Lequel voulez-vous supprimer (Veuillez entrer le nom de l'OU) ?"


}