#!/bin/bash

set -ouex pipefail

ROOT_DIRECTORY="/ctx/"

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages
"$ROOT_DIRECTORY/01_base/01_setup.sh"
"$ROOT_DIRECTORY/01_base/02_flatpak.sh"
"$ROOT_DIRECTORY/01_base/03_core-packages.sh"
