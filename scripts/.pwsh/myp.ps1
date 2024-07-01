# for windows link argument. 아마도 cmd상에서 실행되는것 같다.
# "C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_1.20.11781.0_x64__8wekyb3d8bbwe\wt.exe" -M -d "%USERPROFILE%" ; sp -V -s .67 -d "%USERPROFILE%\mydoc" ; sp -V -d "%USERPROFILE%\Projects" ; mf left ; mf left ; sp -H -D ; mf right ; sp -H -D ; mf right ; sp -H -D
if ($args.Count -eq 0) {
  wt -M -d "$home" `; sp -V -s .67 -d "$home\mydoc" `; `
    sp -V -d "$home\Projects" `; mf left `; mf left `; sp -H -D `; `
    mf right `; sp -H -D `; mf right `; sp -H -D `; mf left
}