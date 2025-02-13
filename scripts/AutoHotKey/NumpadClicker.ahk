#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock
CapsLock::Insert
Insert::CapsLock
; Remap NumLock @#auto

$NumpadDiv::
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadDiv}"
    } else {
        SendInput "{Ctrl down}"
        SendInput "w"
        SendInput "{Ctrl up}"
        ; / close tab @#auto
    }
}
NumpadDiv & NumLock::
{
    SendInput "{F5}"
    ; /+N refresh @#auto
}

NumpadDiv & BackSpace::
{
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe") {
        SendInput "{Ctrl down}"
        SendInput "{Shift down}"
        SendInput "t"
        SendInput "{Ctrl up}"
        SendInput "{Shift up}"
        ; /+B reopen tab @#auto
    }
}

$NumpadMult:: ; send Delete key
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadMult}"
    } else {
        SendInput "{Delete}"
        ; * Delete @#auto
    }
}
NumpadMult & NumLock::
{
    SendInput "{Shift}+{Delete}"
    ; *+N shift+Delete @#auto
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
        ; 7 go back @#auto
    }
}
NumpadHome & Backspace::
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
        ; 7+B go forward @#auto
    }
}

NumpadHome & NumLock::
{
    if (WinGetProcessName("A") == "explorer.exe") {
        SendInput "{Alt down}"
        SendInput "{Up down}"
        SendInput "{Up up}"
        SendInput "{Alt up}"
        ; 7+N go to parent folder @#auto
    }
}

NumpadUp:: ; Ctrl+C
{
    SendInput "^c"
    ; 8 copy @#auto
}
NumpadUp & NumLock:: ; Ctrl+X
{
    SendInput "^x"
    ; 8+N cut @#auto
}
NumpadUp & BackSpace::
{
    SendInput "{F2}"
    MouseClick "left", , , 2
    SendInput "^c"
    SendInput "^a"
    SendInput "RJ"
    SendInput "^v"
    SendInput "^a"
    SendInput "^c"
    SendInput "{Enter}"
    ; 8+B RJ tweak @#auto
}
NumpadPgUp:: ; Ctrl+V
{
    SendInput "^v"
    ; 9 paste @#auto
}
NumpadPgUp & BackSpace::
{
    if (WinGetProcessName("A") == "chrome.exe" or WinGetProcessName("A") == "whale.exe") {
        SendInput "{Ctrl down}"
        SendInput "{PgDn}"
        SendInput "{Ctrl up}"
        ; 9+B next tab @#auto
    }
}

*NumpadLeft::
{
    SendInput "{Ctrl down}"
    ; 4 Ctrl @#auto
}
*NumpadLeft Up::
{
    SendInput "{Ctrl up}"
    ; 4 Ctrl Up @#auto
}

*NumpadClear:: ; left click
{
    SendInput "{LButton}"
    ; 5 left click @#auto
}

*NumpadRight::
{
    SendInput "{Shift down}"
    ; 6 Shift @#auto
}
*NumpadRight Up::
{
    SendInput "{Shift up}"
    ; 6 Shift up @#auto
}

; you should use $ prefix for preventing triggering SendInput call itself
$NumpadAdd::
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadAdd}"
    } else {
        MouseClick "left", , , 2
        ; + double click @#auto
    }
}
NumpadAdd & NumLock::
{
    SendInput "{Ctrl down}"
    SendInput "a"
    SendInput "{Ctrl up}"
    ; +N select all @#auto
}

$NumpadSub::
{
    if (GetKeyState("Numlock", "T")) {
        SendInput "{NumpadSub}"
    } else {
        MouseClick "left", , , 3
        ; - triple click @#auto
    }
}
NumpadSub & NumLock::
{
    SendInput "{F2}"
    SendInput "{Right}"
    SendInput "{Space}"
    SendInput "^v"
    SendInput "{Enter}"
    SendInput "^x"
    ; -N RJ title tweak @#auto
}

NumpadEnd::
{
    MouseClick "WD", , , 2
    ; 1 wheel down @#auto
}
~NumpadEnd & NumLock::
{
    SendInput "{PgDn}"
    ; 1+N pageDown @#auto
}

NumpadDown::
{
    SendInput "{Home}"
    ; 2 Home @#auto
}
NumpadDown & NumLock::
{
    SendInput "{End}"
    ; 2+N End @#auto
}

NumpadPgDn::
{
    MouseClick "WU", , , 2
    ; 3 wheel up @#auto
}
~NumpadPgDn & NumLock::
{
    SendInput "{PgUp}"
    ; 3+N pageUp @#auto
}

$NumpadEnter:: ; right click
{
    if (GetKeyState("NumLock", "T")) {
        SendInput "{NumpadEnter}"
    } else {
        SendInput "{RButton}"
        ; En right click @#auto
    }
}

global Numpad0_count := 0 ; counting Numpad0 pressed for detacting double Numpad0 pressing
check_counter() {
    global Numpad0_count
    if (Numpad0_count == 1) {
        SendInput "{Ctrl down}"
        SendInput "z"
        SendInput "{Ctrl up}"
        ; 0 Ctrl+Z @#auto
    } else if (Numpad0_count == 2) {
        CoordMode "Mouse", "Screen"
        WinGetClientPos &x, &y, &width, &height, "A"
        scroll_x := x + width - 7
        MouseGetPos &xpos, &ypos
        MouseMove scroll_x, ypos
        DllCall("SetCursorPos", "int", scroll_x, "int", ypos)
        ; 00 MoveToScrollBar @#auto
    }
    Numpad0_count := 0
}

^+,::
{
    CoordMode "Mouse", "Screen"
    WinGetClientPos &x, &y, &width, &height, "A"
    scroll_x := x + width - 7
    MouseGetPos &xpos, &ypos
    MouseMove scroll_x, ypos
    DllCall("SetCursorPos", "int", scroll_x, "int", ypos)
}

NumpadIns & NumLock::
{
    if WinExist("ahk_exe Everything.exe") {
        WinActivate("ahk_exe Everything.exe")
        ; 0+N Everything @#auto
    }
}

NumpadIns Up::
{
    global Numpad0_count
    Numpad0_count += 1
    SetTimer check_counter, -50
    ; 0 Numpad0 @#auto
}

global is_NumDel_pressed := False
*NumpadDel::
{
    global is_NumDel_pressed
    if (!is_NumDel_pressed) {
        is_NumDel_pressed := True
        MouseClick "left", , , 1, , "D"
        ; . drag start @#auto
    }
}
*NumpadDel Up::
{
    global is_NumDel_pressed
    MouseClick "left", , , 1, , "U"
    is_NumDel_pressed := False
    ; . drag end @#auto
}

AlacrittyMoveFocus(key) {
    if WinExist("ahk_exe alacritty.exe") && WinGetProcessName("A") == "alacritty.exe" {
        ; OutputDebug "ctrl+h pressed."
        SendInput "{Alt down}"
        SendInput key
        SendInput "{Alt up}"
        ;AlacrittyMoveFocus@#auto
    }
}

^h:: {
    AlacrittyMoveFocus("h")
}
^l:: {
    AlacrittyMoveFocus("l")
}
^j:: {
    AlacrittyMoveFocus("j")
}
^k:: {
    AlacrittyMoveFocus("k")
}
