# for windows link argument. 아마도 cmd상에서 실행되는것 같다.
# "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.20.11781.0_x64__8wekyb3d8bbwe\wt.exe" -M -d "%USERPROFILE%" ; sp -V -s .67 -d "%USERPROFILE%\mydoc" ; sp -V -d "%USERPROFILE%\Projects" ; mf left ; mf left ; sp -H -D ; mf right ; sp -H -D ; mf right ; sp -H -D
$l_cmd = "eza -A --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"


if ($args.Count -eq 0) {
  wt -M -d "$home\mydoc" pwsh -NoExit -c "$l_cmd" `; `
    sp -V -s .67 -d "$home\mydoc\scripts\.pwsh" pwsh -NoExit -c "$l_cmd" `; `
    sp -V -d "$home\Projects" pwsh -NoExit -c "$l_cmd" `; mf left `; mf left `; `
    sp -H -d "$home\obsidian" pwsh -NoExit -c "$l_cmd" `; mf right `; `
    sp -H -d "$home\mydoc\win_configs" pwsh -NoExit -c "$l_cmd" `; mf right `; `
    sp -H -d "$home\Projects\the_cave\downloader" pwsh -NoExit -c "$l_cmd" `; mf left
}