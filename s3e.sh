#!/bin/bash
#
# s3e.sh v0.2 - Simple Shell Editor (S3E)
#
# (c) 2024 by suuhmer
#

display_banner() {
    echo "=========================================================================="
    echo ""
    echo " ░▒▓███████▓▒░▒▓███████▓▒░░▒▓████████▓▒░       ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░ "
    echo "░▒▓█▓▒░             ░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ "
    echo "░▒▓█▓▒░             ░▒▓█▓▒░▒▓█▓▒░             ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ "
    echo " ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓██████▓▒░         ░▒▓██████▓▒░░▒▓████████▓▒░ "
    echo "       ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░                    ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
    echo "       ░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░      ░▒▓██▓▒░      ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ "
    echo "░▒▓███████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓██▓▒░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo "                                                                          "
    echo "                                                                          "
    echo ""
    echo "=========================================================================="
    echo "            Simple Shell Editor (S3E)  - (c) 2024 by suuhmer              "
    echo "=========================================================================="
}

file_editor() {
    local file_path="$1"
    while true; do
        clear
        display_banner
        echo "Editing file: $file_path"
        echo "---------------------------------"
        cat -n "$file_path" 2>/dev/null || echo "(File does not exist yet)"
        echo "---------------------------------"
        echo "Options:"
        echo "1. Add lines"
        echo "2. Delete lines"
        echo "3. Replace lines"
        echo "4. Insert lines"
        echo "5. Save and exit"
        echo "6. Exit without saving"
        echo

        read -rp "Choose an option: " choice

        case "$choice" in
        1) # Add lines at EOF
            echo "Enter the lines to add at the end (type 'EOF' on a new line to finish):"
            local new_lines=""
            while IFS= read -r line; do
                [[ "$line" == "EOF" ]] && break
                new_lines+="${line}\n"
            done
            printf "%b" "$new_lines" >> "$file_path"
            echo "Lines added successfully."
            ;;
        2) # Delete lines
            read -rp "Enter the range of line numbers to delete (e.g., 3-5 or 4-4 for just line 4): " range
            if echo "$range" | grep -qE '^[0-9]+-[0-9]+$'; then
                start_line=$(echo "$range" | cut -d- -f1)
                end_line=$(echo "$range" | cut -d- -f2)
                sed -i.bak "${start_line},${end_line}d" "$file_path"
                echo "Lines $start_line to $end_line deleted successfully."
            else
                echo "Invalid range. Please use the format start-end (e.g., 2-112 or 4-4 for just line 4)."
            fi
            ;;
        3) # Replace lines
            read -rp "Enter the range of line numbers to replace (e.g., 2-4 or 4-4 for just line 4): " range
            if echo "$range" | grep -qE '^[0-9]+-[0-9]+$'; then
                start_line=$(echo "$range" | cut -d- -f1)
                end_line=$(echo "$range" | cut -d- -f2)
                echo "Enter the new lines to replace the range (type 'EOF' on a new line to finish):"
                local new_text=""
                while IFS= read -r line; do
                    [[ "$line" == "EOF" ]] && break
                    new_text+="${line}\n"
                done
                sed -i.bak "${start_line},${end_line}d" "$file_path"
                awk -v n="$start_line" -v txt="$new_text" 'NR==n{printf "%s", txt}1' "$file_path" > temp_file
                mv temp_file "$file_path"
                echo "Lines $start_line to $end_line replaced successfully."
            else
                echo "Invalid range. Please use the format start-end (e.g., 2-112)."
            fi
            ;;
        4) # Insert lines at a specific position
            read -rp "Enter the line number where you want to insert lines: " line_number
            if ! [[ "$line_number" =~ ^[0-9]+$ ]]; then
                echo "Invalid input. Please enter a valid number."
                continue
            fi
            echo "Enter the lines to insert at line $line_number (type 'EOF' to finish):"
            local insert_text=""
            while IFS= read -r line; do
                [[ "$line" == "EOF" ]] && break
                insert_text+="${line}\n"
            done
            awk -v n="$line_number" -v txt="$insert_text" 'NR==n{printf "%s", txt}1' "$file_path" > temp_file
            mv temp_file "$file_path"
            echo "Lines inserted successfully at line $line_number."
            ;;
        5) # Save and exit
            echo "File saved as: $file_path"
            break
            ;;
        6) # Exit without saving
            echo "Exiting without saving."
            rm $file_path 2>/dev/null
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
        esac

        read -rp "Press Enter to continue..."
    done
}

# Check if file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Create an empty file if it doesn't exist
touch "$1"
file_editor "$1"
