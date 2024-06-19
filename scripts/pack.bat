@echo off
setlocal
set VERACRYPT="C:\Program Files\VeraCrypt\VeraCrypt.exe"
if "%1" == "-k" (
  if "%2" == "rw" (
    %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /m rm /protectMemory /cache no
  ) else (
    %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /mountoption ro /m rm /protectMemory /cache no
  )
) else if "%1" == "-m" (
  if /i "%2" == "f" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk0\Partition2 /letter F /keyfile "M:\Keyfiles\diskF" /tryemptypass /cache no
  ) else if /i "%2" == "p" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk1\Partition2 /letter P /keyfile "M:\Keyfiles\diskP02" /tryemptypass /cache no
  ) else if /i "%2" == "s" (
    %VERACRYPT% /quit /silent /auto /v \Device\Harddisk2\Partition2 /letter S /keyfile "M:\Keyfiles\diskS" /tryemptypass /cache no
  ) else if /i "%2" == "q" (
    powershell -command "Get-Content 'M:\PnQ Key.txt' | Select-Object -Index 3 | Set-Clipboard"
    echo The passwd copied. After use this passwd, You should clear the clipboard: Using '.\pack.bat -c'.
  ) else if /i "%2" == "k" (
    if /i "%3" == "rw" (
      %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /m rm /protectMemory /cache no
    ) else (
      %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /mountoption ro /m rm /protectMemory /cache no
    )
  ) else (
    %VERACRYPT% /quit /auto /volume "Pack009_2024-01-02_001.hc" /letter M /mountoption ro /m rm /protectMemory /cache no
  )
) else if "%1" == "-c" (
  echo off | clip
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
  echo .\pack.bat -k      : mount key capsule readonly mode
  echo .\pack.bat -k rw   : mount key capsule read and write mode
  echo.
  echo .\pack.bat -m k    : mount key capsule readonly mode
  echo .\pack.bat -m k rw : mount key capsule read and write mode
  echo.
  echo Before using following commands, You must mount key capsule.
  echo .\pack.bat -m f    : mount F volume
  echo .\pack.bat -m p    : mount P volume
  echo .\pack.bat -m s    : mount S volume
  echo .\pack.bat -m q    : Q volume passwd copy to clipboard
  echo.
  echo .\pack.bat -d      : dismount key capsule
  echo .\pack.bat -d f    : dismount F volume 
)
endlocal