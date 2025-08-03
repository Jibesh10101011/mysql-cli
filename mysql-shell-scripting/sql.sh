echo "Write File Name You Wish to Save Session Data"
echo "eg. File Name : output"
read -p "File Name : " -r FILE_NAME
LOG_FILE="$FILE_NAME.log"
HTML_FILE="$FILE_NAME.html"

echo "<!DOCTYPE html>" > "$HTML_FILE"
echo "<html>" >> "$HTML_FILE"
echo "<head><title>MySQL Session Output</title></head>" >> "$HTML_FILE"
echo "<body>" >> "$HTML_FILE"
echo "<h1>MySQL Session Output</h1>" >> "$HTML_FILE"

CURRENT_DATABASE=""

execute_mysql_command() {
    local sql_command="$1"

    if [[ "$sql_command" =~ ^[Uu][Ss][Ee][[:space:]]+([a-zA-Z0-9_]+)[[:space:]]*\;$ ]]; then
        CURRENT_DATABASE="${BASH_REMATCH[1]}"
        echo "Switching to database: $CURRENT_DATABASE"
        echo "Switched to database: $CURRENT_DATABASE" >> "$LOG_FILE"
        echo "<p><strong>Switched to database:</strong> $CURRENT_DATABASE</p>" >> "$HTML_FILE"
        return
    fi

    if [[ -n "$CURRENT_DATABASE" ]]; then
        sql_command="USE $CURRENT_DATABASE; $sql_command"
    fi

    output=$(mysql --defaults-file="/c/Users/Jibesh/Downloads/mysql-shell/test-dbms/.my.cnf" --table -e "$sql_command" 2>&1)

    if [[ $? -ne 0 ]]; then
        echo "Error: $output"
        echo "Error: $output" >> "$LOG_FILE"
        echo "<p style='color: red;'><strong>Error:</strong> $output</p>" >> "$HTML_FILE"
    else
        echo "$output"
        echo "Command: $sql_command" >> "$LOG_FILE"
        echo "$output" >> "$LOG_FILE"

        echo "<h2>Command: $sql_command</h2>" >> "$HTML_FILE"
        echo "<pre>$output</pre>" >> "$HTML_FILE"
    fi
}


while true; do
    read -p "mysql>" -r sql_command

    if [[ "$sql_command" == "exit" ]]; then
        echo "Exiting..."
        echo "<h3 style='color:green'>Successfully exited</h3>" >> "$HTML_FILE"
        break
    fi

    execute_mysql_command "$sql_command"
done

echo "</body>" >> "$HTML_FILE"
echo "</html>" >> "$HTML_FILE"

echo "Session data saved to $HTML_FILE"
$(start "$FILE_NAME.html")

