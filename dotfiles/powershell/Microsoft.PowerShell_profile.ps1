$PSStyle.FileInfo.Directory = ""

Function ll() {
    Get-ChildItem | Format-Table Mode, @{N='Owner';E={(Get-Acl $_.FullName).Owner}}, Length, LastWriteTime, @{N='Name';E={if($_.Target) {$_.Name+' -> '+$_.Target} else {$_.Name}}}
}

Function ws() {
    cd $env:DEVROOT
}

Function cht() {
    param(
        [string]$query = ":help"
    )
    $url = "https://cht.sh/$query"
    curl -s $url | out-host -paging
}

Function fcd() {
    param(
        [string]$path = ""
    )
    if ($path -eq "") {
        $path = (Join-Path $env:DEVROOT -ChildPath "Projects/*")
    }
    $items = (Get-ChildItem -Directory $path | Sort-Object LastWriteTime -Descending | Select-Object FullName | Format-Table -HideTableHeaders)
    [string]$file = $items | fzf
    $file = $file.Trim()
    cd $file
}

Invoke-Expression (&starship init powershell)
