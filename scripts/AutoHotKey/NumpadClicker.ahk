#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock
; Remapping @#auto

NumpadClear:: ; left click
  {
    SendInput "{LButton}"
  }

$NumpadEnter:: ; right click
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadEnter}"
    } else {
      SendInput "{RButton}"
    }
  }

  global Numpad0_count := 0 ; counting Numpad0 pressed for detacting double Numpad0 pressing
NumpadIns:: 
  {
    global Numpad0_count

    if (GetKeyState("NumpadIns", "P"))
    { ; whenever press Numpad0, add counter
      Numpad0_count += 1
    }

    if (Numpad0_count < 2) { ; only down one left mouse button
      MouseClick "left",,,1,,"D"
    } else { ; when doble Numpad0 press detact, ignore press down left mouse button and reset counter
      Numpad0_count := 0
      ; drag start @#auto
    }
  }

NumpadDel:: ; drag end
  {
    MouseClick "left",,,1,,"U"
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
      SendInput "{Ctrl down}"
      MouseClick "left",,, 1
      SendInput "{Ctrl up}"
      ; control click @#auto
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
  }

$NumpadMult:: ; send Delete key
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadMult}"
    } else {
      SendInput "{Delete}"
    }
  }
NumpadMult & NumLock:: 
  {
    SendInput "{Shift}+{Delete}"
    ; shift+Delete @#auto
  }

NumpadEnd::
  {
    MouseClick "WD",,,2
  }
NumpadPgDn::
  {
    MouseClick "WU",,,2
  }
NumpadDown::
  {
    SendInput "{Home}"
  }
NumpadDown & NumLock::
  {
    SendInput "{End}"
  }

$NumpadLeft::
  {
    CoordMode "Mouse", "Screen"

    if (WinGetProcessName("A") == "explorer.exe") {
      SendInput "{Backspace}"
    } else if (WinGetProcessName("A") == "chrome.exe") {
      SendInput "{Alt down}"
      SendInput "{Left down}"
      SendInput "{Left up}"
      SendInput "{Alt up}"
    } else if (WinGetProcessName("A") == "whale.exe") {
      SendInput "{Alt down}"
      SendInput "{Left down}"
      SendInput "{Left up}"
      SendInput "{Alt up}"
      ; go back @#auto
    }
  }

NumpadLeft & NumLock::
  {
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe") {
      SendInput "{Alt down}"
      SendInput "{Right down}"
      SendInput "{Right up}"
      SendInput "{Alt up}"
    } else if (WinGetProcessName("A") == "explorer.exe") {
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

NumpadDiv::
  {
    SendInput "{F5}"
    ; refresh @#auto
  }