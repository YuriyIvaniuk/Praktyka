#!/bin/bash

# Змінні для підключення до бази даних
DB_NAME="Test_DB"

# Інші налаштування
OUTPUT_FILE="dump_$(date +'%Y_%m_%d|%H:%M:%S').sql"
CONFIG_FILE="config.cnf"  # Замініть шлях до конфігураційного файлу

# Створення дампу бази даних
mysqldump --defaults-extra-file="$CONFIG_FILE" "$DB_NAME" > "$OUTPUT_FILE"

# Перевірка результату виконання mysqldump
if [ $? -eq 0 ]; then
    echo "Database dump successful. File saved as: $OUTPUT_FILE"
else
    echo "Error: Database dump failed."
fi
