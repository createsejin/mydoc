# switch Windows Terminal profile between linux setup and windows setup

# Caution !!!
# This script must be used after getting administrator privileges or on the system that enabled developer mode.

# switch windows terminal settings.json between linux and win
$linux_profile = "C:\Users\creat\mydoc\win_configs\win_term\linux.settings.json"
$win_profile = "C:\Users\creat\mydoc\win_configs\win_term\win.settings.json"
$profile_location = "C:\Users\creat\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
#WtProfilesLocation@#sw
$settings_json = "settings.json"

# $test_location = "C:\Users\creat\Downloads" # for test

# switch vam prefs.json for work or play
$play_prefs = "D:\vam_resources\prefs.json.play"
$work_prefs = "D:\vam_resources\prefs.json.work"
$prefs_location = "C:\Users\creat\vam"
#VamProfileLocation@#sw
$prefs_json = "prefs.json"


function mklink {
  param (
    [string]$location,
    [string]$profile_,
    [string]$json_name
  )
  if (Test-Path "$location\$json_name") {
    Remove-Item "$location\$json_name"
  }
  New-Item -ItemType SymbolicLink -Path $json_name -Target $profile_
  #mklinkFunc@#sw
}

function rm_and_cp ([string]$location, [string]$profile_, [string]$json_name) {
  if (Test-Path "$location\$json_name") {
    Remove-Item "$location\$json_name"
  }
  Copy-Item -Path "$profile_" -Destination "$location\$json_name"
  #rm_and_cpFunc@#sw
}

if ($args[0] -ieq "l") {
  # switch profile to linux setup
  mklink $profile_location $linux_profile $settings_json 
  "Windows Terminal Profile is changed to linux setup"
}
elseif ($args[0] -ieq "w") {
  # switch profile to windows setup
  mklink $profile_location $win_profile $settings_json
  "Windows Terminal Profile is changed to windows setup"
}
elseif ($args[0] -ieq "v") {
  if ($args[1] -ieq "p") { # switch vam prefs to "play" 
    rm_and_cp $prefs_location $play_prefs $prefs_json
    "vam prefs.json is changed to play prefs"
  } elseif ($args[1] -ieq "w") { # switch vam prefs to "work"
    rm_and_cp $prefs_location $work_prefs $prefs_json
    "vam prefs.json is changed to work prefs"
    #VamPrefsSwitch@#sw
  }
}
elseif (($args[0] -ieq "-h") -or ($args[0] -ieq "--help")) {
  "sw l    : change wt profile to linux setup"
  "sw w    : change wt profile to win setup"
  "sw v w  : change vam prefs to work prefs"
  "sw v p  : change vam prefs to play prefs"
  #HelpMsg@#sw
}