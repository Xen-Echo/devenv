#!/bin/bash
set -e

# ./devenv create base -p ~/Projects
# ./devenv destroy base

# Get directories
BIN_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT_DIR=$(dirname "$BIN_DIR../")
CONTAINER_DIR="$ROOT_DIR/containers"
SANDBOX_DIR="$ROOT_DIR/sandbox"
ANSIBLE_DIR="$ROOT_DIR/ansible"
DOTFILES_DIR="$ROOT_DIR/dotfiles"

# Parse arguments
COMMAND=$1
ENVRIONMENT=$2

# Check if environment is specified
if [ -z "$ENVRIONMENT" ]
then
    echo "No environment specified, exiting..."
    exit 1
fi

# Attempt to create the environment
if [ "$COMMAND" == "create" ]
then

    PROJECT_DIR=$3

    if [ -z "$PROJECT_DIR" ]
    then
        echo "No project directory specified, exiting..."
        exit 1
    fi

    ENVRIONMENT_DIR="$ROOT_DIR/$ENVRIONMENT"

    # Check if environment has already been initialised
    if [ -f "$ENVRIONMENT_DIR/initialised" ]
    then
        echo "Environment already initialised, exiting..."
        exit 1
    fi

    echo "Initialising environment..."

    # Check if sanbox directory exists
    if [ ! -d "$ENVRIONMENT_DIR" ]
    then
        echo "Sandbox directory not found, creating..."
        mkdir "$ENVRIONMENT_DIR"
    fi

    # Build the container image, the container file should be named the same as the environment
    podman build -t base -f $CONTAINER_DIR/$ENVRIONMENT.Containerfile

    # Create the Containerfile
    distrobox create --nvidia --name $ENVRIONMENT --image $ENVRIONMENT --home $SANDBOX_DIR/$ENVRIONMENT

    # Install dotfiles
    distrobox enter $ENVRIONMENT -- $BIN_DIR/dotfiles.sh $ANSIBLE_DIR $DOTFILES_DIR

    # Symbolic link project directory
    echo "Creating symbolic link for project directory..."
    ln -s $PROJECT_DIR $HOME/Projects

    # Write a file to the sandbox directory to indicate that the environment has been initialised
    touch $ENVRIONMENT_DIR/initialised
    echo "Initialisation complete."

elif [ "$COMMAND" == "destroy" ]
then

    echo "Destroying environment..."
    distrobox stop $ENVRIONMENT -Y
    distrobox stop $ENVRIONMENT -f --rm-home

else

    echo "Invalid command, exiting..."
    exit 1

fi

