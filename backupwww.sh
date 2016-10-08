#!/bin/sh
remote_folder="/var/www/"
local_tmp=/backup-data/tmp/
backup_to=/backup-data/$1/www/

if [ ! -d "$backup_to" ]; then
  mkdir -p $backup_to
fi
host=$1
rsync -chavzP --stats root@$host:$remote_folder $local_tmp

# Check and create backup directory
backup_name=www-`date +%Y_%m_%d`.tar.gz
tar -zcvf $backup_name $local_tmp
mv $backup_name $backup_to
rm -rf /backup-data/tmp/*
find $backup_to/* -mtime +10 -exec rm {} \;
