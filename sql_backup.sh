## To use this, first (and only once) do chmod +x SQL_Backup.sh
## Then execute ./SQL_Backup.sh
##    Enter data as needed, and boom! Done!


##
## Detect what SQL service is being used.
##

IS_MONGO=`$(systemctl is-active --quiet mongod)` ## MONGODB
IS_SQL=`$(systemctl is-active --quiet mysql)` ## MYSQL
IS_MARIA=`$(systemctl is-active --quiet mongod)` ## MARIADB

if [$IS_MONGO == "active"] ## MONGODB
then
  clear
  echo "Enter the database you'd like to backup:"
  read selected_db

  ## Time is so specific it will avoid file overwriting issues.
  today=$(date +"%Y-%m-%d-%I-%S")

  echo "You are about to backup the \"$selected_db\" Mongo DB."

  mongodump --archive=/root/backup/$selected_db-${today}.gz --gzip --db=$selected_db
  echo "Your backup has been saved!"

fi

if [$IS_SQL == "active"] ## MYSQL
then
  clear
  echo "Enter the database you'd like to backup:"
  read selected_db

  ## Time is so specific it will avoid file overwriting issues.
  today=$(date +"%Y-%m-%d-%I-%S")

  mysqldump $selected_db | gzip > /root/backup/$selected_db-${today}.gz
  echo "Your backup has been saved!"
fi
