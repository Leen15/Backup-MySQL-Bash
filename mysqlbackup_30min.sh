#!/bin/sh
# Scripts to create mysql backup every half and hour
 
# Configuration value
mysql_host="localhost"
mysql_database="DB_NAME"
mysql_username="MYSQL_USER"
mysql_password='MYSQL_PASSWORD'
backup_path=DUMP_LOCATION
expired=5			#how many days before the backup directory will be removed
 
today=`date +%Y-%m-%d`
sql_file=$backup_path/$today/$mysql_database-`date +%H%M`.sql
tar_file=$backup_path/$today/$mysql_database-`date +%H%M`.tar.gz
 
if [ ! -d $backup_path/$today ]
then
        mkdir -p $backup_path/$today
        /usr/bin/mysqldump -h $mysql_host -u $mysql_username -p$mysql_password $mysql_database > $sql_file
        tar zcf $tar_file $sql_file
        rm $sql_file
else
        /usr/bin/mysqldump -h $mysql_host -u $mysql_username -p$mysql_password $mysql_database > $sql_file
        tar zcf $tar_file $sql_file
        rm $sql_file
fi
 
# Remove folder which more than 5 days
find $backup_path -type d -mtime +$expired | xargs rm -Rf
