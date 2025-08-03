#!/bin/bash

# Log file to store MySQL outputs
echo "Write File Name You Wish to save session Data"
echo "eg. File Name : output"
read -p "File Name : " -r FILE_NAME
LOG_FILE="$FILE_NAME.log"

# Variable to store the current database
CURRENT_DATABASE=""

# Function to execute MySQL commands
execute_mysql_command() {
    local sql_command="$1"

    # Check if the command starts with "USE" and ends with a semicolon
    if [[ "$sql_command" =~ ^[Uu][Ss][Ee][[:space:]]+([a-zA-Z0-9_]+)[[:space:]]*\;$ ]]; then
        # Extract the database name (without the trailing semicolon)
        CURRENT_DATABASE="${BASH_REMATCH[1]}"
        echo "Switching to database: $CURRENT_DATABASE"
        echo "Switched to database: $CURRENT_DATABASE" >> "$LOG_FILE"
        return
    fi

    # If a database is selected, prepend the "USE database;" statement
    if [[ -n "$CURRENT_DATABASE" ]]; then
        sql_command="USE $CURRENT_DATABASE; $sql_command"
    fi

    # Execute the MySQL command and capture output
    output=$(mysql --defaults-file=~/.my.cnf --table -e "$sql_command" 2>&1)

    # Check for errors and handle them
    if [[ $? -ne 0 ]]; then
        echo "Error: $output"
        echo "Error: $output" >> "$LOG_FILE"
    else
        echo "$output"
        echo "Command: $sql_command" >> "$LOG_FILE"
        echo "$output" >> "$LOG_FILE"
    fi
}

# Main loop to process user commands
while true; do
    read -p "mysql>" -r sql_command

    # Exit the loop if user types "exit"
    if [[ "$sql_command" == "exit" ]]; then
        echo "Exiting..."
        break
    fi

    # Execute the MySQL command
    execute_mysql_command "$sql_command"
done


