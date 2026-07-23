#!/bin/bash

set -ouex pipefail

# Install base packages
dnf5 -y install \
  @virtualization \
  ansible \
  bluez \
  container-selinux \
  direnv \
  fastfetch \
  fira-code-fonts \
  gparted \
  helix \
  kitty \
  nix \
  nix-daemon \
  papirus-icon-theme \
  podman-compose \
  rsms-inter-fonts \
  tmux \
  zsh

# Install mise-en-place
dnf5 -y copr enable jdxcode/mise
dnf5 -y install mise
dnf5 -y copr disable jdxcode/mise

# Enable Tailscale GPG key to faciliate installation of Tailscale, but do not
# actually install it.
dnf5 -y config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

# Enable RPMFusion
dnf5 -y install \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1

# Make nix directories
mkdir -p /nix
mkdir -p /var/nix

# Enable systemd services
systemctl enable podman.socket
systemctl enable libvirtd
systemctl enable bluetooth
systemctl enable nix.mount
systemctl enable nix-daemon
