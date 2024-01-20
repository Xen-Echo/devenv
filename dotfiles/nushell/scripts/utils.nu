#!/usr/bin/env nu

def --env fcd [path = "~/Projects/*"] {
    let file = [$path] | each {|| ls -D $in } | flatten | where type == dir | sort-by modified | reverse | get name | to text | fzf | str trim -r
    cd $file
}

def cht [query = ":help"] {
    let url = "https://cheat.sh/" + $query
    let res = curl -s $url
    echo $res
}
