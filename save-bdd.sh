#!/bin/bash

backups="/var/backups/mysql"

mkdir -p $backups

file="$backups/db_backup_$(date +%Y-%m-%d).sql"

read -p "Entrez le nom d'utilisateur MySQL : " user
read -s -p "Entrez le mot de passe MySQL : " pwd
echo
read -p "Entrez le nom de la base de données MySQL : " nom

# Sauvegarde
mysqldump -u$user -p$pwd $nom > $file

if [ $? -eq 0 ]; then
    echo "Sauvegarde bdd réussie : $file"
else
    echo "Échec de la sauve."
fi
