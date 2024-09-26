#!/bin/bash

switch_venv() {
    # Check if an argument is provided
    if [ $# -eq 0 ]; then
        echo "Usage: switch_venv <venv_name>" >&2
        return 1
    fi

    # Get the venv name from the first argument
    local venv_name="$1"

    # Check if SWITCH_ENV_PATH_TEMPLATE is set, otherwise use default
    if [ -n "$SWITCH_ENV_PATH_TEMPLATE" ]; then
        # Replace {venv_name} with the actual venv name
        local venv_path="${SWITCH_ENV_PATH_TEMPLATE/\{venv_name\}/$venv_name}"
    else
        # Use default convention
        local venv_path="$HOME/venvs/${venv_name}_venv/bin/activate"
    fi

    # Check if the virtual environment exists
    if [ ! -f "$venv_path" ]; then
        echo "Error: Virtual environment not found at $venv_path" >&2
        return 1
    fi

    # Activate the virtual environment
    echo "Activating virtual environment: $venv_path"
    source "$venv_path"

    # Print the current Python interpreter path
    echo "Python interpreter: $(which python)"
}

# Check if the script is being sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # Script is being sourced, so we can define the function
    switch_venv "$@"
else
    # Script is being executed, so we should print an error
    echo "Error: This script should be sourced, not executed." >&2
    echo "Usage: source $0" >&2
    exit 1
fi
