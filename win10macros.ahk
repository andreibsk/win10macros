#NoEnv
#Warn
#SingleInstance, force
#MaxThreadsPerHotkey 2
#MaxHotkeysPerInterval 200

; Vertical margin width
MarginWidth := 10

SendMode, Input
SetKeyDelay, 1 ; Small delay for SendEvent calls

; https://www.autohotkey.com/docs/Hotkeys.htm#Symbols

; Ctrl+Alt+F12 terminates the script.
^!F12::ExitApp

#If IsMouseInVerticalMargin() && (!IsActiveWindowFullScreen() || IsActiveWindowFullScreenException())
; MouseWheel = Volume adjust
WheelUp::Send, {Volume_Up}
WheelDown::Send, {Volume_Down}

#If IsMouseInVerticalMargin() && (!IsActiveWindowFullScreen() || IsActiveWindowFullScreenException()) && !IsActiveWindowMediaKeysException()
; Right click = Next
RButton::Send, {Media_Next}
; Middle click = Play/Pause
MButton::Send, {Media_Play_Pause}

#If IsMouseOverSpotify()
MButton::Send, {Media_Next}

#If IsMouseOverVSCode()
~$MButton::VSCodeGoTo()
VSCodeGoTo() {
	static singleMButtonWait := false

	if singleMButtonWait {
		singleMButtonWait := false
		Send, {F12}
		return
	}

	singleMButtonWait := true
	Sleep, 150

	if singleMButtonWait {
		singleMButtonWait := false
		Send, ^{F12}
	}
	return
}

$RButton::VSCodeFoldLevel3()
VSCodeFoldLevel3() {
	static singleRButtonWait := false

	if singleRButtonWait {
		singleRButtonWait := false
		Send, {Esc}^k^3
		return
	}

	singleRButtonWait := true
	Sleep, 150

	if singleRButtonWait {
		singleRButtonWait := false
		Send, {RButton}
	}
	return
}

#If

; === Right Alt hotkeys ===================================================================================
; RO chars
>!A::Send, {U+0103} ; ă
>!+A::Send, {U+0102} ; Ă
>!Q::Send, {U+00E2} ; â
>!+Q::Send, {U+00C2} ; Â
>!S::Send, {U+0219} ; ș
>!+S::Send, {U+0218} ; Ș
>!T::Send, {U+021B} ; ț
>!+T::Send, {U+021A} ; Ț
>!I::Send, {U+00EE} ; î
>!+I::Send, {U+00CE} ; Î

