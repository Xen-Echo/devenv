# Developer Environments

Repository to house local development dotfiles and provide automatic installation scripts. Layout and seperation
are personal choice and therfore quite opinionated.

## Linux

Currently only tested on Fedora Silverblue

### Pre-Requesites

1. Podman (Pre Installed on Silverblue)
2. Distrobox
3. Git

### Scripts

#### Devenv

The `devenv` script builds a new distrobox container from an image under the container files directory and provisions it.

**Usage:** `./bin/devenv.sh <COMMAND> <ENVIRONMENT> [<PROJECT_DIR>]`

`<COMMAND>`: `create | destroy` - Command to execute.

`<ENVIRONMENT>`: `string` - The name of the development environment i.e "base".

`<PROJECT_DIR>`: `string` - The path of the directory to link to for development projects.

##### Create

The create command will atttempt to create a new development environment based on the provided arguments.

1. Checks to see if the environment already exists.
2. Creates a new directory matching `<ENVIRONMENT>` under `./sandbox` this is used as the home directory for the environment.
3. Builds the container image from `./containers/<ENVIRONMENT>.Containerfile` if the `Containerfile` does not exist the build will fail.
4. The `distrobox` is then created mounting the directory created under `./sandbox` as the home dir.
5. The `./bin/dotfiles.sh` script is executed directly on the new environment to load the configuration files.
6. The `<PROJECT_DIR>` is linked to the home directory of the new environment.

##### Destroy

The command destroys the environment specified by `<ENVIRONMENT>`. *Note this is permenant and will delete the 
environments home directory as well. To delete an environment less destructively utilise `distrobox` to stop 
and remove the container.*

#### Dotfiles

The `dotfiles` script copies the configuration files to the correct location using `ansible` to automate the task

**Usage:** `./bin/dotfiles.sh <ANSIBLE_DIR> <DOTFILE_DIR>`

`<ANSIBLE_DIR>`: `string` - Directory containing the ansible playbook and requirements file.

`<DOTFILE_DIR>`: `string` - Directory containing the dotfiles specified in this repository.

##### Limitations

This script can only execute on an Arch distribution at the moment, the only thing that ties it to arch is the 
ansible install command this can likely be improved.
