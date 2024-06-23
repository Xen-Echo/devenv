#!/usr/bin/env nu

export def --env fcd [path = ""] {
    mut $path = $path | str trim
    if ($path | is-empty) {
        $path = ($env.DEVROOT | path join "Projects/*" | path expand)
        $path = ($path | str replace "\\" "/")
    }
    mut $items = ""
    # Globs have some problems on windows when drive letters are used so I'll just fallback to powershell
    if $nu.os-info.family == "windows" { 
        $items = (powershell -c "Get-ChildItem -Directory" $path " | Sort-Object LastWriteTime -Descending | Select-Object FullName | Format-Table -HideTableHeaders")
    } else {
        $items = (ls -D $path | flatten | where type == dir | sort-by modified | reverse | get name | to text)
    }
    let file = $items | fzf | str trim -r
    cd $file
}

export def cht [query = ":help"] {
    let url = "https://cheat.sh/" + $query
    let res = curl -s $url
    echo $res
}
