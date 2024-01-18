#!/usr/bin/env nu

use std log

# Deployment is less sophisticated than the Linux counterpart but better than nothing for the moment

log info "Configuring environment..."

if ("dotfiles" | path exists | into bool) != true {
    log critical "Could not find 'dotfiles', did you call this script from the roor directory"
    exit(1)
}

log info "NuShell Configuration"

mkdir ~/.config/nushell
cp -urv dotfiles/nushell/*.nu ~/AppData/Roaming/nushell
cp -urv dotfiles/nushell/scripts ~/.config/nushell/scripts

log info "Nvim Configuration"

rm -rf ~/AppData/Local/nvim
cp -vr dotfiles/nvim ~/AppData/Local/nvim

log info "Windows Terminal Configuration"

let winterm_ls = ls ~\AppData\Local\Packages | where name =~ "WindowsTerminal" | get name
if ($winterm_ls | length) > 0 {
    let path = $winterm_ls | first | append "/LocalState" | str join
    echo $path
    cp -urv dotfiles/windows-terminal/settings.json $path
} else {
    log error "Could not find Windows Terminal"
}
