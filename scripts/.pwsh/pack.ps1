$veracrypt = "C:\Program Files\VeraCrypt\VeraCrypt.exe"
$work_dir = "G:\내 드라이브\1.창고\정보\Packs"
$work_dir_eng = "G:\My Drive\1.창고\정보\Packs"
$pack009 = "Pack009_2024-01-02_001.hc"
$f_key_file = "M:\Keyfiles\diskF"
$f_device = "\Device\Harddisk0\Partition2"
$p_key_file = "M:\Keyfiles\diskP02"
$p_device = "\Device\Harddisk1\Partition2"
$s_key_file = "M:\Keyfiles\diskS"
$s_device = "\Device\Harddisk2\Partition2"
$q_key_file = "M:\PnQ Key.txt"
$kee_file = "M:\session3.txt"

function help_msg {
  #help msg @#pack
  'pack m           : mount key capsule readonly mode'
  'pack m rw        : mount key capsule read and write mode'
  'pack m f         : mount F disk'
  'pack m p         : mount P disk'
  'pack m s         : mount S disk'
  'pack m q         : copy Q disk passwd to clipboard'
  'pack m q s       : mount Q, S disk'      
  'pack m all       : mount F, P, S, Q disk'
  'pack k           : copy KeePass passwd to clipboard'
  'pack c           : clear clipboard'
  'pack d           : dismount key capsule'
  'pack d f         : dismount F disk'
  'pack d p         : dismount P disk'
  'pack d s         : dismount S disk'
  'pack d q         : lock Q disk'
  'pack d all       : dismount M, F, P, S, and lock Q disk'
}

function mount_vera_disk {
  param (
    [string]$letter,
    [string]$key_file,
    [string]$device
  )
  if (-not (Test-Path "M:\")) {
    'Please mount key capsule first'
  }
  elseif (Test-Path "$letter`:\") {
    "$letter disk already mounted."
  }
  else {
    Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
      -ArgumentList "/quit /silent /auto /v $device /letter $letter /keyfile $key_file /tryemptypass /cache no"
    if (Test-Path "$letter`:\") {
      "$letter disk successfully mounted."
    }
    else {
      "$letter disk mounting is failed."
    }
  }
}
function dismount_vera_disk {
  param (
    [string]$letter
  )
  if (-not (Test-Path "$letter`:\")) {
    "The $letter disk is not mounted."
  }
  else {
    Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d $letter" 
    if (-not (Test-Path "$letter`:\")) {
      "$letter disk is dismounted."
    }
    else {
      "$letter disk is not dismounted."
    }
  }
}
function QdiskUnlock {
  if (-not (Test-Path "M:\")) {
    'Please mount key capsule first'
  }
  else {
    if (Test-Path "Q:\") {
      "Q disk already unlocked."
    }
    else {
      Get-Content $q_key_file | Select-Object -Index 3 | Set-Clipboard
      "The Q disk password is copied."
      Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -unlock Q: -password" -Verb RunAs
      if (Test-Path "Q:\") {
        "Q disk successfully unlocked."
      }
      else {
        "Q disk unlocking is failed."
      }
      Set-Clipboard -Value $null
      "clipboard cleared." <#
      Q unlock @-#>
    }
  }
}
function QdiskLock {
  if (-not (Test-Path "Q:\")) {
    'The Q disk is already locked.'
  }
  else {
    Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -lock Q:" -Verb RunAs
    if (-not (Test-Path "Q:\")) {
      'Q disk is locked.'
    }
    else {
      'Q disk is not locked.'
    } <#
    Q.lock @-#>
  }
}

function keyCapsuleMount {
  param (
    [bool]$rw
  )
  if (Test-Path "G:\") {
    if ($rw) {
      if (Test-Path $work_dir) {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /m rm /protectMemory /cache no"
      }
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir_eng `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /m rm /protectMemory /cache no"
      }
    }
    else {
      if (Test-Path $work_dir) {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /mountoption ro /m rm /protectMemory /cache no" 
      } 
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir_eng `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /mountoption ro /m rm /protectMemory /cache no" 
      }
    }
    if (Test-Path "M:\") {
      'Key Capsule successfully mounted.'
    }
    else {
      'Key Capsule mount failed.'
    }
  }
  else {
    'Gdrive is not mounted yet.'
  }
}

if ($args[0] -ieq "m") {
  if ($args.Count -gt 2) {
    foreach ($arg in $args[1..-1]) {
      if ($arg -ieq "f") {
        mount_vera_disk F $f_key_file $f_device
      }
      elseif ($arg -ieq "p") {
        mount_vera_disk P $p_key_file $p_device
      }
      elseif ($arg -ieq "s") {
        mount_vera_disk S $s_key_file $s_device
      }
      elseif ($arg -ieq "q") {
        QdiskUnlock
      }
    }
  }
  else {
    if ($args[1] -ieq "f") {
      mount_vera_disk F $f_key_file $f_device
    }
    elseif ($args[1] -ieq "p") {
      mount_vera_disk P $p_key_file $p_device
    }
    elseif ($args[1] -ieq "s") {
      mount_vera_disk S $s_key_file $s_device
    }
    elseif ($args[1] -ieq "q") {
      QdiskUnlock
    }
    elseif ($args[1] -ieq "all") {
      if (-not (Test-Path "M:\")) {
        'Please mount key capsule first'
      } 
      else {
        mount_vera_disk F $f_key_file $f_device
        mount_vera_disk P $p_key_file $p_device
        mount_vera_disk S $s_key_file $s_device
        QdiskUnlock
      }
    }
    elseif ($args[1] -ieq "rw") {
      keyCapsuleMount $true
    }
    else {
      keyCapsuleMount $false
    }
  }
}
elseif ($args[0] -ieq "d") {
  if ($args[1] -ieq "f") {
    dismount_vera_disk F
  }
  elseif ($args[1] -ieq "p") {
    dismount_vera_disk P
  }
  elseif ($args[1] -ieq "s") {
    dismount_vera_disk S
  }
  elseif ($args[1] -ieq "q") {
    QdiskLock
  }
  elseif ($args[1] -ieq "all") {
    dismount_vera_disk F
    dismount_vera_disk P
    dismount_vera_disk S
    dismount_vera_disk M
    QdiskLock
  }
  else {
    dismount_vera_disk M
  }
}
elseif ($args[0] -ieq "c") {
  Set-Clipboard -Value $null
  "clipboard cleared."
}
elseif ($args[0] -ieq "k") {
  if (Test-Path $kee_file) {
    Get-Content $kee_file | Select-Object -Index 0 | Set-Clipboard
    "The KeePass password is copied."
    "You should clean up the clipboard after using this: Use `"pack c`""
  }
  else {
    'Please mount key capsule first'
  }
}
elseif (($args[0] -ieq "--help") -or ($args[0] -ieq "-h") -or ($args[0] -ieq "h") -or ($args[0] -ieq "help")) {
  help_msg
}
else {
  help_msg
}