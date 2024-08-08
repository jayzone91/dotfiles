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

# TODO: Rest of Profile.... Check at Work.
