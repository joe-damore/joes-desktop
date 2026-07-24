#!/bin/bash

set -ouex pipefail

# Install dnf5 if not installed
if ! rpm -q dnf5 >/dev/null; then
  rpm-ostree install dnf5 dnf5-plugins
fi

# Enable RPMFusion
dnf5 -y install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

# Add Universal Blue COPRs
dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable ublue-os/staging

# Install ublue-os packages,fedora archives, and zstd
dnf5 -y install \
  ublue-os-luks \
  ublue-os-signing \
  ublue-os-udev-rules \
  fedora-repos-archive \
  zstd

# Replace podman provided policy.json with ublue-os one.
mv /usr/etc/containers/policy.json /etc/containers/policy.json
