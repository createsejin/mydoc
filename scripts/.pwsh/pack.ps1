$veracrypt = "C:\Program Files\VeraCrypt\VeraCrypt.exe"
# The location of your pack files
$work_dir = "G:\내 드라이브\1.창고\정보\Packs" # if your OS language is set in Korean
$work_dir_eng = "G:\My Drive\1.창고\정보\Packs" # if your OS language is set in English

$pack009 = "Pack009_2024-01-02_001.hc" # key capsule(M disk)

$f_key_file = "M:\Keyfiles\diskF" # F disk keyfile in the key capsule(M disk)
$f_device = "\Device\Harddisk0\Partition2" # You can get device path from Veracrypt program

$p_key_file = "M:\Keyfiles\diskP02"
$p_device = "\Device\Harddisk1\Partition2"

$s_key_file = "M:\Keyfiles\diskS"
$s_device = "\Device\Harddisk2\Partition2"

$q_key_file = "M:\PnQ Key.txt" # Q disk password
$kee_file = "M:\session3.txt" # keepass password

$v_key_file = "M:\Keyfiles\V"
$v_device = "\Device\Harddisk6\Partition1"
#LocationKeyfile@#pack

# alacritty config file for unlock or lock Q disk on Administrator privileges
$alacritty_toml = "C:\\Users\\creat\\mydoc\\win_configs\\alacritty\\alacritty.pwsh.toml"

function help_msg {
  'pack m           : mount key capsule readonly mode'
  'pack m rw        : mount key capsule read and write mode'
  'pack m f         : mount F disk'
  'pack m p         : mount P disk'
  'pack m s         : mount S disk'
  'pack m q         : copy Q disk passwd to clipboard'
  'pack m q s       : mount Q, S disk'      
  'pack m all       : mount F, P, S, Q disk'
  'pack m allv     : mount F, P, S, Q, V disk'

  'pack k           : copy KeePass passwd to clipboard'
  'pack c           : clear clipboard'

  'pack d           : dismount key capsule'
  'pack d f         : dismount F disk'
  'pack d p         : dismount P disk'
  'pack d s         : dismount S disk'
  'pack d q         : lock Q disk'
  'pack d all       : dismount M, F, P, S, and lock Q disk'
  #help msg @#pack
}

