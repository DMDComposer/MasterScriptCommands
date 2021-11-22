#Include <Default_Settings>
;~ --------------------------------------
#SingleInstance,Force
#Include C:\AHK Studio\Lib\Chrome.ahk ;GeekDude Class ; https://github.com/G33kDude/Chrome.ahk https://autohotkey.com/boards/viewtopic.php?t=42890

;~ If problems with errors, try deleting the ChromProfile folder at C:\Users\Dillon\AppData\Local\Temp

WinGetActiveTitle, Title

;~  *************************Create a new Chrome instance********************************

if (Chromes := Chrome.FindInstances()).HasKey(Port){
	port := chromes.maxIndex() + 1
	profile := A_Temp "\ChromeProfile" Port
}else{
	profile := A_Temp "\ChromeProfile"
}

path := "https://distrokid.com/wheel/" ;~ Website to navigate to
Port := 9222 ;~ Remote debugging port

;Create a chrome profile directory if one doesnt exist
if !FileExist(profile)
	FileCreateDir, % profile

ChromeInst := new Chrome(profile,"--app=" path, "",,port)
Page := Chrome.GetPage()
Page.WaitForLoad()

Page.Call("Console.enable") 						;~ watch the console for messages served via javascript
if !(Page := ChromeInst.GetPage())
{
	MsgBox, Could not retrieve page!_
	ChromeInst.Kill()
}
else
{
	Page.WaitForLoad()
}

Loop {
	Sleep, 10
}Until Page.Evaluate("document.readyState").value = "complete"


;~ ^+\::
;~ Select Song I want using index number
Page.Evaluate("document.querySelector(""#wheelSongId"").focus()")
Page.Evaluate("document.querySelector('#wheelSongId').selectedIndex = 40")
Page.Call("Input.dispatchKeyEvent", {"type": "keyDown", "code": "Enter"}) ;~ Works - Actually presses ENTER on button
Page.Call("Input.dispatchKeyEvent", {"type": "keyUp", "code": "Enter"}) ;~ Works - Actually presses ENTER on button

;~ Connect with Spotify
Page.Evaluate("document.querySelector("".buttonSpotify"").focus()")
Page.Call("Input.dispatchKeyEvent", {"type": "keyDown", "code": "Enter"}) ;~ Works - Actually presses ENTER on button
Page.Call("Input.dispatchKeyEvent", {"type": "keyUp", "code": "Enter"}) ;~ Works - Actually presses ENTER on button

Return

;~ m(var)
WinActivate, % Title
Sleep, 50
Send, % var

Notify().AddWindow(var, {Title:"Capitlize my Title", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})

; Close the browser (note: this closes *all* pages/tabs)
Page.Call("Browser.close")
Page.Disconnect()
;~ Loop over files in ChromeProfile folder and delete all
Loop, %profile%\*.*, 1, 0
{
	If InStr(A_LoopFileAttrib, "D")
		FileRemoveDir, %A_LoopFileLongPath%, 1
	Else
		FileSetAttrib, -RASH, %A_LoopFileLongPath%
	FileDelete, %A_LoopFileLongPath%
}

ExitApp

Escape::
;~ Close the browser (note: this closes *all* pages/tabs)
Page.Call("Browser.close")
Page.Disconnect()
ExitApp
Return