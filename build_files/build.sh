#!/bin/bash

set -ouex pipefail

ROOT_DIRECTORY="/ctx/"

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages
"$ROOT_DIRECTORY/01_base/01_install-packages.sh"