function mount_vera_disk {
  # mount veracrypted disk by using keyfile
  param (
    [string]$letter,
    [string]$key_file,
    [string]$device
  )
  if (-not (Test-Path "M:\")) {
    # check key capsule unlocked before get keyfile
    'Please mount key capsule first'
  }
  elseif (Test-Path "$letter`:\") {
    # check whether key capsule is already unlocked
    "$letter disk already mounted."
  }
  else {
    Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow `
      -ArgumentList "/quit /silent /auto /v $device /letter $letter /keyfile $key_file /tryemptypass /cache no"
    #MountDiskFunc@#pack
    if (Test-Path "$letter`:\") {
      "$letter disk successfully mounted."
    }
    else {
      "$letter disk mounting is failed."
    }
  }
}
function dismount_vera_disk {
  # dismount veracrypt disk
  param (
    [string]$letter # which device letter is
  )
  # check if device mounted before proceed command
  if (-not (Test-Path "$letter`:\")) { 
    "The $letter disk is not mounted."
  }
  else {
    # if device mounted, than proceed lock process
    Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -ArgumentList "/q /s /d $letter" 
    #DismountDiskFunc@#pack
    # after lock process, check if successfully lock veracrypt disk
    if (-not (Test-Path "$letter`:\")) {
      "$letter disk is dismounted."
    }
    else {
      "$letter disk is not dismounted."
    }
  }
}
function QdiskUnlock {
  # Q disk is locked by Windows bitlocker which need administrator privilege
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
      # unlock by pwsh with wt
      # Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -unlock Q: -password" -Verb RunAs
      # unlock by pwsh with alacritty
      Start-Process -FilePath "alacritty" -Wait `
        -ArgumentList "--config-file", "$alacritty_toml", `
        "--command", "`"manage-bde -unlock Q: -password`"" -Verb RunAs
      #UnlockQdiskFunc@#pack
      if (Test-Path "Q:\") {
        "Q disk successfully unlocked."
      }
      else {
        "Q disk unlocking is failed."
      }
      Set-Clipboard -Value $null
      "clipboard cleared."
    }
  }
}
function QdiskLock {
  if (-not (Test-Path "Q:\")) {
    'The Q disk is already locked.'
  }
  else {
    # lock by PowerShell within Windows Terminal
    # Start-Process -FilePath "wt" -Wait -ArgumentList "pwsh -c manage-bde -lock Q:" -Verb RunAs

    # lock by PowerShell within Alacritty
    Start-Process -FilePath "alacritty" -Wait `
      -ArgumentList "--config-file", "$alacritty_toml", "--command", "`"manage-bde -lock Q:" -Verb RunAs
    #LockQdiskFunc@#pack

    # check if lock process success
    if (-not (Test-Path "Q:\")) {
      'Q disk is locked.'
    }
    else {
      'Q disk is not locked.'
    } 
  }
}

function keyCapsuleMount {
  # unlock key capsule(M disk)
  param (
    [bool]$rw = $false # if rw set, key capsule is unlocked with read-write mode
    # default is false: unlock key capsule read-only mode
  )
  if (Test-Path "G:\") {
    # test Gdrive loaded
    if ($rw) {
      # read-write mode
      if (Test-Path $work_dir) {
        # work_dir is Gdrive's key capsule location
        # work_dir is Korean path when Windows uses the korean language.
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /m rm /protectMemory /cache no"
      }
      else {
        # If not, this script assumes that the language of the current system is English.
        # work_dir_eng is English path when Windows uses the English language.
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir_eng `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /m rm /protectMemory /cache no"
      }
    }
    else {
      # read-only mode
      if (Test-Path $work_dir) {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /mountoption ro /m rm /protectMemory /cache no" 
      } 
      else {
        Start-Process -FilePath "$veracrypt" -Wait -NoNewWindow -WorkingDirectory $work_dir_eng `
          -ArgumentList "/quit /auto /volume $pack009 /letter M /mountoption ro /m rm /protectMemory /cache no" 
      }
    }
    # after unlock process, check if key capsule successfully unlocked.
    if (Test-Path "M:\") {
      'Key Capsule successfully mounted.'
    }
    else {
      'Key Capsule mount failed.'
    }
  }
  else {
    # if Gdrive path test failed
    'Gdrive is not mounted yet.'
  }
}

if ($args[0] -ieq "m") {
  # unlock(mount) sub command
  if ($args.Count -gt 2) {
    # Examine that the number of arguments exceeds two. 
    foreach ($arg in $args[1..-1]) {
      # unlock two or more devices
      # use case: pack m sq -> unlock S and Q disks
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
      elseif ($arg -ieq "v") {
        mount_vera_disk V $v_key_file $v_device
        #MountDevices@#pack
      }
    }
  }
  else {
    # if the number of arguments is not greater than two, 
    # in other word user input only one disk letter,
    if ($args[1] -ieq "f") {
      # unlock one disk
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
    elseif ($args[1] -ieq "v") {
      mount_vera_disk V $v_key_file $v_device
      #MountVdisk@#pack
    }
    elseif (($args[1] -ieq "all") -or ($args[1] -ieq "allv")) {
      # unlock all devices except V disk
      # check whether key capsule unlocked before proceed unlock all command
      if (-not (Test-Path "M:\")) { 
        'Please mount key capsule first'
      } 
      else {
        # unlock all devices except V disk
        mount_vera_disk F $f_key_file $f_device
        mount_vera_disk P $p_key_file $p_device
        mount_vera_disk S $s_key_file $s_device
        if ($args[1] -ieq "allv") {
          mount_vera_disk V $v_key_file $v_device
          #MountAlldisks@#pack
        }
        QdiskUnlock
      }
    }
    # if user input like: pack m rw
    # than unlock key capsule read-write mode
    elseif ($args[1] -ieq "rw") {
      keyCapsuleMount $true
    }
    else {
      # if user input just 'pack m', than unlock key capsule read-only mode
      keyCapsuleMount $false
    }
  }
}
elseif ($args[0] -ieq "d") {
  # sub command lock(dismount) devices
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
    #DismountDevices@#pack
  }
  elseif ($args[1] -ieq "v") {
    dismount_vera_disk V
  }
  elseif ($args[1] -ieq "all") {
    # dismount all devices include V disk
    dismount_vera_disk F
    dismount_vera_disk P
    dismount_vera_disk S
    dismount_vera_disk M
    dismount_vera_disk V
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