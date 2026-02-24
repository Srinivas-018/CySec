#!/bin/bash

#menu options
while true; do
    echo ""
    echo "FILE AND DIRECTORY MANAGER"
    echo "1. List files in current directory"
    echo "2. Create a new directory"
    echo "3. Create a new file"
    echo "4. Delete a file"
    echo "5. Rename a file"
    echo "6. Search for a file"
    echo "7. Count files and directories"
    echo "8. Check file permissions"
    echo "9. copy a files"
    echo "10.Exit"
    echo ""
    read -r -p "Enter your choice: " choice

    case $choice in
        1) printf "\n"; ls; printf "\n";;
        2) read -r -p "Enter directory name: " dirname; 
        if [ -d "$dirname" ]; then
            echo "Directory already exists"
        else
            mkdir "$dirname"
        fi ;;
        3) read -r -p "Enter file name: " filename; 
        if [ -f "$filename" ]; then
            echo "File already exists"
        else
            touch "$filename"
        fi ;;
        4) ls; read -r -p "Enter file name to delete: " filename;
        if [ -f "$filename" ]; then
            rm "$filename"
        else
            echo "File does not exist"
        fi ;;
        5) ls; read -r -p "Enter current file name: " oldname; 
            read -r -p "Enter new file name: " newname; mv "$oldname" "$newname" ;;
        6) read -r -p "Enter file name to search: " searchname; find . -name "$searchname" ;;
        7) echo "Files: $(find . -type f | wc -l), Directories: $(find . -type d | wc -l)" ;;
        8) ls -l; read -r -p "Enter file name to check permissions: " permfile; 
            stat "$permfile" ;;
        9) ls; read -r -p "Enter file name to copy: " srcfile; 
            read -r -p "Enter destination file name: " destfile; cp "$srcfile" "$destfile" ;;
        10) echo "Exiting..."; break ;; 
        *) echo "Invalid choice, please try again." ;;
    esac
done