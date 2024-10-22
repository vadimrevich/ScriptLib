###
# Set-AllNetworksAsPrivate.ps1
# This Script Makes all non-private (Public and Domain) Networks as Private
###
Get-NetConnectionProfile | Where{ $_.NetWorkCategory -ne 'Private'} | ForEach {$_|Set-NetConnectionProfile -NetWorkCategory Private}
Get-NetConnectionProfile
