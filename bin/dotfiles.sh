#!/bin/bash
set -e

# Usage: ./dotfiles.sh <ansible_dir> <dotfiles_dir>

ANSIBLE_DIR=$1
DOTFILES_DIR=$2

# Check if ansible directory exists
if [ ! -d "$ANSIBLE_DIR" ]
then
    echo "Ansible directory not found, exiting..."
    exit 1
fi

# Check if dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]
then
    echo "Dotfiles directory not found, exiting..."
    exit 1
fi

# Install ansible if not installed
if ! command -v ansible &> /dev/null
then
    echo "Ansible not found, installing..."
    sudo pacman -S ansible --noconfirm
fi

# Check if ansible requirements file exists and install
if [ -s $ANSIBLE_DIR/requirements.yml ]
then
    echo "Ansible requirements file found, installing..."
    ansible-galaxy install -r $ANSIBLE_DIR/requirements.yml
else
    echo "Ansible requirements file not found, skipping..."
fi

# Run ansible playbook
echo "Running ansible playbook..."
ansible-playbook --diff $ANSIBLE_DIR/playbook.yml --connection=local -e "DOTFILES_DIR=$DOTFILES_DIR"
