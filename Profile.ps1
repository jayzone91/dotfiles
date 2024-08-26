function Find-WindowsConfigFolder {
  <#
  .SYNOPSIS
    Finds the local Git Repo
  #>
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$ProfilePath
  )
  Write-Verbose "Resolving the symbolic link for the profile"
  $profileSymbolicLink = Get-ChildItem $ProfilePath | Where-Object FullName -EQ $PROFILE.CurrentUserAllHosts
  return Split-Path $profileSymbolicLink.Target
}

# Environment Variables
$ENV:DotFilesRepo = Find-WindowsConfigFolder -ProfilePath $PSScriptRoot
$ENV:STARSHIP_CONFIG = "$ENV:DotFilesRepo\.config\starship.toml"

# Starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Remove-Alias Alias:cd
Set-Alias -Name cd -Value z

#


# Functions 

function which {
  param (
    $command
  )
  if ($command) {
    Invoke-Item $command
  }
  else {
    Invoke-Item .
  }
}

function dir { Get-ChildItem -Directory }
function file { Get-ChildItem File }
function hidden { Get-ChildItem File }


# Alias
Set-Alias -Name .. -Value Set-Location ..
Set-Alias -Name c -Value Clear-Host  
Set-Alias -Name ls -Value dir
Set-Alias -Name ll -Value file
Set-Alias -Name lla -Value hidden
Set-Alias -Name vim -Value nvim
Set-Alias -Name vi -Value nvim