#!/bin/bash

# Function to print file contents with filename as comment
print_file_contents() {
    local file="$1"
    echo "# File: $file"
    echo "------------------------"
    cat "$file"
    echo -e "\n------------------------\n"
}

# Check if a directory is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Change to the specified directory
cd "$1" || exit 1

# Print directory structure
echo "Directory Structure:"
tree -L 5

echo -e "\nFile Contents:"

# Iterate through all files in the directory and subdirectories
while IFS= read -r -d '' file; do
    # Check if it's a regular file (not a directory)
    if [ -f "$file" ]; then
        print_file_contents "$file"
    fi
done < <(find . -type f -print0)
