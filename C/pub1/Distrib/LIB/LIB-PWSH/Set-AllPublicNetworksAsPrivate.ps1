###
# Set-AllPublicNetworksAsPrivate.ps1
# This Script Makes all Public Networks as Private
###
Get-NetConnectionProfile | Where{ $_.NetWorkCategory -eq 'Public'} | ForEach {$_|Set-NetConnectionProfile -NetWorkCategory Private}
Get-NetConnectionProfile
