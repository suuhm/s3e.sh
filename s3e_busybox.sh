#!/bin/sh

# S3E v0.3 - Simple Shell Editor (S3E)
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
    echo "                Ultra Simple Shell Editor (U_S3E)                         "
    echo "                BusyBox _ Embedded Edition (c) 2024 by suuhm              "
    echo "=========================================================================="
}

file_editor() {
    file_path="$1"
    # Without saving in progress:
    # tmp_file=`cat $file_path`
    while true; do
        clear
        display_banner
        echo; echo "Editing file: $file_path"
        echo "---------------------------------"
        cat -n "$file_path" 2>/dev/null || cat_n "$file_path" 2>/dev/null || echo "(File does not exist yet)"
        echo "---------------------------------"
        echo "Options:"
        echo "1. Add lines"
        echo "2. Delete lines"
        echo "3. Replace lines"
        echo "4. Save and exit"
        echo "5. Exit without saving"
        echo
        printf "Choose an option: "
        read choice

        case "$choice" in
        1) # Add lines
            echo "Enter the lines to add (type 'EOF' on a new line to finish):"
            new_lines=""
            while true; do
                read line
                [ "$line" = "EOF" ] && break
                new_lines="${new_lines}${line}\n"
            done
            printf "%b" "$new_lines" >> "$file_path"
            echo "Lines added successfully."
            ;;
        2) # Delete lines
            printf "Enter the range of line numbers to delete (e.g., 3-5): "
            read range
            # Adding Posix compartible \.+ replacements
            if echo "$range" | grep -q '^[0-9]\{1,\}-[0-9]\{1,\}$'; then
                start_line=$(echo "$range" | cut -d- -f1)
                end_line=$(echo "$range" | cut -d- -f2)
                sed -i "${start_line},${end_line}d" "$file_path"
                # tmp_file = $(sed "${start_line},${end_line}d" "$file_path")
                echo "Lines $start_line to $end_line deleted successfully."
            else
                echo "Invalid range. Please use the format start-end (e.g., 2-5)."
            fi
            ;;
        3) # Replace lines
            printf "Enter the range of line numbers to replace (e.g., 2-4): "
            read range
            if echo "$range" | grep -q '^[0-9]\{1,\}-[0-9]\{1,\}$'; then
                start_line=$(echo "$range" | cut -d- -f1)
                end_line=$(echo "$range" | cut -d- -f2)
                echo "Enter the new lines to replace the range (type 'EOF' on a new line to finish):"
                new_text=""
                while true; do
                    read line
                    [ "$line" = "EOF" ] && break
                    new_text="${new_text}${line}\n"
                done
                sed -i "${start_line},${end_line}d" "$file_path"
                tmp_file = $(sed "${start_line},${end_line}d" "$file_path")
                sed "${start_line}q" "$file_path" | (
                    cat
                    printf "%b" "$new_text"
                ) > temp_file
                tail -n +$((start_line + 1)) "$file_path" >> temp_file
                mv temp_file "$file_path"
                echo "Lines $start_line to $end_line replaced successfully."
            else
                echo "Invalid range. Please use the format start-end (e.g., 2-4)."
            fi
            ;;
        4) 
            echo "File saved as: $file_path"
            break
            ;;
        5) 
            echo "Exiting without saving. (WiP)"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
        esac
    done
}

# cat -n alternative functon
cat_n() {
    file_path="$1"
    if [ ! -f "$file_path" ]; then
        echo "(File does not exist yet)"
        return
    fi

    line_num=1
    while IFS= read -r line; do
        printf "%4d  %s\n" "$line_num" "$line"
        line_num=$((line_num + 1))
    done < "$file_path"
}

if [ -z "$1" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

touch "$1"
file_editor "$1"
