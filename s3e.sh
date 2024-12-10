#!/bin/bash
#
# s3e.sh v0.1 - Simple Shell Editor (S3E)
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
    echo "            Simple Shell Editor (S3E)                                     "
    echo "=========================================================================="
}

# Main file editor function
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
        echo "4. Save and exit"
        echo "5. Exit without saving"
        echo

        read -rp "Choose an option: " choice

        case "$choice" in
        1) # Add lines
            echo "Enter the lines to add (type 'EOF' on a new line to finish):"
            local new_lines=""
            while IFS= read -r line; do
                [[ "$line" == "EOF" ]] && break
                new_lines+="$line"$'\n'
            done
            echo "$new_lines" >> "$file_path"
            echo "Lines added successfully."
            ;;
        2) # Delete lines
            read -rp "Enter the range of line numbers to delete (e.g., 3-5): " range
            if sed -i "${range}d" "$file_path"; then
                echo "Lines deleted successfully."
            else
                echo "Failed to delete lines. Check the line numbers."
            fi
            ;;
        3) # Replace lines
            read -rp "Enter the range of line numbers to replace (e.g., 2-4): " range
            echo "Enter the new lines to replace the range (type 'EOF' on a new line to finish):"
            local new_text=""
            while IFS= read -r line; do
                [[ "$line" == "EOF" ]] && break
                new_text+="$line"$'\n'
            done
            if sed -i "${range}s/.*/$(echo "$new_text" | sed 's:/:\\/:g')/" "$file_path"; then
                echo "Lines replaced successfully."
            else
                echo "Failed to replace lines. Check the range and input."
            fi
            ;;
        4) # Save and exit
            echo "File saved as: $file_path"
            break
            ;;
        5) # Exit without saving
            echo "Exiting without saving."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
        esac
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
