FROM archlinux:latest

# Update locale
RUN echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen

# Update package repository
RUN pacman -Syu --noconfirm

# Install basic dev tools
RUN pacman -S --noconfirm git base-devel neovim zellij starship alacritty exa zoxide fd bat ripgrep fzf lazygit man-db unzip nushell ttf-jetbrains-mono-nerd nodejs npm && npm install -g bun

# Use the host install of podman
RUN ln -s /usr/bin/distrobox-host-exec /usr/local/bin/podman
