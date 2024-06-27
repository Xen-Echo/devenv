param(
  [Parameter(Mandatory)]
  [String]$DevRoot,
  [Parameter()]
  [switch]$SkipInstall,
  [Parameter()]
  [switch]$SkipConfig
)

# ============================================================================== #
# Initialise
# ============================================================================== #

Write-Host "Configuring Windows development environment..."
Write-Host "DevRoot: $DevRoot."

[System.Environment]::SetEnvironmentVariable('DEVROOT', $DEVROOT, 'User')

$TempDir = "$Env:TEMP\dev-setup"

$ScoopRootDir = "$DevRoot\Scoop"
$ScoopGlobalDir = "$ScoopRootDir\Global"
$ScoopInstallDir = "$ScoopRootDir\Install"

$ProjectsDir = "$DevRoot\Projects"
$ObsidianDir = "$DevRoot\Obsidian"

# Check the devroot exists and is a directory
if (-not (Test-Path $DevRoot -PathType Container)) {
  Write-Host "DevRoot does not exist or is not a directory: $DevRoot."
  exit 1
}

# Check each directory exists, create if not
$Dirs = @($ScoopRootDir, $ScoopGlobalDir, $ScoopInstallDir, $ProjectsDir, $ObsidianDir, $TempDir)
foreach ($Dir in $Dirs) {
  if (-not (Test-Path $Dir -PathType Container)) {
    Write-Host "Creating directory: $Dir."
    New-Item -Path $Dir -ItemType Directory | Out-Null
  }
}

# Install Scoop if it isn't already installed, check for the scoop command
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Scoop..."
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  irm get.scoop.sh -outfile "$TempDir\get-scoop.ps1"
  Invoke-Expression "&'$TempDir\get-scoop.ps1' -ScoopDir $ScoopInstallDir -ScoopGlobalDir $ScoopGlobalDir"
  scoop bucket add extras
  scoop bucket add nerd-fonts
} else {
  Write-Host "Scoop is already installed."
}

# ============================================================================== #
# Install packages
# ============================================================================== #

if (-not $SkipInstall.IsPresent) {

  Write-Host "Installing packages..."  

  # Core packages
  scoop install git
  scoop install zig
  scoop install nodejs
  scoop install go
  scoop install rustup-gnu
  rustup toolchain install stable-x86_64-pc-windows-gnu
  rustup default stable-x86_64-pc-windows-gnu

  # Tools
  scoop install fd
  scoop install fzf
  scoop install ripgrep
  scoop install neovim
  scoop install zoxide
  scoop install bat
  scoop install lazygit
  scoop install lazydocker
  scoop install gsudo
  scoop install jetbrains-toolbox
  winget install NanaZip --source msstore --accept-package-agreements

  # Shell
  scoop install nu
  scoop install starship
  scoop install nerd-fonts/JetBrainsMono-NF

} else {
  Write-Host "Skipping package installation."
}

# ============================================================================== #
# Configure
# ============================================================================== #

if (-not $SkipConfig.IsPresent) {

  Write-Host "Configuring..."

  $Dotfiles = "$PSScriptRoot\dotfiles"

  # Git
 
  Write-Host "Configuring Git..."
  Copy-Item -Path "$Dotfiles\git\config" -Destination "$HOME\.gitconfig" -Force

  # NuShell

  Write-Host "Configuring NuShell..."
  $NuRoamingDir = "$HOME\AppData\Roaming\nushell"
  New-Item -ItemType Directory -Force -Path $NuRoamingDir | Out-Null
  Copy-Item -Path "$Dotfiles\nushell\*.nu" -Destination $NuRoamingDir -Force
  Copy-Item -Path "$Dotfiles\nushell\scripts" -Destination $NuRoamingDir -Recurse -Force
  
  # Neovim
  
  Write-Host "Configuring Neovim..."
  $NeovimConfigDir = "$HOME\AppData\Local\nvim"
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

