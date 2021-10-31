## To use this, first (and only once) do chmod +x SQL_Backup.sh
## Then execute ./SQL_Backup.sh
##    Enter data as needed, and boom! Done!

## When moving this to a cronjob/automated task, remember to remove any user-input (not very ideal)
## Instead I'd recommend making a variable = db's you want, or make several crons maybe?

##
## Detect what SQL service is being used.
##

IS_MONGO=`$(systemctl is-active --quiet mongod)` ## MONGODB
IS_SQL=`$(systemctl is-active --quiet mysql)` ## MYSQL
IS_MARIA=`$(systemctl is-active --quiet mongod)` ## MARIADB

if [$IS_MONGO == "active"]
then
  clear
  echo "Enter the database you'd like to backup:"
  read selected_db

  ## Time is so specific it will avoid file overwriting issues.
  today=$(date +"%Y-%m-%d-%I-%S")
  
  echo "You are about to backup the \"$selected_db\" Mongo DB."

  ## Change this directory to match your desited backup location.
  ## Leave selected_db alone here, it's entered by user.
  mongodump --archive=/root/backup/$selected_db-${today}.gz --gzip --db=$selected_db
  echo "Your backup has been saved!"

fi
