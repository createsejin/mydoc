#Requires AutoHotkey v2.0

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
NumpadIns:: ; drag start
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
    }
  }

NumpadDel:: ; drag end
  {
    MouseClick "left",,,1,,"U"
  }

  ; you should use $ prefix for preventing triggering SendInput call itself
$NumpadAdd:: ; double click
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadAdd}"
    } else {
      MouseClick "left",,, 2
    }
  }

$NumpadSub:: ; triple click
  {
    if (GetKeyState("Numlock", "T")) {
      SendInput "{NumpadSub}"
    } else {
      SendInput "{Ctrl down}"
      MouseClick "left",,, 1
      SendInput "{Ctrl up}"
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

NumpadMult & Backspace:: ; shift+Delete
  {
    SendInput "{Shift}+{Delete}"
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

$NumpadLeft::
  {
    CoordMode "Mouse", "Screen"

    if (WinGetProcessName("A") == "explorer.exe") {
      SendInput "{Backspace}"
    } else if (WinGetProcessName("A") == "chrome.exe") {
      MouseGetPos &origin_x, &origin_y
      WinGetClientPos &x, &y, &width, &height, "A"
      btn_x := x + 28
      btn_y := y + 82
      ; GoToBack @#auto
      DllCall("SetCursorPos", "int", btn_x, "int", btn_y)
      MouseClick "left",,, 1
      DllCall("SetCursorPos", "int", origin_x, "int", origin_y)
    }
  }

NumpadDiv::
  {
    SendInput "{F5}"
  }