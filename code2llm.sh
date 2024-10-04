#!/bin/bash

# Function to check if a file is text
is_text_file() {
    local file="$1"
    local mime_type=$(file -b --mime-type "$file")
    [[ $mime_type == text/* || $mime_type == application/json || $mime_type == application/xml ]]
}

# Function to print file contents with filename as comment
print_file_contents() {
    local file="$1"
    echo "# File: $file"
    echo "------------------------"
    cat "$file"
    echo -e "\n------------------------\n"
}

# Function to check if a file matches the pattern
matches_pattern() {
    local file="$1"
    local patterns="$2"
    IFS='|' read -ra ADDR <<< "$patterns"
    for i in "${ADDR[@]}"; do
        if [[ $file == *$i ]]; then
            return 0
        fi
    done
    return 1
}

# Initialize variables
directory=""
pattern=""

# Parse command line options
while getopts ":P:d:" opt; do
  case $opt in
    P) pattern="$OPTARG"
    ;;
    d) directory="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac
done

# Check if a directory is provided
if [ -z "$directory" ]; then
    echo "Usage: $0 -d <directory> [-P <pattern1>|<pattern2>|...]"
    exit 1
fi

# Change to the specified directory
cd "$directory" || exit 1

# Print directory structure
echo "Directory Structure:"
if [ -n "$pattern" ]; then
    tree -L 10 -P "${pattern//|/ }"
else
    tree -L 10
fi

echo -e "\nFile Contents:"

# Iterate through all files in the directory and subdirectories
while IFS= read -r -d '' file; do
    # Check if it's a regular file (not a directory), a text file, and matches the pattern (if provided)
    if [ -f "$file" ] && is_text_file "$file" && { [ -z "$pattern" ] || matches_pattern "$file" "$pattern"; }; then
        print_file_contents "$file"
    fi
done < <(find . -type f -print0)