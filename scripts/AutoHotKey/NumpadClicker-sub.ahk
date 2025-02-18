#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock
CapsLock::Insert
Insert::CapsLock
; Remap NumLock @#sub.auto

$NumpadDiv::
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadDiv}"
    } else {
        SendInput "{Ctrl down}"
        SendInput "w"
        SendInput "{Ctrl up}"
        ; / close tab @#sub.auto
    }
}
NumpadDiv & NumLock::
{
    SendInput "{F5}"
    ; /N refresh @#sub.auto
}

NumpadDiv & NumpadSub::
{
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe") {
        SendInput "{Ctrl down}"
        SendInput "{Shift down}"
        SendInput "t"
        SendInput "{Ctrl up}"
        SendInput "{Shift up}"
        ; /- reopen tab @#sub.auto
    }
}

$NumpadMult:: ; send Delete key
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadMult}"
    } else {
        SendInput "{Delete}"
        ; * Delete @#sub.auto
    }
}
NumpadMult & NumLock::
{
    SendInput "{Shift}+{Delete}"
    ; *N shift+Delete @#sub.auto
}

NumpadHome::
{
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
        ; 7 go back @#sub.auto
    }
}
NumpadHome & NumpadSub::
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
        ; 7- go forward @#sub.auto
    }
}

NumpadHome & NumLock::
{
    if (WinGetProcessName("A") == "explorer.exe") {
        SendInput "{Alt down}"
        SendInput "{Up down}"
        SendInput "{Up up}"
        SendInput "{Alt up}"
        ; 7+N go to parent folder @#sub.auto
    }
}

NumpadUp:: ; Ctrl+C
{
    SendInput "^c"
    ; 8 copy @#sub.auto
}
NumpadUp & NumLock:: ; Ctrl+X
{
    SendInput "^x"
    ; 8+N cut @#sub.auto
}
NumpadPgUp:: ; Ctrl+V
{
    SendInput "^v"
    ; 9 paste @#sub.auto
}
NumpadPgUp & NumpadSub::
{
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe") {
        SendInput "{Ctrl down}"
        SendInput "{PgDn}"
        SendInput "{Ctrl up}"
        ; 9- next tab @#sub.auto
    }
}

*NumpadLeft::
{
    SendInput "{Ctrl down}"
    ; 4 Ctrl @#sub.auto
}
*NumpadLeft Up::
{
    SendInput "{Ctrl up}"
    ; 4 Ctrl Up @#sub.auto
}

*NumpadClear:: ; left click
{
    SendInput "{LButton}"
    ; 5 left click @#sub.auto
}

*NumpadRight::
{
    SendInput "{Shift down}"
    ; 6 Shift @#sub.auto
}
*NumpadRight Up::
{
    SendInput "{Shift up}"
    ; 6 Shift up @#sub.auto
}

; you should use $ prefix for preventing triggering SendInput call itself
$NumpadAdd::
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadAdd}"
    } else {
        MouseClick "left", , , 2
        ; + double click @#sub.auto
    }
}
NumpadAdd & NumLock::
{
  SendInput "{Ctrl down}"
  SendInput "a"
  SendInput "{Ctrl up}"
  ; +N select all @#sub.auto
}

NumpadEnd::
{
    MouseClick "WD", , , 2
    ; 1 wheel down @#sub.auto
}
~NumpadEnd & NumLock::
{
    SendInput "{PgDn}"
    ; 1+N pageDown @#sub.auto
}

NumpadDown::
{
    SendInput "{Home}"
    ; 2 Home @#sub.auto
}
NumpadDown & NumLock::
{
    SendInput "{End}"
    ; 2+N End @#sub.auto
}

NumpadPgDn::
{
    MouseClick "WU", , , 2
    ; 3 wheel up @#sub.auto
}
~NumpadPgDn & NumLock::
{
    SendInput "{PgUp}"
    ; 3+N pageUp @#sub.auto
}

$NumpadEnter:: ; right click
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadEnter}"
    } else {
        SendInput "{RButton}"
        ; En right click @#sub.auto
    }
}

global Numpad0_count := 0 ; counting Numpad0 pressed for detacting double Numpad0 pressing
check_counter() {
    global Numpad0_count
    if (Numpad0_count == 1) {
        CoordMode "Mouse", "Screen"
        WinGetClientPos &x, &y, &width, &height, "A"
        scroll_x := x + width - 7
        MouseGetPos &xpos, &ypos
        MouseMove scroll_x, ypos
        DllCall("SetCursorPos", "int", scroll_x, "int", ypos)
        ; 0 MoveToScrollBar @#sub.auto
    } else if (Numpad0_count == 2) {
    }
    Numpad0_count := 0
}

NumpadIns & NumLock::
{
    if WinExist("ahk_exe Everything.exe") {
        WinActivate("ahk_exe Everything.exe")
        ; 0+N Everything @#sub.auto
    }
}

NumpadIns Up::
{
    global Numpad0_count
    Numpad0_count += 1
    SetTimer check_counter, -50
    ; 0 Numpad0 @#sub.auto
}

global is_NumDel_pressed := False
*NumpadDel::
{
    global is_NumDel_pressed
    if (!is_NumDel_pressed) {
        is_NumDel_pressed := True
        MouseClick "left", , , 1, , "D"
        ; . drag start @#sub.auto
    }
}
*NumpadDel Up::
{
    global is_NumDel_pressed
    MouseClick "left", , , 1, , "U"
    is_NumDel_pressed := False
    ; . drag end @#sub.auto
}
