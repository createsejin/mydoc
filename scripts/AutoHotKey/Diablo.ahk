#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock

NumpadDiv::
{
    SendInput "{Esc}"
    ; / esc @#dia
}

NumpadEnd::
{
    SendInput "1"
    ; 1 skill1 @#dia
}

NumpadDown::
{
    SendInput "2"
    ; 2 skill2 @#dia
}

NumpadPgdn::
{
    SendInput "3"
    ; 3 skill3 @#dia
}

NumpadLeft::
{
    SendInput "4"
    ; 4 skill4 @#dia
}

global is_NumpadClear_pressed := false
NumpadClear:: ; left click
{
    global is_NumpadClear_pressed
    if (!is_NumpadClear_pressed) {
        is_NumpadClear_pressed := true
        SendInput "{LButton down}"
        ; 5 left click @#dia
    }
}
NumpadClear Up:: ; left click
{
    global is_NumpadClear_pressed
    SendInput "{LButton up}"
    is_NumpadClear_pressed := false
    ; 5 left click up @#dia
}

*NumpadRight:: ; right click
{
    SendInput "{RButton}"
    ; 6 right click @#dia
}

NumpadHome::
{
    SendInput "q"
    ; 7 Q potion @#dia
}

NumpadUp::
{
    SendInput "i"
    ; 8 Inventory @#dia
}

NumpadPgup::
{
  SendInput "a"
  ; 9 skill @#dia
}

global Numpad0_count := 0 ; counting Numpad0 pressed for detacting double Numpad0 pressing
check_counter() {
    global Numpad0_count
    if (Numpad0_count == 1) {
    } else if (Numpad0_count == 2) {
        SendInput "z"
        ; 00 ride @#dia
    }
    Numpad0_count := 0
}

NumpadIns Up::
{
    global Numpad0_count
    Numpad0_count += 1
    SetTimer check_counter, -50
    ; 0 Numpad0 @#dia
}

NumpadEnter::
{
    SendInput "{Space}"
    ; En Space @#dia
}

NumpadAdd::
{
  SendInput "{Tab}"
  ; + Tab
}