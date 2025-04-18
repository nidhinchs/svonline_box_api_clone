#!/bin/bash


DB_USER="your_username"
DB_PASS="your_password"
DB_HOST="your_mysql_host"  # something like db-mysql-nyc3-12345-do-user-1234567-0.b.db.ondigitalocean.com
DB_NAME="your_database"
DB_PORT=25060  # default port for DO managed MySQL
BACKUP_DIR="/Users/yourname/Backups"  # your local drive path
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# ✅ Output file
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_$DATE.sql"

# ✅ Create backup
echo "Starting backup for $DB_NAME..."
mysqldump -u$DB_USER -p$DB_PASS -h$DB_HOST -P$DB_PORT --ssl-mode=REQUIRED $DB_NAME > "$BACKUP_FILE"

# ✅ Confirm
if [ $? -eq 0 ]; then
  echo "✅ Backup successful: $BACKUP_FILE"
else
  echo "❌ Backup failed!"
fi
