@echo off
chcp 65001 > nul
pushd "G:\내 드라이브\1.창고\정보\Packs"
setlocal
set VERACRYPT="C:\Program Files\VeraCrypt\VeraCrypt.exe"
if "%1" == "-m" (
  if /i "%2" == "f" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk0\Partition2 /letter F /keyfile "M:\Keyfiles\diskF" /tryemptypass /cache no
  ) else if /i "%2" == "p" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk1\Partition2 /letter P /keyfile "M:\Keyfiles\diskP02" /tryemptypass /cache no
  ) else if /i "%2" == "s" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk2\Partition2 /letter S /keyfile "M:\Keyfiles\diskS" /tryemptypass /cache no
  ) else if /i "%2" == "q" (
    powershell -command "Get-Content 'M:\PnQ Key.txt' | Select-Object -Index 3 | Set-Clipboard"
    echo The Q disk password is copied.
    echo You should clean up the clipboard after using this: Using '.\pack.bat -c'.
  ) else if /i "%2" == "rw" (
    %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /m rm /protectMemory /cache no
  ) else (
    %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /mountoption ro /m rm /protectMemory /cache no
  )
) else if "%1" == "-c" (
  echo off | clip
  echo clipboard cleared.
) else if /i "%1" == "-k" (
  powershell -command "Get-Content 'M:\session3.txt' | Select-Object -Index 0 | Set-Clipboard"
  echo The KeePass password is copied.
  echo You should clean up the clipboard after using this: Using '.\pack.bat -c'.
) else if "%1" == "-d" (
  if /i "%2" == "f" (
    %VERACRYPT% /q /d F
  ) else if /i "%2" == "p" (
    %VERACRYPT% /q /d P
  ) else if /i "%2" == "s" (
    %VERACRYPT% /q /d S
  ) else if /i "%2" == "k" (
    %VERACRYPT% /q /d M
  ) else (
    %VERACRYPT% /q /d M
  )
) else ( Rem help messages
  echo .\pack.bat -m      : mount key capsule readonly mode
  echo .\pack.bat -m rw   : mount key capsule read and write mode
  echo.
  echo Before using following commands, You must mount key capsule.
  echo .\pack.bat -k      : copy KeePass passwd to clipboard
  echo .\pack.bat -m f    : mount F volume
  echo .\pack.bat -m p    : mount P volume
  echo .\pack.bat -m s    : mount S volume
  echo .\pack.bat -m q    : copy Q disk passwd to clipboard
  echo.
  echo .\pack.bat -d      : dismount key capsule
  echo .\pack.bat -d f    : dismount F volume 
)
endlocal