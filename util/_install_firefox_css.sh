#!/usr/bin/env bash
# DESC: Given a folder containing user CSS, installs it to all Mozilla
# Firefox profiles.
# ARGS: $1 (required): Folder containing userChrome.css and/or userContent.css

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

# -----------------------------
# HELPER FUNCTIONS
# -----------------------------
# DESC: Handler for unexpected errors
# ARGS: $1 (optional): Exit code (defaults to 1)
function script_trap_err() {
    # Disable the error trap handler to prevent potential recursion
    trap - ERR

    # Consider any further errors non-fatal to ensure we run to completion
    set +o errexit
    set +o pipefail

    # Exit with failure status
    if [[ $# -eq 1 && $1 =~ ^[0-9]+$ ]]; then
        exit "$1"
    else
        exit 1
    fi
}

# DESC: Exit script with the given message
# ARGS: $1 (required): Message to print on exit
#       $2 (optional): Exit code (defaults to 0)
function script_exit() {
    if [[ $# -eq 1 ]]; then
        printf '%s\n' "$1"
        exit 0
    fi

    if [[ $# -eq 2 && $2 =~ ^[0-9]+$ ]]; then
        printf '%b\n' "$1"
        # If we've been provided a non-zero exit code run the error trap
        if [[ $2 -ne 0 ]]; then
            script_trap_err "$2"
        else
            exit 0
        fi
    fi

    script_exit "Invalid arguments passed to script_exit()!" 2
}

# DESC: Generic script initialisation
# ARGS: None
function script_init() {
    # Useful paths
    readonly orig_cwd="$PWD"
    readonly script_path="${BASH_SOURCE[0]}"
    readonly script_dir="$(dirname "$script_path")"
    readonly script_name="$(basename "$script_path")"
}
# -----------------------------

# Ensure we've received a valid folder as the first argument
if [[ $# -eq 1 ]]; then
    [[ -d "$1" ]] || script_exit "Argument \"$1\" was not a valid folder. Ensure this script is being run from the same directory as install.sh" 2
else
    script_exit "Incorrect number of arguments passed. Expected 1, received $#" 2
fi

script_init

# userChrome.css needs to be in the following folder structure:
# $HOME/.mozilla/firefox/<something>.default/chrome/userChrome.css

readonly base_dir="$HOME/.mozilla/firefox"
mkdir -p "$base_dir" || script_exit "Failed to create $base_dir" 1

# For each profile
for i in "$base_dir/"*.default; do
    # Remove old CSS
    if [[ -d "$i/chrome" ]]; then
        echo "  Found old CSS folder in $i, deleting..."
        rm -r "$i/chrome" || script_exit "Unable to delete old userChrome.css and userContent.css from $i" 1
    fi
    
    # Replace with first argument to program, which should be a folder
    # containing the new CSS
    ln -sf "$1" "$i/chrome" || script_exit "Failed to link new userChrome.css and userContent.css to $i/chrome" 1
done

# Patch userChrome.css to use the correct username
readonly user_chrome="$1"/userChrome.css
readonly replacement_import="@import url(\'file://$HOME/.cache/wal/firefox.css\');"
sed -i "1s|.*|$replacement_import|" "$user_chrome"

script_exit "Successfully installed contents of $1 to all profiles in $base_dir" 0
