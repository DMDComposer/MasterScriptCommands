#Include <Default_Settings>
;~ --------------------------------------
#SingleInstance,Force
#Include C:\AHK Studio\Lib\Chrome.ahk ;GeekDude Class ; https://github.com/G33kDude/Chrome.ahk https://autohotkey.com/boards/viewtopic.php?t=42890

;~ If problems with errors, try deleting the ChromProfile folder at C:\Users\Dillon\AppData\Local\Temp

WinGetActiveTitle, Title

;~  *************************Create a new Chrome instance********************************

if (Chromes := Chrome.FindInstances()).HasKey(Port){
	port := chromes.maxIndex() + 1
	profile := A_ScriptDir "\ChromeProfile" Port
}else{
	profile := A_ScriptDir "\ChromeProfile"
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

;~ Select Song I want using index number
Page.Evaluate("document.querySelector('#wheelSongId').focus()")
Page.Evaluate("document.querySelector('#wheelSongId').selectedIndex = 40")
Page.Call("Input.dispatchKeyEvent", {"type": "keyDown", "code": "Enter"}) ;~ Works - Actually presses ENTER on button
Page.Call("Input.dispatchKeyEvent", {"type": "keyUp", "code": "Enter"}) ;~ Works - Actually presses ENTER on button

m("Pausing before clicking Spotify")
;~ Connect with Spotify
Page.Evaluate("document.querySelector('.buttonSpotify').click()")


;~ Loop until element is visible
Loop {
	Sleep, 10
}Until Page.Evaluate("document.querySelector('.buttonPink')").value = "Spin Wheel"
m(Page.Evaluate("document.querySelector('.buttonPink')").value)
Page.Evaluate("document.querySelector('.buttonPink').click()") ;~ Click on Spin note once, not twice, but THRICE!

Loop {
	Sleep, 10
}Until Page.Evaluate("document.querySelector('.buttonPink').value = 'Spin Again!'")
Page.Evaluate("document.querySelector('.buttonPink').click()")

Loop {
	Sleep, 10
}Until Page.Evaluate("document.querySelector('.buttonPink').value = 'Spin once more!'")
Page.Evaluate("document.querySelector('.buttonPink').click()")

Loop {
	Sleep, 10
}Until Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1) > div:nth-child(4) > a:nth-child(1)')").value = "Congrats!" ;~ Look for Spotify Check out the Playlist to appear
m(Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1)').innerText")) ;~ Grab the Congrats info to send to message box

WinActivate, % Title

; Close the browser (note: this closes *all* pages/tabs)
Page.Call("Browser.close")
Page.Disconnect()
/*
	;~ Loop over files in ChromeProfile folder and delete all
	Loop, %profile%\*.*, 1, 0
	{
		If InStr(A_LoopFileAttrib, "D")
			FileRemoveDir, %A_LoopFileLongPath%, 1
		Else
			FileSetAttrib, -RASH, %A_LoopFileLongPath%
		FileDelete, %A_LoopFileLongPath%
	}
*/

ExitApp



Escape::
;~ Close the browser (note: this closes *all* pages/tabs)
Page.Call("Browser.close")
Page.Disconnect()
ExitApp
Return