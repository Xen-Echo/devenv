FROM archlinux:latest

# Update locale
RUN echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Update package repository
RUN pacman -Syu --noconfirm

# Install core tools for environment
RUN pacman -S --noconfirm git base-devel neovim zellij starship alacritty exa zoxide fd bat ripgrep fzf lazygit man-db unzip nushell ttf-jetbrains-mono-nerd zig 

# Install language tools
RUN pacman -S --noconfirm go rustup nodejs npm && npm install -g bun && rustup default stable

# Use the host install of podman
RUN ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman
