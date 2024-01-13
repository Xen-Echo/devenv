#!/bin/bash
set -e

# ./devenv create base
# ./devenv dotfiles base
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
ENVIRONMENT=$2

ENVIRONMENT_DIR="$SANDBOX_DIR/$ENVIRONMENT"
ENVIRONMENT_EXISTS=false
ENVIRONMENT_INIT="$CONTAINER_DIR/$ENVIRONMENT.sh"

# Check command valid
if [ "$COMMAND" != "create" ] && [ "$COMMAND" != "dotfiles" ] && [ "$COMMAND" != "destroy" ]
then
    echo "Invalid command expected, exiting..."
    exit 1
fi

# Check if environment is specified
if [ -z "$ENVIRONMENT" ]
then
    echo "No environment specified, exiting..."
    exit 1
fi

# Check if environment has been initialised
if [ -f "$ENVIRONMENT_DIR/initialised" ]
then
    ENVIRONMENT_EXISTS=true
fi

# Attempt to create the environment
if [ "$COMMAND" == "create" ]
then

    # Check if environment has already been initialised
    if [ "$ENVIRONMENT_EXISTS" == true ]
    then
        echo "Environment already initialised, exiting..."
        exit 1
    fi

    echo "Initialising environment..."

    # Check if sanbox directory exists
    if [ ! -d "$ENVIRONMENT_DIR" ]
    then
        echo "Sandbox directory not found, creating..."
        mkdir "$ENVIRONMENT_DIR"
    fi

    # Build the container image, the container file should be named the same as the environment
    podman build -t base -f $CONTAINER_DIR/$ENVIRONMENT.Containerfile

    # Create the Containerfile
    distrobox create --nvidia --name $ENVIRONMENT --image $ENVIRONMENT --home $SANDBOX_DIR/$ENVIRONMENT

    # Install dotfiles
    distrobox enter $ENVIRONMENT -- $BIN_DIR/dotfiles.sh $ANSIBLE_DIR $DOTFILES_DIR

    # Run the extra init if it exists
    if [ -f "$ENVIRONMENT_INIT" ]
    then
        chmod u+x $ENVIRONMENT_INIT
        distrobox enter $ENVIRONMENT -- $ENVIRONMENT_INIT
    fi

    # Write a file to the sandbox directory to indicate that the environment has been initialised
    touch $ENVIRONMENT_DIR/initialised
    echo "Initialisation complete."

elif [ "$COMMAND" == "dotfiles" ]
then

    # Check if environment exists
    if [ "$ENVIRONMENT_EXISTS" != true ]
    then
        echo "Environment does not exist, exiting..."
        exit 1
    fi

    echo "Applying dotfiles..."
    distrobox enter $ENVIRONMENT -- $BIN_DIR/dotfiles.sh $ANSIBLE_DIR $DOTFILES_DIR

elif [ "$COMMAND" == "destroy" ]
then

    echo "Destroying environment..."
    distrobox rm -f $ENVIRONMENT
    rm -rf $ENVIRONMENT_DIR

else

    echo "Invalid command, exiting..."
    exit 1

fi

