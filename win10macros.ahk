#SingleInstance, force
#MaxThreadsPerHotkey 2

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
		SendInput, {F12}
		return
	}

	singleMButtonWait := true
	Sleep, 150

	if singleMButtonWait {
		singleMButtonWait := false
		SendInput, ^{F12}
	}
	return
}

#If

; === Right Alt hotkeys ===================================================================================
; RO chars
>!A::SendInput, {U+0103} ; ă
>!+A::SendInput, {U+0102} ; Ă
>!Q::SendInput, {U+00E2} ; â
>!+Q::SendInput, {U+00C2} ; Â
>!S::SendInput, {U+0219} ; ș
>!+S::SendInput, {U+0218} ; Ș
>!T::SendInput, {U+021B} ; ț
>!+T::SendInput, {U+021A} ; Ț
>!I::SendInput, {U+00EE} ; î
>!+I::SendInput, {U+00CE} ; Î

; DE chars
>!'::SendInput, {U+00E4} ; ä
>!+'::SendInput, {U+00C4} ; Ä
>!;::SendInput, {U+00F6} ; ö
>!+;::SendInput, {U+00D6} ; Ö
>![::SendInput, {U+00FC} ; ü
>!+[::SendInput, {U+00DC} ; Ü
>!-::SendInput, {U+00DF} ; ß

; Other symbols
>!E::SendInput, {U+20AC} ; €
>!=::SendInput, {U+00B1} ; ±

; === Alt hotkeys ===================================================================================
; Alt+Backspace = Del
!Backspace::Send, {Del}

; Alt+1/2 = navigating between desktops
!1::SendEvent, {LWin down}{LCtrl down}{Left down}{Lwin up}{LCtrl up}{Left up}
!2::SendEvent, {LWin down}{LCtrl down}{Right down}{LWin up}{LCtrl up}{Right up}

; Alt+` to open Task View
!SC29::Send, #{Tab}

; Alt+ZXASD media keys
!Z::SendInput, {Volume_Down}
!X::SendInput, {Volume_Up}
!A::SendInput, {Media_Prev}
!S::SendInput, {Media_Play_Pause}
!D::SendInput, {Media_Next}

; Alt+IJKL = arrows
; *!I::SendInput, {Blind}{AltUp}{Up}{AltDown}
!I::SendInput, {Up}
^!I::SendInput, ^{Up}
+!I::SendInput, +{Up}
#!I::SendInput, #{Up}
^+!I::SendInput, ^+{Up}
^#!I::SendInput, ^#{Up}
+#!I::SendInput, +#{Up}

!K::SendInput, {Down}
^!K::SendInput, ^{Down}
+!K::SendInput, +{Down}
#!K::SendInput, #{Down}
^+!K::SendInput, ^+{Down}
^#!K::SendInput, ^#{Down}
+#!K::SendInput, +#{Down}

!J::SendInput, {Left}
^!J::SendInput, ^{Left}
+!J::SendInput, +{Left}
#!J::SendInput, #{Left}
^+!J::SendInput, ^+{Left}
^#!J::SendInput, ^#{Left}
+#!J::SendInput, +#{Left}

!L::SendInput, {Right}
^!L::SendInput, ^{Right}
+!L::SendInput, +{Right}
#!L::SendInput, #{Right}
^+!L::SendInput, ^+{Right}
^#!L::SendInput, ^#{Right}
+#!L::SendInput, +#{Right}

; Alt+8, = 5xUp/5xDown
!8::SendInput, {Up 5}
^!8::SendInput, ^{Up 5}
+!8::SendInput, +{Up 5}
#!8::SendInput, #{Up 5}
^+!8::SendInput, ^+{Up 5}
^#!8::SendInput, ^#{Up 5}
+#!8::SendInput, +#{Up 5}

!,::SendInput, {Down 5}
^!,::SendInput, ^{Down 5}
+!,::SendInput, +{Down 5}
#!,::SendInput, #{Down 5}
^+!,::SendInput, ^+{Down 5}
^#!,::SendInput, ^#{Down 5}
+#!,::SendInput, +#{Down 5}

; Alt+H; = Home/End
!H::SendInput, {Home}
^!H::SendInput, ^{Home}
+!H::SendInput, +{Home}
#!H::SendInput, #{Home}
^+!H::SendInput, ^+{Home}
^#!H::SendInput, ^#{Home}
+#!H::SendInput, +#{Home}

!;::SendInput, {End}
^!;::SendInput, ^{End}
+!;::SendInput, +{End}
#!;::SendInput, #{End}
^+!;::SendInput, ^+{End}
^#!;::SendInput, ^#{End}
+#!;::SendInput, +#{End}

; Alt+UO = Ctrl+arrows
!U::SendInput, ^{Left}
+!U::SendInput, +^{Left}
#!U::SendInput, #^{Left}
+#!U::SendInput, +#^{Left}

!O::SendInput, ^{Right}
+!O::SendInput, +^{Right}
#!O::SendInput, #^{Right}
+#!O::SendInput, +#^{Right}


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
	return (X == 0) && (Y == 0) && (Width == A_ScreenWidth) && (Height == A_ScreenHeight)
}

IsMouseInVerticalMargin() {
	CoordMode, Mouse, Screen
	MouseGetPos, mouseX, mouseY
	return mouseX < 10 || (mouseX > (A_ScreenWidth - 10))
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
