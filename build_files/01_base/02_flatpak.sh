#!/bin/bash

set -ouex pipefail

# Remove Fedora flatpak, add FlatHub
dnf5 remove -y fedora-flathub-remote

# Add FlatHub
mkdir -p /etc/flatpak/remotes.d
curl --retry 3 -Lo /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo

# Replace service
mv -f /usr/lib/systemd/system/flatpak-add-flathub-repos.service /usr/lib/systemd/system/flatpak-add-fedora-repos.service