; DE chars
>!'::Send, {U+00E4} ; ä
>!+'::Send, {U+00C4} ; Ä
>!;::Send, {U+00F6} ; ö
>!+;::Send, {U+00D6} ; Ö
>![::Send, {U+00FC} ; ü
>!+[::Send, {U+00DC} ; Ü
>!-::Send, {U+00DF} ; ß

; Other symbols
>!E::Send, {U+20AC} ; €
>!=::Send, {U+00B1} ; ±

; === Alt hotkeys ===================================================================================
; Alt+Backspace = Del
!Backspace::Send, {Del}

; Alt+1/2 = navigating between desktops
!1::Send, {LWin down}{LCtrl down}{Left down}{Lwin up}{LCtrl up}{Left up}
!2::Send, {LWin down}{LCtrl down}{Right down}{LWin up}{LCtrl up}{Right up}

; Alt+` to open Task View
!SC29::Send, #{Tab}

; Alt+ZXASD media keys
!Z::Send, {Volume_Down}
!X::Send, {Volume_Up}
!A::Send, {Media_Prev}
!S::Send, {Media_Play_Pause}
!D::Send, {Media_Next}

; Alt+IJKL = arrows
; *!I::Send, {Blind}{AltUp}{Up}{AltDown}
!I::Send, {Up}
^!I::Send, ^{Up}
+!I::Send, +{Up}
#!I::Send, #{Up}
^+!I::Send, ^+{Up}
^#!I::Send, ^#{Up}
+#!I::Send, +#{Up}

!K::Send, {Down}
^!K::Send, ^{Down}
+!K::Send, +{Down}
#!K::Send, #{Down}
^+!K::Send, ^+{Down}
^#!K::Send, ^#{Down}
+#!K::Send, +#{Down}

!J::Send, {Left}
^!J::Send, ^{Left}
+!J::Send, +{Left}
#!J::Send, #{Left}
^+!J::Send, ^+{Left}
^#!J::Send, ^#{Left}
+#!J::Send, +#{Left}

!L::Send, {Right}
^!L::Send, ^{Right}
+!L::Send, +{Right}
#!L::Send, #{Right}
^+!L::Send, ^+{Right}
^#!L::Send, ^#{Right}
+#!L::Send, +#{Right}

; Alt+8, = 5xUp/5xDown
!8::Send, {Up 5}
^!8::Send, ^{Up 5}
+!8::Send, +{Up 5}
#!8::Send, #{Up 5}
^+!8::Send, ^+{Up 5}
^#!8::Send, ^#{Up 5}
+#!8::Send, +#{Up 5}

!,::Send, {Down 5}
^!,::Send, ^{Down 5}
+!,::Send, +{Down 5}
#!,::Send, #{Down 5}
^+!,::Send, ^+{Down 5}
^#!,::Send, ^#{Down 5}
+#!,::Send, +#{Down 5}

; Alt+H; = Home/End
!H::Send, {Home}
^!H::Send, ^{Home}
+!H::Send, +{Home}
#!H::Send, #{Home}
^+!H::Send, ^+{Home}
^#!H::Send, ^#{Home}
+#!H::Send, +#{Home}

!;::Send, {End}
^!;::Send, ^{End}
+!;::Send, +{End}
#!;::Send, #{End}
^+!;::Send, ^+{End}
^#!;::Send, ^#{End}
+#!;::Send, +#{End}

; Alt+UO = Ctrl+arrows
; StickyNotes not compatible with SendInput
!U::SendEvent, ^{Left}
+!U::SendEvent, +^{Left}
#!U::SendEvent, #^{Left}
+#!U::SendEvent, +#^{Left}

!O::SendEvent, ^{Right}
+!O::SendEvent, +^{Right}
#!O::SendEvent, #^{Right}
+#!O::SendEvent, +#^{Right}


; === Functions ===================================================================================

IsActiveWindowFullScreenException() {
	WinGetActiveStats, Title, Width, Height, X, Y

	if WinActive("ahk_exe explorer.exe") || WinActive("ahk_exe vlc.exe") || WinActive("ahk_exe chrome.exe")
		|| WinActive("ahk_exe PlexMediaPlayer.exe") || WinActive("ahk_exe Plex.exe") || WinActive("ahk_exe steam.exe")
		|| WinActive("ahk_exe Code.exe") || WinActive("ahk_exe Teams.exe") || WinActive("ahk_exe Skype.exe")
		return true

	return false
}

IsActiveWindowMediaKeysException() {
	WinGetActiveStats, Title, Width, Height, X, Y

	if WinActive("ahk_exe PlexMediaPlayer.exe")
		return true

	return false
}

IsActiveWindowFullScreen() {
	WinGetActiveStats, Title, Width, Height, X, Y
	return Width == A_ScreenWidth && Height == A_ScreenHeight
}

IsMouseInVerticalMargin() {
	global MarginWidth

	CoordMode, Mouse, Screen
	MouseGetPos, mouseX

	if (mouseX >= -MarginWidth && mouseX <= MarginWidth)
		return true
	if (mouseX >= A_ScreenWidth - MarginWidth && mouseX <= A_ScreenWidth + MarginWidth)
		return true

	; https://www.autohotkey.com/docs/commands/SysGet.htm
	SysGet, SM_XVIRTUALSCREEN, 76    ; Coordinates for the left side and the top of the virtual screen
	SysGet, SM_CXVIRTUALSCREEN, 78   ; Width and height of the virtual screen, in pixels.

	if (mouseX >= SM_XVIRTUALSCREEN - MarginWidth && mouseX <= SM_XVIRTUALSCREEN + MarginWidth)
		return true
	if (mouseX >= SM_XVIRTUALSCREEN + SM_CXVIRTUALSCREEN - MarginWidth && mouseX <= SM_XVIRTUALSCREEN + SM_CXVIRTUALSCREEN + MarginWidth)
		return true

	return false
}

IsMouseOverSpotify() {
	MouseGetPos, , , windowId
	WinGet, name, ProcessName, ahk_id %windowId%
	return name = "Spotify.exe"
}

IsMouseOverVSCode() {
	MouseGetPos, , , windowId
	WinGet, name, ProcessName, ahk_id %windowId%
	MouseGetPos, mouseX, mouseY
	; 172px for editor tabs - keep middle click close behavior
	return name = "Code.exe" && mouseY >= 172
}
