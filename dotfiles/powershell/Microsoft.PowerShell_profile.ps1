$PSStyle.FileInfo.Directory = ""

Function ws() {
    cd $env:DEVROOT
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
