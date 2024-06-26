#!/bin/bash

#Empêche l'enregistrement dans l'historique des commandes
set -o nohist

# Définir les variables pour la base de données
DB_USER="ulab_user"
DB_PASSWORD="$2"
DB_NAME="ulab"
BACKUP_DIR="/mnt/bali-nas/save"
DB_HOST=$(hostname)
LOG_FILE="/var/log/ulab_db_save.log"

# Nom du fichier de sauvegarde, incluant la date et l'heure actuelle
BACKUP_FILE=${DB_HOST}_${DB_NAME}_$(date +%Y-%m-%d_%H-%M-%S).sql
BACKUP_FILE_ENC="${BACKUP_FILE}.enc"
BACKUP_FILE_ENC_PASS="$1"
# Utiliser mysqldump pour sauvegarder la base de données
mysqldump --user=${DB_USER} --password=${DB_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/${BACKUP_FILE}

# Vérifier si la sauvegarde a réussi
if [ $? -eq 0 ]; then
    echo -e "$(date)" >> $LOG_FILE

    openssl enc -aes-256-ctr -in ${BACKUP_DIR}/${BACKUP_FILE} -out ${BACKUP_DIR}/${BACKUP_FILE_ENC} -pass pass:$BACKUP_FILE_ENC_PASS

    if [ -f ${BACKUP_DIR}/${BACKUP_FILE_ENC} ]; then
    	echo -e "Chiffrement de la sauvegarde réussi : ${BACKUP_DIR}/${BACKUP_FILE_ENC}" >> $LOG_FILE
    	rm -f ${BACKUP_DIR}/${BACKUP_FILE}
    else
        echo -e "Sauvegarde réussie : ${BACKUP_DIR}/${BACKUP_FILE}" >> $LOG_FILE
    fi
    exit 0
else
    echo -e "$(date)" >> $LOG_FILE
    echo "ERREUR : La sauvegarde a échoué" >> $LOG_FILE
    exit 1
fi
