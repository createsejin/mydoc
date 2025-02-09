# switch Windows Terminal profile between linux setup and windows setup

# Caution !!!
# This script must be used after getting administrator privileges or on the system that enabled developer mode.

$linux_profile = "C:\Users\creat\mydoc\win_configs\win_term\linux.settings.json"
$win_profile = "C:\Users\creat\mydoc\win_configs\win_term\win.settings.json"
$profile_location = "C:\Users\creat\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
# $profile_location = "C:\Users\creat\Downloads" # for test
$json = "settings.json"

function mklink {
  param (
    [string]$location,
    [string]$profile_
  )
  if (Test-Path "$location\$json") {
    Remove-Item "$json"
  }
  New-Item -ItemType SymbolicLink -Path $json -Target $profile_
}
if ($args[0] -ieq "l") {
  # switch profile to linux setup
  mklink $profile_location $linux_profile
}
elseif ($args[0] -ieq "w") {
  # switch profile to windows setup
  mklink $profile_location $win_profile
}