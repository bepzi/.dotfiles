#!/usr/bin/env bash
# Script to launch cbatticon if and only if:
# - cbatticon is present on the system
# - cbatticon detects a battery or AC system (i.e, not running on a desktop)

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
#set -o xtrace          # Trace the execution of the script (debug)

if ! command -v cbatticon >/dev/null 2>&1; then
    # `cbatticon` not available, bail silently
    exit 0
fi

# Kill old instances, silently
killall -q cbatticon || true

readonly low_level=25
readonly critical_level=10
readonly update_interval=10  # seconds

if cbatticon -p | grep "Battery" || cbatticon -p | grep "AC"; then
    cbatticon -l $low_level -r $critical_level -u $update_interval &
fi
