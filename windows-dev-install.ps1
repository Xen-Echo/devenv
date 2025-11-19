param(
  [Parameter()]
  [String]$DevRoot = "D:\",
  [Parameter()]
  [switch]$Install,
  [Parameter()]
  [switch]$Configure
)

# ============================================================================== #
# Initialise
# ============================================================================== #

Write-Host "Configuring Windows development environment..."
Write-Host "DevRoot: $DevRoot."

[System.Environment]::SetEnvironmentVariable('DEVROOT', $DEVROOT, 'User')
[System.Environment]::SetEnvironmentVariable('DEVSHELL', 'pwsh', 'User')

$TempDir = "$Env:TEMP\dev-setup"
$ProjectsDir = "$DevRoot\Projects"
$ObsidianDir = "$DevRoot\Obsidian"

# Check the devroot exists and is a directory
if (-not (Test-Path $DevRoot -PathType Container)) {
  Write-Host "DevRoot does not exist or is not a directory: $DevRoot."
  exit 1
}

# Check each directory exists, create if not
$Dirs = @($ProjectsDir, $ObsidianDir, $TempDir)
foreach ($Dir in $Dirs) {
  if (-not (Test-Path $Dir -PathType Container)) {
    Write-Host "Creating directory: $Dir."
    New-Item -Path $Dir -ItemType Directory | Out-Null
  }
}

# ============================================================================== #
# Install packages
# ============================================================================== #

if ($Install.IsPresent) {

  Write-Host "Installing packages..."  

  $packages =
    "Git.Git",
    "Docker.DockerDesktop",
    "Microsoft.VisualStudioCode",
    "zig.zig",
    "junegunn.fzf",
    "BurntSushi.ripgrep.GNU",
    "Neovim.Neovim",
    "Microsoft.PowerShell",
    "NanaZip.NanaZip",
    "JetBrains.Toolbox",
    "Starship.Starship",
    "DEVCOM.JetBrainsMonoNerdFont",
    "OpenJS.NodeJS.LTS",
    "DenoLand.Deno"

    foreach ($package in $packages)
    {
      Write-Host "Installing $package"
      winget install --id $package --accept-package-agreements
    }

}

# ============================================================================== #
# Configure
# ============================================================================== #

if ($Configure.IsPresent) {

  Write-Host "Configuring..."

  $Dotfiles = "$PSScriptRoot\dotfiles"

  # PowerShell
  if (!(Test-Path -Path $Profile)) {
    New-Item -ItemType File -Path $Profile -Force | Out-Null
  }
  Copy-Item -Path "$Dotfiles\powershell\Microsoft.PowerShell_profile.ps1" -Destination $Profile -Force

  # Git
  Write-Host "Configuring Git..."
  Copy-Item -Path "$Dotfiles\git\config" -Destination "$HOME\.gitconfig" -Force
  
  # Neovim
  Write-Host "Configuring Neovim..."
  $NeovimConfigDir = "$HOME\AppData\Local\nvim"
  Remove-Item -Path $NeovimConfigDir -Recurse -Force
  Copy-Item -Path "$Dotfiles\nvim" -Destination $NeovimConfigDir -Recurse -Force
  
  # Windows Terminal
  Write-Host "Configuring Windows Terminal..."
  $WindowsTerminalConfigDir = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
  Copy-Item -Path "$Dotfiles\windows-terminal\settings.json" -Destination $WindowsTerminalConfigDir -Force

} else {
  Write-Host "Skipping configuration."
}

# ============================================================================== #
# Clean up
# ============================================================================== #

Write-Host "Cleaning up..."
Remove-Item -Path $TempDir -Recurse -Force

