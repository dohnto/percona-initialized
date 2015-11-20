#!/bin/bash
set -e

MYSQL=${MYSQL:-mysql}

SQL_DIR=$1

if [ "$SQL_DIR" = "" ]; then
    echo "You must specify sql directory!"
    exit 1
fi

for file in $(ls $SQL_DIR/*.sql | sort -n); do
    echo "Importing file: '$file'"
    $MYSQL < "$file"
done

echo "Finished importing."
