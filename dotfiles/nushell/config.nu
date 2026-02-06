if $env.DEVROOT == "" {
    if $nu.os-info.name == "windows" {
        $env.DEVROOT = "/"
    } else {
        $env.DEVROOT = $env.HOME
    }
}

$env.PATH = ($env.PATH | append "~/.cargo/bin" | append "~/go/bin")

$env.config.show_banner = false

alias ws = cd $env.DEVROOT
alias fcd = cd (ls $"($env.DEVROOT)/Projects" | where type == "dir" | sort-by modified --reverse | get name | str join "\n" | fzf)
alias ll = ls -la

def nvim [...args] {
    if $nu.os-info.name == "windows" {
        if ($args | length) > 0 {
            let linux_path = (wsl wslpath -u $args.0 | str trim)
            wsl nvim $linux_path
        } else {
            wsl nvim
        }
    } else {
        ^nvim ...$args
    }
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")