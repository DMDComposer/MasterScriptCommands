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

ChromeInst := new Chrome(profile,"--app=" path, "",,port)  ;~ Can disable this to not create a new instance of chrome but target an exisiting one
Page := Chrome.GetPage()

;~ Page := Chrome.GetPageByURL("https://distrokid.com/wheel/")
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

SetTimer, gExitApp, -60000 ;~ After 1 min exit app

Random, Random_Selection, 40, 41 ;~ Random selection for which songs I want to put on the playlist
;~ Select Song I want using index number
Page.Evaluate("document.querySelector('#wheelSongId').focus()")
Page.Evaluate("document.querySelector('#wheelSongId').selectedIndex =  "Random_Selection" ")
Return
Page.Call("Input.dispatchKeyEvent", {"type": "keyDown", "code": "Enter"}) ;~ Works - Actually presses ENTER on button
Page.Call("Input.dispatchKeyEvent", {"type": "keyUp", "code": "Enter"}) ;~ Works - Actually presses ENTER on button

;~ Connect with Spotify
Loop {
	Sleep, 10
}Until Page.Evaluate("document.querySelector('.buttonSpotify')?.innerText").value = "Connect with Spotify"

h := Page.Evaluate("document.querySelector('.buttonSpotify').offsetHeight").value
w := Page.Evaluate("document.querySelector('.buttonSpotify').offsetWidth").value
/*
	While (h = 0) AND (w = 0) ;if height=0 & Width=0 then not visible
		DebugWindow("not visible",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	if (h != 0 && w != 0)
		DebugWindow("h: " h "w: " w,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	Notify().AddWindow(Page.Evaluate("document.querySelector('.buttonSpotify').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
*/

Page.Evaluate("document.querySelector('.buttonSpotify').click()")

;~ Loop until element is visible
Loop {
	Page.Evaluate("document.querySelector('.buttonPink')?.click()")
	Sleep, 100
}Until Page.Evaluate("document.querySelector('body > div:nth-child(16) > div > div:nth-child(4) > div > div.gameOver > div.wheelSmall')?.innerText").value =  = "Play again tomorrow!`n`nReturn to DistroKid" ;~ Look for Spotify Check out the Playlist to appear
;~ Until Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1) > div:nth-child(4) > a:nth-child(1)')?.innerText").value =  = "Congrats!" ;~ Look for Spotify Check out the Playlist to appear
Notify().AddWindow(Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1)').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})

/*
	
	;~ Loop until element is visible
	Loop {
		Sleep, 10
	}Until Page.Evaluate("document.querySelector('.buttonPink')?.innerText").value = "Spin Wheel"
	
	h := Page.Evaluate("document.querySelector('.buttonPink').offsetHeight").value
	w := Page.Evaluate("document.querySelector('.buttonPink').offsetWidth").value
	While (h = 0) AND (w = 0) ;if height=0 & Width=0 then not visible
		DebugWindow("Spin: not visible",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	if (h != 0 && w != 0)
		DebugWindow("h: " h "w: " w,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	
	Notify().AddWindow(Page.Evaluate("document.querySelector('.buttonPink').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Page.Evaluate("document.querySelector('.buttonPink').click()") ;~ Click on Spin note once, not twice, but THRICE!
	
	Loop {
		Sleep, 10
	}Until Page.Evaluate("document.querySelector('.buttonPink')?.innerText").value = "Spin Again!"
	
	h := Page.Evaluate("document.querySelector('.buttonPink').offsetHeight").value
	w := Page.Evaluate("document.querySelector('.buttonPink').offsetWidth").value
	While (h = 0) AND (w = 0) ;if height=0 & Width=0 then not visible
		DebugWindow("Spin2: not visible",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	if (h != 0 && w != 0)
		DebugWindow("h: " h "w: " w,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	
	Notify().AddWindow(Page.Evaluate("document.querySelector('.buttonPink').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Page.Evaluate("document.querySelector('.buttonPink').click()")
	
	Loop {
		Sleep, 10
	}Until Page.Evaluate("document.querySelector('.buttonPink')?.innerText").value = "Spin once more!"
	
	h := Page.Evaluate("document.querySelector('.buttonPink').offsetHeight").value
	w := Page.Evaluate("document.querySelector('.buttonPink').offsetWidth").value
	While (h = 0) AND (w = 0) ;if height=0 & Width=0 then not visible
		DebugWindow("Spin3: not visible",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	if (h != 0 && w != 0)
		DebugWindow("h: " h "w: " w,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
	
	Notify().AddWindow(Page.Evaluate("document.querySelector('.buttonPink').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Page.Evaluate("document.querySelector('.buttonPink').click()")
	
	Loop {
		Sleep, 10
	}Until Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1) > div:nth-child(4) > a:nth-child(1)')?.innerText = 'Congrats!'") ;~ Look for Spotify Check out the Playlist to appear
	Notify().AddWindow(Page.Evaluate("document.querySelector('.gameOver > div:nth-child(1)').innerText").value, {Title:"Connect with Spotify Button", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	
*/
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
Return


gExitApp:
;~ Close the browser (note: this closes *all* pages/tabs)
Page.Call("Browser.close")
Page.Disconnect()
ExitApp
Return

Escape::
Gosub, gExitApp
Return