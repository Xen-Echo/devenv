$env.DEVROOT = $env.HOME
$env.PATH = ($env.PATH | append "~/.cargo/bin" | append "~/go/bin")

$env.config.show_banner = false

alias ws = cd $env.DEVROOT
alias fcd = cd (ls $"($env.DEVROOT)/Projects" | where type == "dir" | sort-by modified --reverse | get name | str join "\n" | fzf)
alias ll = ls -la

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
