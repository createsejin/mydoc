"warning: This script copy and overwrite mydoc's files to original config files."

$wt_settings_path = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

Copy-Item "$HOME\mydoc\win_configs\pwsh_profile\Microsoft.PowerShell_profile.ps1" `
  -Destination "$HOME\OneDrive\문서\PowerShell"
if (Test-Path $wt_settings_path) {
  Copy-Item "$HOME\mydoc\win_configs\win_term\settings.json" `
    -Destination $wt_settings_path
} else {
  "windows terminal settings file path maybe changed. check the location."
}