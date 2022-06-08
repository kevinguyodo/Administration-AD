##Import des fichiers powershell pour l'utilisation de certaines fonctions
. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\creation_user_on_OU_script.ps1"
. "C:\Users\Administrateur\Documents\Script-Admin-gestion-utilisateurs\Create_OU.ps1"

function Menu {
    Write-Host "Bienvenue dans le menu pour gérer les utilisateurs"
    Write-Host "-------------------------------------------------"

    Write-Host "Vous avez le choix entre :"
    Write-Host "1 : Créer un utilisateur"
    Write-Host "2 : Créer une Unité d'organisation"
    $choice = Read-Host -Prompt "Que voulez-vous faire "

    if ($choice -ne "1" -and $choice -ne "2") {
        Write-Host "Vous n'avez pas saisie une bonne valeur veuillez recommencer"
        Menu
    } else {
        if ($choice -eq "1") {
            GetUserInformation
        } else {
            Create_OU
        }
    }
}

Menu