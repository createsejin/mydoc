$commander_path = "C:\Users\creat\Projects\the_cave\downloader\Commander\bin\Debug\net8.0"
$commander = "$commander_path\Commander.exe"
$downloader_path = "C:\Users\creat\Projects\the_cave\downloader\Downloader\bin\Debug\net8.0"
$downloader = "$downloader_path\Downloader.exe"

if ($args[0] -eq "cmd") {
  Start-Process -FilePath "pwsh" -Wait -ArgumentList "-NoExit", "-c", "$commander"
}
elseif ($args[0] -eq "ctrl") {
  Start-Process -FilePath "pwsh" -Wait -ArgumentList "-NoExit", "-c", "$downloader"
}
elseif ($args[0] -eq "t001") {
  wt --maximized -p "PowerShell" -d "$downloader_path" pwsh -NoExit -c "$downloader" `; `
    sp -p "PowerShell" -V -s .67 -d "$commander_path" pwsh -NoExit -c "$commander" `; `
    sp -p "PowerShell" -V -s .5 -d "$home" `; `
    sp -p "PowerShell" -H -d "$home\mydoc" `; mf left
}
else {
  wt --maximized -p "PowerShell" -d "$downloader_path" pwsh -NoExit -c "$downloader" `; `
    sp -V -d "$commander_path" pwsh -NoExit -c "$commander"
}