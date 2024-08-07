$commander_path = "C:\Users\creat\Projects\the_cave\downloader\Commander\bin\Debug\net8.0"
$commander = "$commander_path\Commander.exe"
$operator_path = "C:\Users\creat\Projects\the_cave\downloader\Operator\bin\Debug\net8.0"
$operator = "$operator_path\Operator.exe"
# $downloader_path = "C:\Users\creat\Projects\the_cave\downloader\Downloader\bin\Debug\net8.0"
# $downloader = "$downloader_path\Downloader.exe"

if ($args[0] -ieq "cmd") {
  Start-Process -FilePath "pwsh" -Wait -ArgumentList "-NoExit", "-c", "$commander"
}
elseif ($args[0] -ieq "main") {
  Start-Process -FilePath "pwsh" -Wait -ArgumentList "-NoExit", "-c", "$operator"
}
elseif ($args[0] -ieq "t001") {
  wt --maximized -p "PowerShell" -d "$operator_path" pwsh -NoExit -c "$operator" `; `
    sp -p "PowerShell" -V -s .67 -d "$commander_path" pwsh -NoExit -c "$commander" `; `
    sp -p "PowerShell" -V -s .5 -d "$home" `; `
    sp -p "PowerShell" -H -d "$home\mydoc" `; mf left
}
elseif ($args[0] -ieq "-h") {
  wt --pos 5360,0 --maximized --title "TheCave" -p "PowerShell" `
    -d "$operator_path" pwsh -NoExit -c "$operator" --headless `; `
    sp -V --size .44 -p "PowerShell" --title "TheCave" -d "$operator_path" `
    pwsh -NoExit -c Write-Output "execute unzipper" `; `
    mf left `; sp -H --size .13 --title "TheCave" -d "$commander_path" `
    pwsh -NoExit -c "$commander"
}
else {
  wt --pos 5360,0 --maximized --title "TheCave" -p "PowerShell" `
    -d "$operator_path" pwsh -NoExit -c "$operator" `; `
    sp -V --size .44 -p "PowerShell" --title "TheCave" -d "$operator_path" `
    pwsh -NoExit -c Write-Output "execute unzipper" `; `
    mf left `; sp -H --size .13 --title "TheCave" -d "$commander_path" `
    pwsh -NoExit -c "$commander"
  <#
  cave @#down #>
}