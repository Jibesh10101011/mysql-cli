#!/bin/bash

# Log file to store MySQL outputs
LOG_FILE="mysql_commands.log"

# Variable to store the current database
CURRENT_DATABASE=""

# Function to execute MySQL commands
execute_mysql_command() {
    local sql_command="$1"

    # Check if the command starts with "USE"
    if [[ "$sql_command" =~ ^USE[[:space:]]+([a-zA-Z0-9_]+)[[:space:]]*;$ ]]; then
        # Extract the database name
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
    output=$(mysql --defaults-file=~/.my.cnf -e "$sql_command" 2>&1)

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
    echo "Enter your MySQL command (or type 'exit' to quit):"
    read -r sql_command

    # Exit the loop if user types "exit"
    if [[ "$sql_command" == "exit" ]]; then
        echo "Exiting..."
        break
    fi

    # Execute the MySQL command
    execute_mysql_command "$sql_command"
done

