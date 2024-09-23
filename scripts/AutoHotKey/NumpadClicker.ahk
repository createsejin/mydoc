#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock
; Remap NumLock @#auto

*NumpadClear:: ; left click
  {
    SendInput "{LButton}"
    ; left click @#auto
  }

$NumpadEnter:: ; right click
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadEnter}"
    } else {
      SendInput "{RButton}"
      ; right click @#auto
    }
  }

  global Numpad0_count := 0 ; counting Numpad0 pressed for detacting double Numpad0 pressing
  check_counter() 
  {
    global Numpad0_count
    if (Numpad0_count == 2) {
      if (GetKeyState("NumLock", "P")) {
        SendInput "{End}"
        ; end @#auto
      } else {
        SendInput "{Home}"
        ; home @#auto
      }
    }
    Numpad0_count := 0
  }
NumpadIns::
  {
    SendInput "{Ctrl down}"
    ; Ctrl @#auto
  }
NumpadIns Up::
  {
    SendInput "{Ctrl up}"
    global Numpad0_count
    Numpad0_count += 1
    SetTimer check_counter, -50
    ; Numpad0 @#auto
  }

  global is_NumDel_pressed := False
*NumpadDel:: 
  {
    global is_NumDel_pressed
    if (!is_NumDel_pressed)
    {
      is_NumDel_pressed := True
      MouseClick "left",,,1,,"D"
      ; drag start @#auto
    }
  }
*NumpadDel Up:: 
  {
    global is_NumDel_pressed
    MouseClick "left",,,1,,"U"
    is_NumDel_pressed := False
    ; drag end @#auto
  }

  ; you should use $ prefix for preventing triggering SendInput call itself
$NumpadAdd:: 
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadAdd}"
    } else {
      MouseClick "left",,, 2
      ; double click @#auto
    }
  }

$NumpadSub:: 
  {
    if (GetKeyState("Numlock", "T")) {
      SendInput "{NumpadSub}"
    } else {
      MouseClick "left",,, 3
      ; triple click @#auto
    }
  }

NumpadRight:: ; go to scroll bar
  {
    CoordMode "Mouse", "Screen"
    WinGetClientPos &x, &y, &width, &height, "A"
    scroll_x := x + width - 7
    MouseGetPos &xpos, &ypos
    MouseMove scroll_x, ypos
    DllCall("SetCursorPos", "int", scroll_x, "int", ypos)
    ; MoveToScrollBar @#auto
  }

NumpadHome:: ; Ctrl+C 
  {
    SendInput "^c"
  }
NumpadUp:: ; Ctrl+X
  {
    SendInput "^x"
  }
NumpadPgUp:: ; Ctrl+V
  {
    SendInput "^v"
    ; copy and paste
  }

$NumpadMult:: ; send Delete key
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadMult}"
    } else {
      SendInput "{Delete}"
      ; Delete @#auto
    }
  }
NumpadMult & NumLock:: 
  {
    SendInput "{Shift}+{Delete}"
    ; shift+Delete @#auto
  }

*NumpadEnd::
  {
    SendInput "{Shift down}"
    ; Shift @#auto
  }
*NumpadEnd Up::
  {
    SendInput "{Shift up}"
  }
NumpadDown::
  {
    MouseClick "WD",,,2
    ; wheel down @#auto
  }
NumpadPgDn::
  {
    MouseClick "WU",,,2
    ; wheel up @#auto
  }

$NumpadLeft::
  {
    CoordMode "Mouse", "Screen"

    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe" 
    or WinGetProcessName("A") == "explorer.exe") {
      SendInput "{Alt down}"
      SendInput "{Left down}"
      SendInput "{Left up}"
      SendInput "{Alt up}"
    } else {
      SendInput "{Alt down}"
      SendInput "{Left down}"
      SendInput "{Left up}"
      SendInput "{Alt up}"
      ; go back @#auto
    }
  }

NumpadLeft & NumLock::
  {
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe" 
    or WinGetProcessName("A") == "explorer.exe") {
      SendInput "{Alt down}"
      SendInput "{Right down}"
      SendInput "{Right up}"
      SendInput "{Alt up}"
    } else {
      SendInput "{Alt down}"
      SendInput "{Right down}"
      SendInput "{Right up}"
      SendInput "{Alt up}"
      ; go forward @#auto
    }
  }
NumpadClear & NumLock::
  {
    if (WinGetProcessName("A") == "explorer.exe") {
      SendInput "{Alt down}"
      SendInput "{Up down}"
      SendInput "{Up up}"
      SendInput "{Alt up}"
      ; go to parent folder @#auto
    }
  }

$NumpadDiv::
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadDiv}"
    } else {
      SendInput "{Ctrl down}"
      SendInput "w"
      SendInput "{Ctrl up}"
      ; close tab @#auto
    }
  }

NumpadDiv & NumLock::
  {
    SendInput "{F5}"
    ; refresh @#auto
  }