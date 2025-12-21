#Requires AutoHotkey v2.0
#SingleInstance Force ; 스크립트가 한번만 실행되도록 보장한다.

; asset number auto adder에 사용되는 정규식.
global asset_regex := "^(Yuriko\.maid\.)(.*)\.(\d+)$"

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

global g_baseText := "" ; asset 형식의 텍스트의 경우 별도로 저장하는 글로벌 변수
NumpadUp:: ; Ctrl+C
{
  global g_baseText
  global asset_regex
  SendInput "^c"
  Sleep 50 ; copy가 일어난 후 clipboard update를 위해 일정시간 기다린다.
  clipboardText := A_Clipboard ; 현재 카피된 클립보드의 내용을 변수에 담는다.
  ; 만약 copy된 텍스트가 asset 형식이라면,
  if RegExMatch(clipboardText, asset_regex, &Match) {
    ; 해당 텍스트를 글로벌 변수 g_baseText에 저장한다.
    g_baseText := clipboardText
  }
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
  ; 이전에 저장한 g_baseText를 불러온다.
  global g_baseText
  global asset_regex
  clipboardText := g_baseText
  ; g_baseText가 asset_regex 텍스트로 매치된경우
  ; 첫번째 캡쳐그룹은 character prefix, 두번째 캡쳐그룹은 keyword, 세번째는 number를 나타낸다.
  if RegExMatch(clipboardText, asset_regex, &Match) {
    prefix := Match[1] ; Yuriko.maid.
    keyword := Match[2] ; smile
    numberStr := Match[3] ; 2

    ; 캡쳐한 숫자에서 +1을 해준다.
    newNumber := Integer(numberStr) + 1

    ; 기존의 keyword와 새로 +1된 숫자를 하나의 텍스트로 합친다.
    newFileName := prefix . keyword . "." . newNumber
    g_baseText := newFileName ; g_baseText에 새로 만들어진 텍스트를 업데이트 해준다.
    A_Clipboard := newFileName ; clipboard에 새로 만들어진 텍스트를 넣어준다.

    ; OutputDebug newFileName ; for debugging
    Sleep 50 ; Ctrl+V 하기 전 clipboad update할 시간을 잠시 준다.
    SendInput "^v" ; paste 실행
    SendInput "{Enter}" ; Enter
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
    if GetKeyState("NumpadDel", "P") {
      SendInput "{Ctrl down}"
      SendInput "c"
      SendInput "c"
      SendInput "{Ctrl up}"
      ;0+. Ctrl+CC @#auto
    } else {
      SendInput "{Ctrl down}"
      SendInput "z"
      SendInput "{Ctrl up}"
      ;0 Ctrl+Z @#auto
    }
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
$F2:: {
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
    SendInput "{vk15sc138}"
  } else {
    SendInput "{F2}"
  }
}

SafeSoundMute(MuteState, DeviceName) {
  ; 해당 device를 찾지 못하더라도 그냥 실행 흐름을 넘겨주는 함수다.
  try {
    SoundSetMute(MuteState, , DeviceName)
    return true
  } catch {
    ; device를 찾지 못할시 false를 return하고 함수가 종료된다.
    return false
  }
}

global micName := "마이크(MP300)" ; 내 마이크의 device name이다.
global pushToTalk := true ; push to talk 기능 toggle flag

; 초기 script loading시 마이크를 off 시킨다.
SafeSoundMute(true, micName)

Volume_Mute:: ; 마이크의 Push to talk mode와 Always on mode를 토글하는 기능
{
  global micName
  global pushToTalk

  ; pushToTalk 상태를 반전한다.
  pushToTalk := !pushToTalk

  if pushToTalk {
    ; push to talk mode에서는 먼저 마이크를 Mute 시킨다.
    SafeSoundMute(true, micName)
    ShowOverlay("Mic Push to Talk mode")
  } else {
    ; always on mode에서는 마이크를 다시 On 시킨다.
    SafeSoundMute(false, micName)
    ShowOverlay("Mic Always On mode")
  }
  ;MicModeToggle@#auto
}
global MuteMic := false ; mic를 off 시킬지 여부를 저장하는 변수
Volume_Down::
{
  global micName
  global MuteMic
  global pushToTalk

  if pushToTalk {
    return
  }

  MuteMic := !MuteMic

  if MuteMic {
    if SafeSoundMute(true, micName) {
      ShowOverlay("Mic off")
    }
  } else {
    if SafeSoundMute(false, micName) {
      ShowOverlay("Mic on")
      ;MuteMic@#auto
    }
  }
}

$F3:: { ;를 누르면 마이크가 켜진다.
  global pushToTalk
  ; push to talk mode에서만 아래 기능이 동작한다.
  if pushToTalk {
    if !SafeSoundMute(false, "마이크(MP300)") {
      SendInput "{F3 down}"
    }
  } else {
    SendInput "{F3 down}"
  }
}

$F3 up:: { ;를 떼면 마이크가 꺼진다.
  global pushToTalk
  if pushToTalk {
    if !SafeSoundMute(true, "마이크(MP300)") {
      SendInput "{F3 up}"
    }
  } else {
    SendInput "{F3 up}"
  }
  ;PushToTalk@#auto
}

global g_overlayGui := Gui()

ShowOverlay(text) {
  global g_overlayGui

  ; 만약 이전에 표시된 오버레이가 아직 있다면 먼저 제거
  if IsObject(g_overlayGui)
    g_overlayGui.Destroy()

  ; 1. 새로운 Gui 객체 생성
  g_overlayGui := Gui()
  g_overlayGui.Opt("+AlwaysOnTop -Caption +ToolWindow") ; 항상 위에, 제목 표시줄 없음, 작업 표시줄에 안 나옴
  g_overlayGui.BackColor := "EEAA99" ; (선택사항) 배경색 설정
  g_overlayGui.SetFont("s32 bold", "맑은 고딕") ; 폰트 크기, 굵게, 글꼴 설정

  ; 2. 텍스트 컨트롤 추가
  g_overlayGui.Add("Text", "cWhite", text) ; 흰색 글씨로 텍스트 추가

  ; 3. 배경을 투명하게 만듦 (글자만 보이게)
  g_overlayGui.BackColor := "EEAA99" ; 0(투명) ~ 255(불투명)
  WinSetTransColor("EEAA99", g_overlayGui)

  ; 4. Gui의 크기를 텍스트에 맞게 조절
  g_overlayGui.Show("AutoSize Center NA") ; 자동 크기, 화면 중앙, 활성화 안 함

  ; 5. 2초 후에 Gui를 파괴(제거)하는 타이머 설정
  SetTimer(() => g_overlayGui.Destroy(), -1500)
}

device_listing() { ; device 목록 출력
  default_device := SoundGetName()
  OutputDebug "default device is " default_device

  device := 1
  device_num := 1
  loop {
    try {
      device := SoundGetName(, device_num)
      OutputDebug "device" device_num " is " device
      device_num++
    } catch TargetError {
      OutputDebug "all deivce scanned"
      break
    }
  }

  mp300 := SoundGetName(, "스피커(MP300)")
  OutputDebug "\nmp300 = " mp300
}
;deviceListing@#auto
