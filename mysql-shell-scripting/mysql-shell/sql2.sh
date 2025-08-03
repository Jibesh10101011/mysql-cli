echo "Write File Name You Wish to Save Session Data"
echo "eg. File Name : output"
read -p "File Name : " -r FILE_NAME
LOG_FILE="$FILE_NAME.log"
HTML_FILE="$FILE_NAME.html"

# Initialize the HTML file
echo "<!DOCTYPE html>" > "$HTML_FILE"
echo "<html>" >> "$HTML_FILE"
echo "<head><title>MySQL Session Output</title></head>" >> "$HTML_FILE"
echo "<body>" >> "$HTML_FILE"
echo "<h1>MySQL Session Output</h1>" >> "$HTML_FILE"

# Variable to store the current database
CURRENT_DATABASE=""

# Function to execute MySQL commands
execute_mysql_command() {
    local sql_command="$1"
    command="$sql_command"
    # Check if the command starts with "USE" and ends with a semicolon
    if [[ "$sql_command" =~ ^[Uu][Ss][Ee][[:space:]]+([a-zA-Z0-9_]+)[[:space:]]*\;$ ]]; then
        # Extract the database name (without the trailing semicolon)
        CURRENT_DATABASE="${BASH_REMATCH[1]}"
        echo "Switching to database: $CURRENT_DATABASE"
        echo "Switched to database: $CURRENT_DATABASE" >> "$LOG_FILE"
        echo "<p><strong>Switched to database:</strong> $CURRENT_DATABASE</p>" >> "$HTML_FILE"
        return
    fi

    # If a database is selected, prepend the "USE database;" statement
    if [[ -n "$CURRENT_DATABASE" ]]; then
        sql_command="USE $CURRENT_DATABASE; $sql_command"
    fi

    # Execute the MySQL command and capture output
    output=$(mysql --defaults-file="/c/Users/Jibesh/Downloads/mysql-shell/.my.cnf" --table -e "$sql_command" 2>&1)

    # Check for errors and handle them
    if [[ $? -ne 0 ]]; then
        echo "Error: $output"
        echo "Error: $output" >> "$LOG_FILE"
        echo "<p style='color: red;'><strong>Error:</strong> $output</p>" >> "$HTML_FILE"
    else
        echo "$output"
        echo "Command: $command" >> "$LOG_FILE"
        echo "$output" >> "$LOG_FILE"

        # Append command and output to HTML file
        echo "<h2>Command: $command</h2>" >> "$HTML_FILE"
        echo "<pre>$output</pre>" >> "$HTML_FILE"
    fi
}

# Main loop to process user commands
while true; do
    read -p "mysql>" -r sql_command

    # Exit the loop if user types "exit"
    if [[ "$sql_command" == "exit" ]]; then
        echo "Exiting..."
	echo "<h3 style='color:green;'> Successfully exited </h3>" >> "$HTML_FILE"
        break
    fi

    # Execute the MySQL command
    execute_mysql_command "$sql_command"
done

# Finalize the HTML file
echo "</body>" >> "$HTML_FILE"
echo "</html>" >> "$HTML_FILE"

echo "Session data saved to $HTML_FILE"
$(start "$FILE_NAME.html")
