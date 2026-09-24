# Developer Environment Setup

Repository to house local development dotfiles and provide automatic installation scripts.

## Tools

Goals are to keep the toolchain similar between the different systems to make it easy
to transfer to and from with the exceptions listed below.

### Windows

- Windows Terminal

### Nix

- Ghostty

## Usage

Uses `chezmoi` to handle syncing the files between source and Git.

```sh
chezmoi init https://github.com/Xen-Echo/devenv
```

```sh
chezmoi diff
```

```sh
chezmoi re-add
```

```sh
chezmoi apply
```
