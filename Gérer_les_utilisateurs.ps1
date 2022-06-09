##Import des fichiers powershell pour l'utilisation de certaines fonctions
. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\creation_user_on_OU_script.ps1"
. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\Create_OU.ps1"

function Main {
    Write-Host "`n-------------------------------------------------"
    Write-Host "Bienvenue dans le menu pour gÃ©rer les utilisateurs"
    Write-Host "-------------------------------------------------`n"

    Write-Host "Vous avez le choix entre :"
    Write-Host "1 : CrÃ©er un utilisateur"
    Write-Host "2 : CrÃ©er une UnitÃ© d'Organisation"
    Write-Host "3 : Changer un utilisateur d'UnitÃ© d'Organisation"
    Write-Host "4 : Supprimer une Unité d'Organisation"
    $choice = Read-Host -Prompt "Que voulez-vous faire "
    $choiceInt
    try {
        if ($choice.Length -gt 0) {
            $choiceInt = $choice -as [int]
        } else {
            Main
        }
        Write-Host $test
        if ($choiceInt -lt 1 -and $choiceInt -gt 4) {
            Write-Host "Vous n'avez pas saisie une bonne valeur veuillez recommencer`n"
            Main
        } else {
            if ($choiceInt -eq 1) {
                GetUserInformation
            } elseif ($choiceInt -eq 2){
                CreateOU
            } elseif ($choiceInt -eq 3) {
                Write-Host "Changer l'utilisateur"
            } else {
                RemoveOU
            }
        }
    } 
    catch {
        Write-Warning $_
        Write-Warning "Veuillez rÃ©essayer en entrant une bonne valeur"
        Main
    }
}

Main

