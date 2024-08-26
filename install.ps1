#Requires -RunAsAdministrator
#Requires -Version 7

# Linked files (Destination => Source)
$symlinks = @{
  $PROFILE.CurrentUserAllHosts                                                                    = ".\Profile.ps1"
  "$HOME\AppData\Local\nvim"                                                                      = ".\.config\nvim"
  "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" = ".\windowsterminal\settings.json"
}

# Winget & choco dependencies
$wingetDeps = @(
  "chocolatey.chocolatey"
  "eza-community.eza"
  "git.git"
  "microsoft.powershell"
  "neovim.neovim"
  "starship.starship"
)

$chocoDeps = @(
  "fzf"
  "ripgrep"
  "zig"
  "zoxide"
)

# PS Modules
$psModules = @(
  "CompletionPredictor"
  "PSScriptAnalyzer"
)

# Set Working directory
Set-Location $PSScriptRoot
[System.Environment]::CurrentDirectory = $PSScriptRoot

Write-Host "Installing missing dependencies..."
$installedWingetDeps = winget list | Out-String
foreach ($wingetDep in $wingetDeps) {
  if ($installedWingetDeps -notmatch $wingetDep) {
    winget install -h --no-upgrade $wingetDep
  }
}

# Path Refresh
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

$installedChocoDeps = (choco list --limit-output --id-only).Split("`n")
foreach ($chocoDep in $chocoDeps) {
  if ($installedChocoDeps -notcontains $chocoDep) {
    choco install $chocoDep -y
  }
}

# Install PS Modules
foreach ($psModule in $psModules) {
  if (!(Get-Module -ListAvailable -Name $psModule)) {
    Install-Module -Name $psModule -Force -AcceptLicense -Scope CurrentUser
  }
}

# Create Symbolic Links
Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
  Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
  New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}
