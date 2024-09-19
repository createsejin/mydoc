#Requires AutoHotkey v2.0

NumpadClear:: ; left click
  {
    SendInput "{LButton}"
  }

NumpadEnter:: ; right click
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

NumpadAdd:: ; double click
  {
    if (GetKeyState("NumLock", "T")) {
      SendInput "{NumpadAdd}"
    } else {
      MouseClick "left",,, 2
    }
  }

NumpadSub:: ; triple click
  {
    if (GetKeyState("Numlock", "T")) {
      SendInput "{NumpadSub}"
    } else {
      MouseClick "left",,, 3
    }
  }

NumpadRight:: ; go to scroll bar
  {
    WinGetClientPos &x, &y, &width, &height, "A"
    scroll_y := x + width - 7
    MouseGetPos &xpos, &ypos
    MouseMove scroll_y, ypos
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

NumpadMult:: ; send Delete key
  {
    SendInput "{Delete}"
  }

NumpadMult & Backspace:: ; shift+Delete
  {
    SendInput "{Shift}+{Delete}"
  }