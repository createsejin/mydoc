$veracrypt = "C:\Program Files\VeraCrypt\VeraCrypt.exe"
$work_dir = "G:\내 드라이브\1.창고\정보\Packs"
$pack009 = "Pack009_2024-01-02_001.hc"
$f_key_file = "M:\Keyfiles\diskF"
$p_key_file = "M:\Keyfiles\diskP02"
$s_key_file = "M:\Keyfiles\diskS"
$q_key_file = "M:\PnQ Key.txt"
$kee_file = "M:\session3.txt"

function help_msg {
  #@#h
  'pack m           : mount key capsule readonly mode'
  'pack m rw        : mount key capsule read and write mode'
  'pack m f         : mount F disk'
  'pack m p         : mount P disk'
  'pack m s         : mount S disk'
  'pack m q         : copy Q disk passwd to clipboard'
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

if ($args[0] -ieq "m") {
  if ($args[1] -ieq "f") {
    if (-not (Test-Path $f_key_file)) {
      'Please mount key capsule first'
    }
    elseif (Test-Path "F:\") {
      "F disk already mounted."
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
        -ArgumentList "/quit /silent /auto /v \Device\Harddisk0\Partition2 /letter F /keyfile $f_key_file /tryemptypass /cache no"
      if (Test-Path "F:\") {
        "F disk successfully mounted."
      }
    }
  }
  elseif ($args[1] -ieq "p") {
    if (-not (Test-Path $p_key_file)) {
      'Please mount key capsule first'
    }
    elseif (Test-Path "P:\") {
      "P disk already mounted."
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
        -ArgumentList "/quit /silent /auto /v \Device\Harddisk1\Partition2 /letter P /keyfile $p_key_file /tryemptypass /cache no"
      if (Test-Path "P:\") {
        "P disk successfully mounted."
      }
    }
  }
  elseif ($args[1] -ieq "s") {
    if (-not (Test-Path $s_key_file)) {
      'Please mount key capsule first'
    }
    elseif (Test-Path "S:\") {
      "S disk already mounted."
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
        -ArgumentList "/quit /silent /auto /v \Device\Harddisk2\Partition2 /letter S /keyfile $s_key_file /tryemptypass /cache no"
      if (Test-Path "S:\") {
        "S disk successfully mounted."
      }
    }
  }
  elseif ($args[1] -ieq "q") {
    if (-not (Test-Path "M:\")) {
      'Please mount key capsule first'
    } else {
      if (Test-Path "Q:\") {
        "Q disk already unlocked."
      } else {
        Get-Content $q_key_file | Select-Object -Index 3 | Set-Clipboard
        "The Q disk password is copied."
        Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -unlock Q: -password" -Verb RunAs
        if (Test-Path "Q:\") {
          "Q disk successfully unlocked."
        } else {
          "Q disk unlocking is failed."
        }
        Set-Clipboard -Value $null
        "clipboard cleared."
        #@#q.un
      }
    }
  }
  elseif ($args[1] -ieq "all") {
    if (-not (Test-Path "M:\")) {
      'Please mount key capsule first'
    } 
    else {
      if (Test-Path "F:\") {
        "F disk already mounted."
      }
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
          -ArgumentList "/quit /silent /auto /v \Device\Harddisk0\Partition2 /letter F /keyfile $f_key_file /tryemptypass /cache no"
      }
      if (Test-Path "P:\") {
        "P disk already mounted."
      }
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
          -ArgumentList "/quit /silent /auto /v \Device\Harddisk1\Partition2 /letter P /keyfile $p_key_file /tryemptypass /cache no"
      }
      if (Test-Path "S:\") {
        "S disk already mounted."
      }
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
          -ArgumentList "/quit /silent /auto /v \Device\Harddisk2\Partition2 /letter S /keyfile $s_key_file /tryemptypass /cache no"
      }
      if (Test-Path "Q:\") {
        "Q disk already unlocked."
      } 
      else {
        Get-Content $q_key_file | Select-Object -Index 3 | Set-Clipboard
        "The Q disk password is copied."
        "You should clean up the clipboard after using this: Use `"pack c`"."
      }
    }
  }
  elseif ($args[1] -ieq "rw") {
    if (Test-Path "G:\") {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
        -ArgumentList "/quit /auto /volume $pack009 /letter M /m rm /protectMemory /cache no"
    }
    else {
      'Gdrive is not mounted yet.'
    }
  }
  else {
    if (Test-Path "G:\") {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
        -ArgumentList "/quit /auto /volume $pack009 /letter M /mountoption ro /m rm /protectMemory /cache no" 
    }
    else {
      'Gdrive is not mounted yet.'
    }
  }
}
elseif ($args[0] -ieq "d") {
  if ($args[1] -ieq "f") {
    if (-not (Test-Path "F:\")) {
      'The F disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d F" 
      if (-not (Test-Path "F:\")) {
        'F disk is dismounted.'
      } else {
        'F disk is not dismounted.'
      }
    }
  }
  elseif ($args[1] -ieq "p") {
    if (-not (Test-Path "P:\")) {
      'The P disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d P" 
      if (-not (Test-Path "P:\")) {
        'P disk is dismounted.'
      } else {
        'P disk is not dismounted.'
      }
    }
  }
  elseif ($args[1] -ieq "s") {
    if (-not (Test-Path "S:\")) {
      'The S disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d S" 
      if (-not (Test-Path "S:\")) {
        'S disk is dismounted.'
      } else {
        'S disk is not dismounted.'
      }
    }
  }
  elseif ($args[1] -ieq "q") {
    if (-not (Test-Path "Q:\")) {
      'The Q disk is already locked.'
    }
    else {
      Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -lock Q:" -Verb RunAs
      if (-not (Test-Path "Q:\")) {
        'Q disk is locked.'
      } else {
        'Q disk is not locked.'
      }
      #@#q.lock
    }
  }
  elseif ($args[1] -ieq "all") {
    if (-not (Test-Path "M:\")) {
      'The key capsule is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d M"
      if (-not (Test-Path "M:\")) {
        'The key capsule is dismounted.'
      } else {
        'The key capsule is not dismounted.'
      }
    }
    if (-not (Test-Path "F:\")) {
      'The F disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d F" 
      if (-not (Test-Path "F:\")) {
        'F disk is dismounted.'
      } else {
        'F disk is not dismounted.'
      }
    }
    if (-not (Test-Path "P:\")) {
      'The P disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d P" 
      if (-not (Test-Path "P:\")) {
        'P disk is dismounted.'
      } else {
        'P disk is not dismounted.'
      }
    }
    if (-not (Test-Path "S:\")) {
      'The S disk is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d S" 
      if (-not (Test-Path "S:\")) {
        'S disk is dismounted.'
      } else {
        'S disk is not dismounted.'
      }
    }
    if (-not (Test-Path "Q:\")) {
      'The Q disk is already locked.'
    }
    else {
      #@#q.lock.all
      Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -lock Q:" -Verb RunAs
      if (-not (Test-Path "Q:\")) {
        'Q disk is locked.'
      } else {
        'Q disk is not locked.'
      }
    }
  }
  else {
    if (-not (Test-Path "M:\")) {
      'The key capsule is not mounted.'
    }
    else {
      Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d M"
    }
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