#!/bin/bash

read -p "MySQL Username : " -r MYSQL_USER

echo "Enter MySQL password"
read -p "MySQL Password : " -r MYSQL_PASS

OUTPUT_FILE="logs.txt"

connect_db() {
	local sql_command="$1"
	echo "SQL COMMAND : $sql_command"
	mysql -u "$MYSQL_USER" -p "$MYSQL_PASS" -e "$sql_command" >> "$OUTPUT_FILE" 2>&1
}

while true 
do 
	read -p "mysql>" -r sql_command
	if [[ "$sql_command" == "exit" ]]
	then
        	echo "Exiting..."
        	break
    	else
		connect_db "$sql_command"
	fi
done




