#!/bin/bash
USER="username"
PASSWORD="password"
HOST=$1
backup_to="/backup-data/$1/db/"

if [ ! -d $backup_to ]; then
  mkdir -p $backup_to
fi

dt=`date +"%Y%m%d"`
#rm "$backup_toDIR/*gz" > /dev/null 2>&1
databases=`mysql -h $HOST -u $USER -p$PASSWORD -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump -h $HOST -u $USER -p$PASSWORD --databases $db > $backup_to$db-$dt.sql
       # gzip $backup_to/`date +%Y%m%d`.$db.sql
    fi
done
find $backup_to/* -mtime +30 -exec rm {} \;
