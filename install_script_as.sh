#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <script_name> <command_name>"
    exit 1
fi

# Get the script name and command name from the arguments
script_name="$1"
command_name="$2"

# Set the source and destination paths
source_path="$HOME/projects/bash_scripts/${script_name}.sh"
dest_path="/usr/local/bin/$command_name"

# Check if the source script exists
if [ ! -f "$source_path" ]; then
    echo "Error: Script not found at $source_path"
    exit 1
fi

# Copy the script to the destination
sudo cp "$source_path" "$dest_path"

# Make the script executable
sudo chmod +x "$dest_path"

# Create an alias that sources the script
echo "alias $command_name='. $dest_path'" >>"$HOME/.bashrc"

# Source the .bashrc file to make the alias available in the current session
source "$HOME/.bashrc"

echo "Script '$script_name' installed successfully as command '$command_name'."
echo "The alias is now available in this terminal session."
echo "For other open terminals or future sessions, please run 'source ~/.bashrc' or restart the terminal."
