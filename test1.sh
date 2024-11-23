#!/bin/bash

mysql_connect() {
    local sql_command="$1"
#    output=$(mysql "$MYSQL_DB" -e "$sql_command" 2>&1)
    output=$(mysql --defaults-file=~/.my.cnf -e "$sql_command" 2>&1)
    echo "$output"
    "$output" >> "test01.log"
}


while true; do
    read -p "mysql>" -r sql_command

    if [[ "$sql_command" == "exit" ]]; then
        echo "Exiting..."
        break
    fi

    mysql_connect "$sql_command"
done
