#!/bin/bash

# Configuration
DB_USER="root"
DB_PASS=""
OUTPUT_DIR="/root/dbs" # The folder where your database sql files will be saved

# Check if the output directory exists; if not, create it
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# Retrieve the list of databases
databases=$(mysql -u"$DB_USER" -p"$DB_PASS" -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema|mysql)")

# Loop through each database and perform a SQL dump into separate files
for db in $databases; do
    mysqldump -u"$DB_USER" -p"$DB_PASS" --databases "$db" > "$OUTPUT_DIR/$db.sql"
done

echo "Export completed in $OUTPUT_DIR"
