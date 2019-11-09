#SingleInstance, force

; Ctrl+F12 terminates the script.
^F12::ExitApp

; Right most column 10 pixels wide
#If IsMouseInRightArea() && !IsActiveWindowFullScreen()
; MouseWheel = Volume adjust
WheelUp::Send, {Volume_Up}
WheelDown::Send, {Volume_Down}
; Right click = Next
RButton::Send, {Media_Next}
; Middle click = Play/Pause
MButton::Send, {Media_Play_Pause}

#If, IsMouseOverSpotify()
MButton::Send, {Media_Next}

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

IsActiveWindowFullScreen() {
	WinGetActiveStats, Title, Width, Height, X, Y
	; Ignore explorer vlc chrome
	if WinActive("ahk_exe explorer.exe") || WinActive("ahk_exe vlc.exe")
		|| WinActive("ahk_exe chrome.exe") || WinActive("ahk_exe PlexMediaPlayer.exe") || WinActive("ahk_exe Plex.exe")
		return false
	return (X == 0) && (Y == 0) && (Width == A_ScreenWidth)
		&& (Height == A_ScreenHeight)
}

IsMouseInRightArea() {
	CoordMode, Mouse, Screen
	MouseGetPos, mouseX, mouseY
	return (mouseX > (A_ScreenWidth - 10))
}

IsMouseOverSpotify() {
	MouseGetPos, , , windowId
	WinGet, name, ProcessName, ahk_id %windowId%
	return name = "Spotify.exe"
}
