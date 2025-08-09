#Requires AutoHotkey v2.0

NumLock::SC02B
Pause::NumLock
CapsLock::Insert
Insert::CapsLock
;RemapNumLock@#auto

$NumpadDiv::
{
  if (GetKeyState("NumLock", "T")) {
    SendInput "{NumpadDiv}"
  } else {
    SendInput "{Ctrl down}"
    SendInput "w"
    SendInput "{Ctrl up}"
    ;/ CloseTab@#auto
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
  ; *+N PermanentDelete @#auto
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

; RisuAI asset image 자동 숫자 adder 단축키
NumpadPgup & NumLock:: ; Yuriko.maid.incoming_kiss.1를 복사한뒤, 새 asset을 선택해 이 단축키를 누르면
; Yuriko.maid.incoming_kiss.2로 만들어준다.
{
  clipboardText := A_Clipboard ; 현재 카피된 클립보드의 내용을 변수에 담는다.
  ; .1로 끝나는 텍스트가 매치된경우
  ; 첫번째 캡쳐그룹은 keyword, 두번째 캡쳐그룹은 number를 나타낸다.
  if RegExMatch(clipboardText, "(.*)\.(\d+)$", &Match)
  {
    keyword := Match[1]
    numberStr := Match[2]

    ; 캡쳐한 숫자에서 +1을 해준다.
    newNumber := Integer(numberStr) + 1

    ; 기존의 keyword와 새로 +1된 숫자를 하나의 텍스트로 합친다.
    newFileName := keyword . "." . newNumber
    A_Clipboard := newFileName ; clipboard에 새로 만들어진 텍스트를 넣어준다.

    OutputDebug newFileName ; for debugging
    Sleep 50 ; Ctrl+V 하기 전 clipboad update할 시간을 잠시 준다.
    SendInput "^v"
    SendInput "{Enter}"
    ;9+N assetAdder@#auto
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

global keyUpCount := 0
global numpadEnd_down := false
global wheel_down := false
global numpadPgDn_down := false
global wheel_up := false
global numlock_down := false
;1,3GlobalVars@#auto.1,3
*NumpadEnd::
{
  global numpadEnd_down
  global numpadPgDn_down
  global wheel_down
  global keyUpCount
  if (!numpadEnd_down) {
    keyUpCount += 1
    numpadEnd_down := true
  }
  if (keyUpCount == 1 and !numpadPgDn_down) {
    MouseClick "WD", , , 2
    ;1 wheelDown@#auto
    wheel_down := true
  }
}
*NumpadEnd Up::
{
  global numpadEnd_down
  global keyUpCount
  global numlock_down
  global wheel_down
  global wheel_up

  if (keyUpCount == 2) {
    SendInput "{Alt down}"
    SendInput "z"
    SendInput "{Alt up}"
    ;1+3 Alt+z@#auto
    if (wheel_down) {
      MouseClick "WU", , , 2
      wheel_down := false
    } else if (wheel_up) {
      MouseClick "WD", , , 2
      wheel_up := false
    }
  }
  keyUpCount := 0
  numpadEnd_down := false
  if (numlock_down) {
    numlock_down := false
  }
}

~NumpadEnd & NumLock::
{
  global numlock_down
  numlock_down := true
  SendInput "{PgDn}"
  ; 1+N pageDown @#auto.1,3
}

NumpadDown::
{
  SendInput "{Home}"
  ; 2 Home @#auto
}
NumpadDown & NumLock::
{
  global numlock_down
  numlock_down := true
  SendInput "{End}"
  ; 2+N End @#auto
}

*NumpadPgDn::
{
  global numpadPgDn_down
  global numpadEnd_down
  global wheel_up
  global keyUpCount
  if (!numpadPgDn_down) {
    keyUpCount += 1
    numpadPgDn_down := true
  }
  if (keyUpCount == 1 and !numpadEnd_down) {
    MouseClick "WU", , , 2
    ;3 wheelUp@#auto
    wheel_up := true
  }
}
*NumpadPgDn Up::
{
  global numpadPgDn_down
  global keyUpCount
  global numlock_down
  global wheel_down
  global wheel_up

  if (keyUpCount == 2) {
    SendInput "{Alt down}"
    SendInput "z"
    SendInput "{Alt up}"
    ;1+3 Alt+z@#auto
    if (wheel_down) {
      MouseClick "WU", , , 2
      wheel_down := false
    } else if (wheel_up) {
      MouseClick "WD", , , 2
      wheel_up := false
    }
  }
  keyUpCount := 0
  numpadPgDn_down := false
  if (numlock_down) {
    numlock_down := false
  }
}

~NumpadPgDn & NumLock::
{
  global numlock_down
  numlock_down := true
  SendInput "{PgUp}"
  ; 3+N pageUp @#auto.1,3
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

NumpadEnter & BackSpace::
{
  OutputDebug "press"
  SendInput "{Enter}"
  ;En+B Enter@#auto
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
    ;00 MoveToScrollBar @#auto
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
  ;MoveToScrollBarByKey @#auto
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
    SendInput "{Alt down}"
    SendInput key
    SendInput "{Alt up}"
    ;AlacrittyMoveFocus@#auto
  } else {
    SendInput "{Ctrl down}"
    SendInput key
    SendInput "{Ctrl up}"
  }
}
$^h:: {
  AlacrittyMoveFocus("h")
}
$^l:: {
  AlacrittyMoveFocus("l")
}
$^j:: {
  AlacrittyMoveFocus("j")
}
$^k:: {
  AlacrittyMoveFocus("k")
}

;F2 VeraCryptTabTab@#auto
F2:: {
  if WinGetProcessName("A") == "VeraCrypt.exe" {
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Space}"

    SendInput "{Shift down}"
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Tab}"
    SendInput "{Shift up}"
  }
}