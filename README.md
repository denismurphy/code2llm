# Code2LLM

Code2LLM is a bash script designed to capture both the structure and content of your code into a single file for processing by an LLM.

## Features

- Generates a tree structure of your project directory
- Outputs the content of each file with the filename as a comment
- Customizable depth for directory structure (default: 5 levels)
- Easy to use with any project directory

## Installation

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/code2llm.git
   ```

2. Navigate to the cloned directory:
   ```
   cd code2llm
   ```

3. Make the script executable:
   ```
   chmod +x code2llm.sh
   ```

## Usage

Run the script with your project directory as an argument:

```
./code2llm.sh /path/to/your/project
```

This will output the directory structure and the contents of each file in the specified project directory.

## Output Format

The script generates output in the following format:

1. Directory structure (up to 5 levels deep by default)
2. For each file:
   - Filename as a comment
   - File contents
   - Separator between files

Example output:

```
Directory Structure:
.
├── src
│   ├── main.py
│   └── utils.py
└── tests
    └── test_main.py

File Contents:
# File: ./src/main.py
------------------------
def main():
    print("Hello, World!")

if __name__ == "__main__":
    main()
------------------------

# File: ./src/utils.py
------------------------
def helper_function():
    return "I'm helping!"
------------------------

...
```

## Customization

You can modify the script to:

- Change the depth of the directory structure by altering the `-L` option in the `tree` command
- Add filters for specific file types
- Exclude certain directories or files
- Implement size limits for large files

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
