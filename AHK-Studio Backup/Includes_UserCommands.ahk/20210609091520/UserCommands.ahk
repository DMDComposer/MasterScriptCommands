vIni_Dir_Path  := "C:\AHK Scripts\_Master Script\Run\Master Search Box\Includes\Directory Paths.ini"
oDir_Paths     := DMD_Ini2Obj(vIni_Dir_Path)
oDirs          := oDir_Paths.Directory_Paths
oIcons         := oDir_Paths.Icon_Paths
DetectHiddenWindows, Off													;~ Ensure Window is off unless specificed by command. Important for certain AHK scripts for this to be off
if (MasterScriptCommands = "ahk "){ ;~ Search for AHK Related Info
	gui_search_title:= "What would you like to search?"
	gui_Change_Title("Autohotkey Google Search","#00FF00",Icon_AHK)
	;~ gui_search("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk0356faDBEtpcEjEwIwMscFvTxXMmg%3A1590206661049&ei=xaDIXsXJAq6vytMPh5ChgAU&q=site%3Astackoverflow.com+REPLACEME&oq=site%3Astackoverflow.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DwR1iDZGCnZ2gAcAB4AIABhgGIAcQHkgEEMTAuMpgBAKABAqABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwiFwJq5jcnpAhWul3IEHQdICFAQ4dUDCAs&uact=5")
	;~ gui_search("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk02CuZqxN5n_fDw_33Asi02z9bthxw%3A1590206200889&ei=-J7IXuruNd6tytMP1b6sgAc&q=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&oq=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&gs_lcp=CgZwc3ktYWIQAzoECAAQR1CViwlYpK8JYJuyCWgIcAF4AIABTYgBiAqSAQIxOZgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwjqyuTdi8npAhXelnIEHVUfC3AQ4dUDCAs&uact=5")
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l=")
}
;-------------------------------------------------------------------------------
;;; LAUNCH DIRECTORIES ;;;
;--------------------------------------------------------------------------------
else if(oDirs.HasKey(MasterScriptCommands)){ ;~ Testing Directory Objects
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	for Key,Value in oDirs
	{
		if (Key ~= "i)" MasterScriptCommands) 
		{
			Value := (Value ~= "%A_Username%" ? StrReplace(Value, "%A_Username%", A_UserName) : Value)
			Run, % Value
		}
	}
}
else if(oIcons.HasKey(MasterScriptCommands)){ ;~ Icon Directory
	gui_destroy()
	for Key,Value in oIcons
	{
		if (Key ~= "i)" MasterScriptCommands) 
		{
			Value       := (Value ~= "%A_Username%" ? StrReplace(Value, "%A_Username%", A_UserName) : Value)
			
			RestoreClip := ClipboardAll
			Clipboard   := Value
			ClipWait, 1
			if (ErrorLevel)
				Msgbox % "Nothing on Clipboard"
			Sleep, 250 ;~ wait for window to reactivate.
			SendEvent, ^v
			Sleep, 100 ;~ Sleep needed otherwise could error and send original clipboard, if error still raise the sleep time
			Clipboard   := RestoreClip
		}
		
	}
}
else if(MasterScriptCommands = "add icon" || MasterScriptCommands = "add dir"){ ;~ Add Icon Path to ini File
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	vType := RegExReplace(MasterScriptCommands, "i)add\s", "")
	InputBox, vNew_Key, % "New " vType " Name", % "New " vType " Name: ~Add new Key to ini file"
	if ErrorLevel
		Return
	If (vNew_Key != ERROR){
		MsgBox,308,Name Exists,This %vType% already exists`, would you like to overwrite it?
		IfMsgBox,No
			Return
	}
	InputBox, vNew_Value, % "New Path for " vType,  % "New " vType " Path: ~Add new Value to ini file"
	if ErrorLevel
		Return	
	if (MasterScriptCommands ~= "dir")
	{
		IniWrite, % vNew_Value, % vIni_Dir_Path, Directory_Paths, % "dir " vNew_Key ;~ Write to Dir Paths		
	}
	if (MasterScriptCommands ~= "icon")
		IniWrite, % vNew_Value, % vIni_Dir_Path, Icon_Paths, % "icons." vNew_Key ;~ Write to Icons Paths
}
/*
	delse if(MasterScriptCommands = "add dir"){ ;~ Add Directory Path to ini File
		gui_destroy()
		Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		InputBox, vNew_Value, % "New Path for Directory",  % "New Directory Path: ~Add new Value to ini file"
		if ErrorLevel
			Return
		
	}
*/

/*
	else if(MasterScriptCommands = "Eval" || MasterScriptCommands = Math){ ;~ Run Ahk Math Eval
		gui_search_title:= "Type in your Math Equation"
		gui_Change_Title("Fun With Math","#81a2be")
		gui_search("REPLACME")
	}
*/
else if(MasterScriptCommands = "album cover" || MasterScriptCommands = "search album cover"){ ;~ Search Album Covers
	gui_search_title = Search for Album Covers
	gui_search("https://www.albumartexchange.com/covers?q=REPLACEME&fltr=ALL&sort=DATE&status=&size=any")
}
else if(MasterScriptCommands = "amazon "){ ;~ Search Amazon
	gui_Change_Title("Amazon Search","#FF9900")
	gui_search_title:= "What would you like to search?"
	gui_search("https://www.amazon.com/s?k=REPLACEME&ref=nb_sb_noss_2")
}
else if(MasterScriptCommands = "fontawesome"){ ;~ Search FontAwesome & Other Icons
	gui_search_title:= "Search for FontAwesome Icons"
	gui_search("https://fontawesome.com/icons?d=gallery&p=2&q=REPLACEME&m=free")	
}
else if(MasterScriptCommands = "g. " || MasterScriptCommands = "google"){ ;~ Search Google
	gui_Change_Title("Google Search","#4285F4")
	gui_search_title:= "Let Me Google That For You..."
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
}
else if(MasterScriptCommands = "gifs"){ ;~ Search for Gifs
	gui_search_title:= "Search Giphy for Gifs"
	gui_search("https://giphy.com/search/REPLACEME")
}
else if(MasterScriptCommands = "icon search" || MasterScriptCommands = "search icons"){ ;~ Search for Icons
	gui_search_title:= "What would you like to search?"
	gui_Change_Title("Icon Search","#00FF00",Icon_AHK)
	gui_search("https://www.deviantart.com/search?q=REPLACEME%20icons")
	gui_search("https://iconscout.com/icons/REPLACEME?price=free")
	gui_search("https://icon-icons.com/search/icons/?filtro=REPLACEME")
	gui_search("https://material.io/resources/icons/?search=REPLACEME&icon=anchor&style=baseline")
	gui_search("https://www.flaticon.com/search?word=REPLACEME&search-type=icons&license=selection&order_by=4&grid=small")
}
else if(MasterScriptCommands = "private "){ ;~ Private Firefox Window
		;   A note on how this works:
	;   The function name "gui_search()" is poorly chosen.
	;   What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
	;   Before the command is Run, the word REPLACEME is replaced by your input.
	;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
	;   So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.	
	gui_search_title:= "Google Search as Private Window in Firefox"
	;~ gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME")
	gui_search("C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?safe=off&q=REPLACEME")
}
else if(MasterScriptCommands = "tor. "){ ;~ Search Torrent Networks
	gui_search_title:= "What would you like to search?"	
	gui_Change_Title("Search Torrent Networks","#00FF00")
	Chrome:="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	gui_search(Chrome " https://rutracker.org/forum/tracker.php?nm=REPLACEME")
	gui_search(Chrome " https://audioclub.in/?s=REPLACEME")
	gui_search(Chrome " https://audioz.download/")
	gui_search(Chrome " https://www.1377x.to/search/REPLACEME/1/")
	gui_search(Chrome " https://courseboat.com/gsearchv4/?q=REPLACEME")
	;~ Notify Variables have to go below the GUI Actions.
	Icon:= "C:\Program Files (x86)\qBittorrent\qbittorrent.exe"
	;~ Title:= "New Title"
}
else if(MasterScriptCommands = "udemy" || MasterScriptCommands = "Skillshare"){ ;~ Search for Free Udemy Courses
	gui_search_title:= "Type in the Name of the Class"
	gui_Change_Title("Udemy/Skillshare Class Search","c00FF84")
	gui_search("https://www.google.com/search?sxsrf=ALeKk01lOccrdqCp22gQcH4RUd3zxa3mWw%3A1591452543507&ei=f6PbXr7GHoPj_Aaw_6WgBQ&q=site%3Afreecoursesite.com+puppeteer&oq=site%3Afreecoursesite.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DQH1jQH2DpIWgAcAB4AIAB1gGIAeIFkgEFMC4zLjGYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwj-gaHcru3pAhWDMd8KHbB_CVQQ4dUDCAs&uact=5")
	gui_search("https://freecoursesite.us/?s=REPLACEME")
	gui_search("https://www.1377x.to/search/REPLACEME/1/")
}
else if(MasterScriptCommands = "math" || MasterScriptCommands - "Eval"){ ;~ Perform Math Equation
	gui_destroy()
	gui_search_title:= "Perform Math"
	gui_Change_Title("Math Time!","c00FF84")
	gui_search(m("Fix mE"))
}
else if(MasterScriptCommands = "you " || MasterScriptCommands = "youtube " || MasterScriptCommands = "yt. "){ ;~ Search Youtube
	gui_search_title:= "What would you like to search?"
	gui_Change_Title("YouTube Search","#E62522",Icon_YouTube)
	gui_search("https://www.youtube.com/results?search_query=REPLACEME&page=&utm_source=opensearch")
}
;-------------------------------------------------------------------------------
;;; SEARCH OTHER THINGS ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "the. "){ ;~ Search Thesaurus
	gui_search_title = Search Thesaurus
	gui_search("https://www.thesaurus.com/browse/REPLACEME?s=t")	
}
else if(MasterScriptCommands = "dic. "){ ;~ Search Dictionary
	gui_search_title = Search Dictionary
	gui_search("https://www.dictionary.com/browse/REPLACEME?s=t")	
}
else if(MasterScriptCommands = "Youtube " || MasterScriptCommands = "yt "){ ;~ Search Youtube
	gui_search_title = Search Youtube
	gui_search("https://www.youtube.com/results?search_query=REPLACEME")	
}
else if(MasterScriptCommands = "keys" || MasterScriptCommands = "hk ahk"){ ;~ List of Key Modifiers AHK Help
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run https://www.autohotkey.com/docs/KeyList.htm#Keyboard
}
;-------------------------------------------------------------------------------
;;; LAUNCH WEBSITES AND PROGRAMS ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "calendar"){ ;~ Google Calendar
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run https://www.google.com/calendar
}
else if(MasterScriptCommands = "note"){ ;~ Notepad
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\notepad.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run Notepad.exe
	;~ Run Notepad++.exe
}
else if(MasterScriptCommands = "paint" || MasterScriptCommands = "mspaint"){ ;~ Run MS Paint
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run "C:\Windows\system32\mspaint.exe"
}
else if(MasterScriptCommands = "steam"){ ;~ Steam
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "C:\Program Files (x86)\Steam\steam.exe"
}
else if(MasterScriptCommands = "extract icons"){ ;~ Extract Icons
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "D:\Program Files (x86)\iconsext\iconsext.exe"
}
else if(MasterScriptCommands = "whats"){ ;~ WhatsAPP
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Toggle_App("WhatsApp", "C:\Users\Dillon\AppData\Local\WhatsApp\WhatsApp.exe")
}
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// Window Programs  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if (MasterScriptCommands = "calc"){ ;~ Calculator
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\calc.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x464646", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
	DetectHiddenWindows, Off ;~ Have to turn off for Calc to appear
	Toggle_App("Calc", "C:\Windows\System32\calc.exe")
	DetectHiddenWindows, On ;~ Returning to original state
}
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// AHK Scripts  //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if (MasterScriptCommands = "encrypt"){ ;~ Word Encryption
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "C:\AHK Scripts\Tools\Encryption Tool\Encryption User Tool.ahk"
}
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// Quick Links  //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if(MasterScriptCommands = "asfyt ost"){ ;~ Atun-Shei Films YouTube OST Link
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "https://youtu.be/oPVpWYQuQsU"
}
else if(MasterScriptCommands = "spin wheel"){ ;~ Spin Distrokid Wheel
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\icons\Distrokid.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\Distrokid Spin Wheel.ahk")
}
else if(MasterScriptCommands = "distrokid week"){ ;~ Distrokid's Weekly Voting Playlist
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\icons\Distrokid.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Chrome\Distrokid Weekly Vote\Distrokid Weekly Vote.ahk")
}
;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "rel" || MasterScriptCommands = "refresh"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	SendInput, {F21} ;~ Reload Script Button	
	Reload
}
else if(MasterScriptCommands = "force rel"){ ;~ Force Reload of MSC SCript
	gui_destroy()
	Gosub, RunReload
}
else if(MasterScriptCommands = "_" || MasterScriptCommands = "master"){ ;~ Reload Master Script
	gui_destroy() ; removes the GUI even when the reload fails
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\_Master Script.ahk") 	
}
else if(MasterScriptCommands = "dir msc"){ ;~ Directory of Master Script Commands
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, %A_ScriptDir%	
}

;-------------------------------------------------------------------------------
;;; MISCELLANEOUS ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "hosts"){ ;~ Edit Hosts File
	gui_destroy()
	Run "C:\Program Files\Notepad++\notepad++.exe" "C:\Windows\System32\drivers\etc\hosts"	
}
else if(MasterScriptCommands = "date"){ ;~ Date
	gui_destroy()
	FormatTime, date,, LongDate
	MsgBox %date%
	date =	
}
else if(MasterScriptCommands = "week"){ ;~ Which week is it?
	gui_destroy()
	FormatTime, weeknumber,, YWeek
	StringTrimLeft, weeknumbertrimmed, weeknumber, 4
	if (weeknumbertrimmed = 53)
		weeknumbertrimmed := 1
	MsgBox It is currently week %weeknumbertrimmed%
	weeknumber =
	weeknumbertrimmed =
}
else if(MasterScriptCommands = "?"){ ;~ Tooltip of List of Commands Available
	GuiControl,, MasterScriptCommands, ; Clear the input box
	m(st_columnize(Sifted_Text, "csv", 2,,A_Tab))
}
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// Run Programs //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if(MasterScriptCommands = "window position"){ ;~ Get Active Window Positon
	gui_destroy()
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y,,, A
	MsgBox, %WinTitle% is at %X%`,%Y%
}
else if (MasterScriptCommands = "spy"){ ;~ AHK Spy
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AU3_Spy.exe",,,001
	WinWaitActive, ahk_pid %001%
	WinMove,ahk_pid %001%,,1219,263
	Sleep, 100
	;~ Run, "C:\AHK Scripts\Tools\Simple Spy\SimpleSpy.exe",,,002
	;~ WinWaitActive, ahk_pid %002%
	;~ WinMove,ahk_pid %002%,,97,367
}
else if (MasterScriptCommands = "edge"){ ;~ Edge
	gui_destroy()
	Run, microsoft-edge:http://www.google.com/
}
else if (MasterScriptCommands = "ie"){ ;~ Internet Explorer
	gui_destroy()
	Run, iexplore
}
else if(MasterScriptCommands = "cap" || MasterScriptCommands = "title"){ ;~ Check Title Capilzation
	gui_destroy()
	DMD_RunShortcut("C:\AHK Scripts\Tools\API Codes\Captilize My Title\Captilize My Title API.ahk")
}
else if(MasterScriptCommands = "magick"){ ;~ Magickk
	gui_destroy()
	;~ Run, "C:\AHK Scripts\Tools\Magick"
	;~ Run *Runas "C:\AHK Scripts\Tools\Magick\Base64 Images.ahk"
	Run, "C:\AHK Scripts\Tools\Magick\Base64 Images.ahk"
}
else if(MasterScriptCommands = "script icons"){ ;~ Master Script Icon List
	gui_destroy()
	Run, "C:\Program Files\Notepad++\notepad++.exe" "C:\AHK Scripts\_Master Script\Resources\Icons.ini"
}
else if(MasterScriptCommands = "itunes"){ ;~ Itunes
	gui_destroy()
	Run, "C:\Program Files\iTunes\iTunes.exe"
	Command_Gui({Icon:"Itunes",Background:"#FFFFFF",Title:"iTunes",Color:"#000000"}) ;~ Title | Icon | Background | Color | SleepTimer | Gradient |
}
else if(MasterScriptCommands = "grabby" || MasterScriptCommands = "amt"){ ;~ Grabby / Automate My Task
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Automate_my_Task - Shortcut.lnk"
}
else if(MasterScriptCommands = "winamp"){ ;~ Winamp
	gui_destroy()
	Run, "C:\Program Files (x86)\Winamp\winamp.exe"	
}
else if(MasterScriptCommands = "click spam" || MasterScriptCommands = "spam click" || MasterScriptCommands = "mouse click" || MasterScriptCommands = "spam mouse"){ ;~ Spam Left Click
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Left Click Spam.ahk"
}
else if(MasterScriptCommands = "piano"){ ;~ Open Kontakt with Sketch Piano
	gui_destroy()
	Notify().AddWindow("Piano", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Kontakt, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x000000", Color:"0xDF782F", TitleColor:"0xFFFFFF"})
	Run, "I:\Kontakt Channel Sets\Pianos\Sketch Piano_Walker 1955 Concert D - Binaural 1.1.nki"
}
else if(MasterScriptCommands = "sketch"){ ;~ Open Kontakt with Sketch Piano
	gui_destroy()
	Notify().AddWindow("Piano", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Kontakt, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x000000", Color:"0xDF782F", TitleColor:"0xFFFFFF"})
	Run, "C:\Users\Dillon\AppData\Local\Native Instruments\Kontakt\default\Sketching Template.nkm"
}
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////// Commands ////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if (MasterScriptCommands = "cubase convert"){ ;~ Convert Audio or Video files
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	global Width,Height,FFMpeg,FFMpegFolder
	FFMpeg       := "C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
	FFMpegFolder := "C:\Program Files (x86)\FFmpeg\bin\"
	b            := Clipboard	
	;~ SB_SetText("Ready")
	SplitPath,b,FileName,Dir,Ext,NNE
	;~ m(b)
	;~ m(FileName)
	;~ SB_SetText("Converting: " FileName)
	if(Ext="wav"){
		FileName := Dir "\" NNE ".mp3"		
		RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
	}else if(Ext~="i)\b(mov|mp4)\b"){
		FileName := Dir "\" NNE """-converted"".mp4"		
		Run,"%FFMpeg%" -i "%b%" -s 640x480 "%FileName%",, ;~ Converting to low quality for use in Cubase etc.
	}
	Return
}
else if(MasterScriptCommands = "convert"){ ;~ Convert to Mp4
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	global Width,Height,FFMpeg,FFMpegFolder
	FFMpeg       := "C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
	FFMpegFolder := "C:\Program Files (x86)\FFmpeg\bin\"
	b            := Clipboard	
	;~ SB_SetText("Ready")
	SplitPath,b,FileName,Dir,Ext,NNE
	;~ m(b)
	;~ m(FileName)
	;~ SB_SetText("Converting: " FileName)
	if(Ext="wav"){
		FileName := Dir "\" NNE ".mp3"		
		RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
	}
	else if(Ext~="i)\b(mkv)\b"){
		FileName := Dir "\" NNE """.mp4"		
		Run,"%FFMpeg%" -i "%b%" -codec copy "%FileName%",,
	;~ cmd       := "ffmpeg -i input.mkv -codec copy output.mp4"
	}	
	Return
}
else if(MasterScriptCommands = "Sound"){ ;~ Open Sound Control Panel
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"c:\windows\system32\control.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Return
	Run c:\windows\system32\control.exe mmsys.cpl,,2
	WinWait, ahk_exe rundll32.exe
	MoveWindowtoCenter("ahk_exe rundll32.exe")
}
else if(MasterScriptCommands = "mixer"){ ;~ Open Volume Mixer
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\Mixer.ahk")
}
else if(MasterScriptCommands = "empty"){ ;~ Empty RecycleBin
	gui_destroy()
	Notify().AddWindow("Empty RecycleBin", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"D:\Folder Icons\WIndows 10 Icons\imageres_54.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x0489D8", TitleColor:"0x0489D8"})
	FileRecycleEmpty
}
else if(MasterScriptCommands = "twitch"){ ;~ Mute/Unmute Twitch Stream
	gui_destroy()
	Focus_Send({Window:"Twitch Stream - VLC media player ahk_class Qt5QWindowIcon",Title:"Mute/Unmute Twitch Stream",Keys:"m",Focus:"1",Icon:"Twitch",Background:"#5A3E85"}) ;~ Focus_Send({}) ;~ Window | Title | Keys | Background | Color | TitleMatchMode | Focus | Icon | Gradient
}
else if(MasterScriptCommands = "y2mp3"){ ;~ Youtube to Mp3
	gui_destroy()
	ydl   := """C:\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe"""Chr(32)
	cmd   := "--extract-audio --audio-format mp3"Chr(32)
	vid   := Chr(34) Clipboard Chr(34) Chr(32)
	dir   := "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
	y2mp3 := ydl cmd vid dir	
	Run, %y2mp3%,,,PID	
	Notify().AddWindow(y2mp3,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP3",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	Run, "D:\Users\Dillon\Downloads\Youtube Downloader"	
}
else if(MasterScriptCommands = "y2mp4"){ ;~ Youtube to Mp4
	gui_destroy()
	;~ cmd:= "--extract-audio --audio-format mp3"Chr(32)
	ydl   := """C:\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe"""Chr(32)
	vid   := Chr(34) Clipboard Chr(34) Chr(32)
	dir   := "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
	y2mp3 := ydl vid dir	
	Run, %y2mp3%,,,PID	
	Notify().AddWindow(y2mp4,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP4",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	Run, "D:\Users\Dillon\Downloads\Youtube Downloader"
}
else if(MasterScriptCommands = "pastebin" || MasterScriptCommands = "share code"){ ;~ Share AHK Code
	gui_destroy()
	Clipboard:=AHKPastebin(Clipboard,"Dillon",1,1) ;~ 1 will run it in your default browser, 0 doesn't
}
else if(MasterScriptCommands = "ip. " || MasterScriptCommands = "myip"){ ;~ Grab my ip
	gui_destroy()
	var:= ClipBoard
	Clipboard:="Public ip is: " GetIP("http://www.netikus.net/show_ip.html") "`n`nPrivate IP is:" A_IPAddress1
	;~ MsgBox 64, IP Address, % Clipboard
	Notify().AddWindow(Clipboard,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"IP Address",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	GetIP(URL){
		http:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
		http.Open("GET",URL,1)
		http.Send()
		http.WaitForResponse
		If (http.ResponseText="Error"){
			MsgBox 16, IP Address, Sorry, your public IP address could not be detected
			Return
		}
		Return http.ResponseText
	}
}
else if(MasterScriptCommands = "mymac"){ ;~ My Mac Address
	gui_destroy()	
	mymac:=GetMacAddress()
	ClipBoard:=mymac
	GetMacAddress(){
		Runwait, %ComSpec% /c getmac /NH | clip,,hide
		RegExMatch(clipboard, ".*?([0-9A-Z].{16})(?!\w\\Device)", mac)
		Return %mac1%
	}
	Notify().AddWindow(mymac, {Title:"Troublemaker MAC: Address", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "port"){ ;~ Change Port for qBittorent
	gui_destroy()
	Random,port,40000,70000
	Toggle_App(qBittorent, "C:\Program Files (x86)\qBittorrent\qbittorrent.exe")
	WinWaitActive, qBittorrent	
	SendInput, !o
	WinWaitActive, Options ahk_exe qbittorrent.exe
	SendInput, +Tab {Down 2}{Sleep 10}{Tab}
	Send, % port
	SendInput, {+Tab 4}{Return}
	Return
	/*
		Run, C:\AHK Scripts\Tools\qBittorent Port Change.ahk
		;*********Use For loop over Var going line by line*********************
		Prog:=WinExist("ahk_class AutoHotkeyGUI")
		for i, row in Loopobj:=StrSplit(var,"`n","`r`n") { ;Parse Var on each new line
			SetTaskbarProgress((i/(Loopobj.Count()-1))*100,"E",Prog) ;N=green, P=Yellow E=Red
			Menu , tray, tip, % round((i-1)/(Loopobj.Count()-1)*100) "% done. " i-1 " of " Loopobj.Count()-1  ;Progress in system tray icon
			Sleep, 10
		}
		SetTaskbarProgress(0,,Prog) ;Reset colors
	*/
}
else if(MasterScriptCommands = "test"){ ;~ Open Code Quick Tester
	gui_destroy()
	Run, C:\AHK Scripts\Tools\CodeQuickTester\CodeQuickTester.ahk
}
else if(MasterScriptCommands = "mom"){ ;~ Message Mom
	gui_destroy()
	;~ gui_search()
	var:= clipboard	
	WinActivate, ahk_exe Messenger.exe
	WinWaitActive, ahk_exe Messenger.exe
	SendInput,^k
	Sleep, 100
	Send, Mom
	Sleep, 500
	SendInput, ^1
	Sleep, 500
	SendInput, % var
	Return
}
else if(MasterScriptCommands = "midi"){ ;~ Rest Midi Devices
	gui_destroy()
	Process, Close, midiox.exe
	Run, "C:\Program Files (x86)\MIDIOX\midiox.exe"
	Sleep, 500
	WinActivate, ahk_exe midiox.exe
	WinWaitActive, ahk_exe midiox.exe
	WinMinimize, ahk_exe midiox.exe
	Return
}
else if(MasterScriptCommands = "notion"){ ;~ Toggle Notion App
	gui_destroy()
	Toggle_App("Notion", "C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe")
}
else if(MasterScriptCommands = "evernote"){ ;~ Toggle Evernote App
	gui_destroy()
	Toggle_App("Evernote", "D:\Program Files (x86)\Evernote\Evernote\Evernote.exe")
}
else if(MasterScriptCommands = "166"){ ;~ Open JXL Project 166
	gui_destroy()
	Run, "notion://https://www.notion.so/JXL-166-Production-Overview-5b77a260fc424c7c906eeb6404b4a387"
	/*
		If WinExist("ahk_exe Notion.exe"){
			SetKeyDelay, 0.75
			Toggle_App(Notion, "C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe")
			WinWaitActive, ahk_exe Notion.exe
			SendInput, ^p
			Sleep, 25
			SendRaw, JXL 1-66
			Sleep, 25
			SendInput, {Enter}
			Return
	*/
}
else if(MasterScriptCommands = "compress"){ ;~ Run Compress ImagMagick Script
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Magick\Compress Image.ahk"
}
else if(MasterScriptCommands = "action"){ ;~ Action Zone
	gui_destroy()
	Toggle_App("Action Zone", "C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe")
}
else if(MasterScriptCommands = "task"){ ;~ AHK Task Manager
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Task Manager\TaskManager.ahk"
	;~ Toggle_App("Task Manager", "C:\AHK Scripts\Tools\Task Manager\TaskManager.ahk")
}
else if(MasterScriptCommands = "reset audio" || MasterScriptCommands = "reset sound"){ ;~ Enable/Disable Default Audio Device
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Toggle Default Audio Device.ahk"
}
else if(MasterScriptCommands = "messenger"){ ;~ Run Faceboook Messenger
	gui_destroy()
	Run, "C:\Program Files\WindowsApps\FACEBOOK.317180B0BB486_720.6.119.0_x64__8xx8rvfyw5nnt\app\Messenger.exe"
}
else if(MasterScriptCommands = "loud"){ ;~ Loudness Meter Website
	gui_destroy()	
	Run, "https://www.loudnesspenalty.com/"
	Run, "https://youlean.co/file-loudness-meter/"
}
else if(MasterScriptCommands = "volume"){ ;~ Volume Defaults for Applications
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Volume Per Application.ahk"
}
else if(MasterScriptCommands = "to ico"|| MasterScriptCommands = ".ico"){ ;~ Convert Image on Clipboard to Ico
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Magick\Convert to ICO.ahk"
}
else if(MasterScriptCommands = "kill vep"){ ;~ Kill Vepro
	gui_destroy()
	Notify().AddWindow("Force Quitting VEPRO", {Title:"Kill VEPRO", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Vienna Ensemble Pro.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:32, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x0B86C5", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
	Process, Close, Vienna Ensemble Pro.exe
}
else if(MasterScriptCommands = "kill dorico"){ ;~ Kill Dorico
	gui_destroy()
	Notify().AddWindow("Force Quitting Dorico", {Title:"Kill Dorico", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Process, Close, Dorico3.5.exe
	Process, Close, VSTAudioEngine3.exe
}
else if(MasterScriptCommands = "rec"){ ;~ Record Screen
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AHK Screen Recording\Screen Recording.ahk"
}
else if(MasterScriptCommands = "cfu"){ ;~ Check for Updates
	gui_destroy()
	Run, ms-settings:windowsupdate-action
}
else if(MasterScriptCommands = "disk"){ ;~ Run Disk Management
	gui_destroy()
	Run, diskmgmt.msc
}
else if(MasterScriptCommands = "device"){ ;~ Run Device Management
	gui_destroy()	
	Run, *RunAs devmgmt.msc,,,DM
	WinWaitActive, ahk_pid %DM%
	WinMove,ahk_pid %DM%,,,, 1200, 900
}
else if(MasterScriptCommands = "kill xbox"){ ;~ Kill Xbox Chat/Live
	gui_destroy()
	Process, Close, XboxApp.exe
	Process, Close, GameBar.exe
	Process, Close, GameBarFTServer.exe
	Process, Close, XboxAppServices.exe
}
else if(MasterScriptCommands = "xbox on"){ ;~ Restore Xbox Chat/Live
	gui_destroy()
	RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR, AppCaptureEnabled, 1
}
else if(MasterScriptCommands = "xbox off"){ ;~ Turn Off Xbox Chat/Live
	gui_destroy()
	RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR, AppCaptureEnabled, 0
}
else if(MasterScriptCommands = "amd" || MasterScriptCommands = "ryzen"){ ;~ Find Ryzen
	gui_destroy()
	Run, "https://www.newegg.com/amd-ryzen-9-5900x/p/N82E16819113664"
	Run, "https://www.bhphotovideo.com/c/product/1598373-REG/amd_100_100000061wof_ryzen_9_5900x_3_7.html"
	Run, "https://www.bestbuy.com/site/amd-ryzen-9-5900x-4th-gen-12-core-24-threads-unlocked-desktop-processor-without-cooler/6438942.p?skuId=6438942"
	Run, "https://www.microcenter.com/product/630283/amd-ryzen-9-5900x-vermeer-37ghz-12-core-am4-boxed-processor"
	Run, "https://www.amazon.com/Ryzen-5900X-12-Core-Desktop-Processor/dp/B08NXYLBN5"
	Run, "https://www.amd.com/en/where-to-buy/ryzen-5000-series-processors"
	Run, "https://www.walmart.com/ip/AMD-Ryzen-9-5900X-12-core-24-thread-Desktop-Processor/647899167?irgwc=1&sourceid=imp_V-k1NFz4UxyLRBgwUx0Mo388UkERS3R5wWfWUQ0&veh=aff&wmlspartner=imp_62662&clickid=V-k1NFz4UxyLRBgwUx0Mo388UkERS3R5wWfWUQ0&sharedid=&affiliates_ad_id=612734&campaign_id=9383"
}
else if(MasterScriptCommands = "cmd"){ ;~ Command Prompt
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\cmd.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
	Run %comspec% /k
}
else if(MasterScriptCommands = "facebook audio"){ ;~ Open Facebook Audio to Download MP3
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Facebook, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "https://m.facebook.com/messages/?entrypoint=jewel&no_hist=1 "
}
else if(MasterScriptCommands = "mute"){ ;~ Mute System via RME
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\TotalMixFX.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x6F6E6E", Color:"0xFFFFFF", TitleColor:"0xFF0000"})
	vWindow := "ahk_exe TotalMixFX.exe"
	DetectHiddenWindows, On
	if !WinExist(vWindow){
		m("Window doesn't exist")
	}
	WinGet, vState, MinMax, % vWindow
	If (vState <= 0){
		WinActivate, % Window
		WinRestore, % vWindow
	}
	WinActivate(vWindow)
	Perform_Action({Type:"Mouse",Action:"Left",Actual:0,ClickCount:1,RestorePOS:0,Wait:2,WindowWait:2,Comment:"Mouse Click",Match:1,OffsetX:-119,OffsetY:43,Area:"RME TotalMix FX: Babyface Pro ahk_exe TotalMixFX.exe",Bits:"zzzzzzzzzzzzzzzzzzzzzSrzrhzyvTyyrzjhzsPTxyrzzhzzzzzzzzzzzzzzzzzzzzy",Ones:374,Zeros:26,Threshold:129,W:20,H:20})	
	If (vState = -1)
		WinMinimize, % vWindow
	DetectHiddenWindows, Off
}
else if(MasterScriptCommands = "TotalMix"){ ;~ Open Total Mix RME App
	gui_destroy()
	Run, "C:\Windows\System32\TotalMixFX.exe"
}
else if(MasterScriptCommands = "dorico"){ ;~ Open Dorico Composition Folder
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Dorico, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "F:\Dorico"
}
else if(MasterScriptCommands = "hk signal"){ ;~ Hotkeys for Signal
	gui_destroy()
	Run, "https://support.signal.org/hc/en-us/articles/360036517511-Signal-Desktop-Keyboard-Shortcuts"
}
else if(MasterScriptCommands = "backup"){ ;~ Backup
	gui_destroy()
	Run, "C:\Program Files\DirSyncPro\DirSyncPro.exe" /sync "C:\Program Files\DirSyncPro\Backup of Jedi Archives Config.dsc"
}
else if(MasterScriptCommands = "bravura"){ ;~ Bravura Text Help Doc
	gui_destroy()
	Run, "https://w3c.github.io/smufl/latest/index.html"
}
else if(MasterScriptCommands = "shuffle"){ ;~ Newegg Shuffle
	gui_destroy()
	Run, "https://www.newegg.com/product-shuffle"
}
else if(MasterScriptCommands = "notify help"){ ;~ List of Notify Options
	gui_destroy()
	x = Usage:`rNotify:=Notify()`rWindow:=Notify.AddWindow("Your Text Here",{Icon:4,Background:"0xAA00AA"})`r|---Window ID|--------Options`rOptions:`rWindow ID will be used when making calls to Notify.SetProgress(Window,ProgressValue)`rAnimate: Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)`rBackground: Color value in quotes eg. {Background:"0xAA00AA"}`rButtons: Comma Delimited list of names for buttons eg. {Buttons:"One,Two,Three"}`rColor: Font color eg.{Color:"0xAAAAAA"}`rFlash: Flashes the background of the notification every X ms eg. {Flash:1000}`rFlashColor: Sets the second color that your notification will change to when flashing eg. {FlashColor:"0xFF00FF"}`rFont: Face of the message font eg. {Font:"Consolas"}`rIcon: Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}`rIconSize: Width and Height of the Icon eg. {IconSize:20}`rHide: Comma Separated List of Directions to Hide the Notification eg. {Hide:"Left,Top"}`rProgress: Adds a progress bar eg. {Progress:10} Starts with the progress set to 10`rRadius: Size of the border radius eg. {Radius:10}`rSize: Size of the message text eg {Size:20}`rShowDelay: Time in MS of how long it takes to show the notification`rSound: Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}`rTime: Sets the amount of time that the notification will be visible eg. {Time:2000}`rTitle: Sets the title of the notification eg. {Title:"This is my title"}`rTitleColor: Title font color eg. {TitleColor:"0xAAAAAA"}`rTitleFont: Face of the title font eg. {TitleFont:"Consolas"}`rTitleSize: Size of the title text eg. {TitleSize:12}
	m(x)
}
else if(MasterScriptCommands = "skype"){ ;~ Run Skype
	gui_destroy()
	Notify().AddWindow("Running Skype", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\Microsoft\Skype for Desktop\Skype.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x00A0E1", Color:"0xFFFFFF", TitleColor:"0xFFFFFF;"})
	RegRead, vRun, HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Skype for Desktop
	Run, % vRun
}
else if(MasterScriptCommands = "website stuff"){ ;~ open folder to webstie stuff
	gui_destroy()
	Run, "D:\Users\Dillon\Desktop\Desktop Items\website stuff"
}
else if(MasterScriptCommands = "photoshop"){ ;~ Adobe Photoshop
	gui_destroy()
	Run, "C:\Program Files\Adobe\Photoshop\Photoshop.exe"
	Notify().AddWindow("Running Adobe Photoshop", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Adobe\Photoshop\Photoshop.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Photoshop:= "Adobe Creative Cloud ahk_exe Adobe Desktop Service.exe"
	WinWaitActive, %Photoshop%
	WinActivate, %Photoshop%
	ControlClick,Quit,%Photoshop%,,L,2
}
else if(MasterScriptCommands = "premiere"){ ;~ Adobe Premiere
	gui_destroy()
	Run, "C:\Program Files\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe"
	Notify().AddWindow("Adobe Premiere", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "chrome"){ ;~ Run Chrome
	gui_destroy()
	Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
}
else if(MasterScriptCommands = "disable internet"){ ;~ Disable LAN Connection
	gui_destroy()
	Run *RunAs %comspec% /c netsh interface set interface name="Ethernet" admin=DISABLED
}
else if(MasterScriptCommands = "enable internet"){ ;~ Enable LAN Connection
	gui_destroy()
	Run *RunAs %comspec% /c netsh interface set interface name="Ethernet" admin=ENABLE
}
else if(MasterScriptCommands = "vep"){ ;~ Run VEPRO 7
	gui_destroy()
	Run, "C:\Program Files\Vienna Ensemble Pro\Vienna Ensemble Pro.exe" -server
	Notify().AddWindow("Running VEPRO 7",{Animate:"Center",ShowDelay:100,Icon:236,IconSize:50,Title:"",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
}
else if(MasterScriptCommands = "winsquare" || MasterScriptCommands = "window square"){ ;~ Make Active Window into Square Format for Recording
	gui_destroy()
	WinGetActiveTitle,A
	Sleep, 50
	WinMove, %A%,,,,1080,1080
}
else if(MasterScriptCommands = "win9:16" || MasterScriptCommands = "winvertical"){ ;~ Make Active Window into Square Format for Recording
	gui_destroy()
	WinGetActiveTitle,A
	Sleep, 50
	WinMove, %A%,,,,1080,1920
}
else if(MasterScriptCommands = "shell icons"){ ;~ Shell Icon List
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Shell Icon List.ahk"
}
else if(MasterScriptCommands = "how to Dorico"){ ;~ Dorico HOW TO in Notion
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Dorico How To's.url"
}
else if(MasterScriptCommands = "nyu"){ ;~ NY Unemployment Questions
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\NY Unemployment Questions.url"
}
else if(MasterScriptCommands = "disaster"){ ;~ Disaster Grant
	gui_destroy()
	Run, "https://covid19relief1.sba.gov/Account/Login?Ticket=d746563b2dc94ecf81d1eee115fbfdff"
}
else if(MasterScriptCommands = "accv"){ ;~ Acc Viewer
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\ACC_Viewer\AccViewer_JG.ahk"
}
else if(MasterScriptCommands = "Atlantis"){ ;~ Notion Atlantis Overview
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Atlantis.url"
}
else if(MasterScriptCommands = "Window Pos" || MasterScriptCommands = "Win Pos"){ ;~ Get Window Position
	gui_destroy()
	WinGetActiveTitle,T
	WinGetPos,x,y,w,h,A
	WinPos:="x"x A_Tab "y"y "`n" "w"w A_Tab "h"h
	Clipboard:= "x"x " " "y"y
	Notify().AddWindow(WinPos, {Title:T, Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "wininfo" || MasterScriptCommands = "wintitle"){ ;~ Get Window Info of Current Window
	gui_destroy()
	Sleep, 50 ;~ Needed for window to bounce back to original after opening MSC
	actWin:= WinExist("A")
	WinGetTitle, t1,
	WinGetClass, t2
	WinGet, t3, ProcessName
	WinGet, t4, PID
	WinGetActiveTitle, A
	WinGet, vExe, ProcessName, A
	WinGet, vID, ID, A
	WinGetClass, vClass, A
	vWindowInfo := A "`n" . "ahk_class " vClass "`n" . "ahk_exe " vExe "`n" . "ahk_id " vID
	Notify().AddWindow(vWindowInfo,{Title:"Active Window Information",Font:"Sans Serif",TitleFont:"Sans Serif",Icon:"D:\Folder Icons\Games\Super Mario\ICO\Retro Block - Question (2).ico,1",Animate:"Right,Slide",ShowDelay:100,IconSize:64,TitleSize:14,Size:20,Radius:26,Buttons: "Title,Class,Process,PID,Close",Background:"0xFFFFFF",Color:"0x282A2E",TitleColor:"0xFF0000"})
	Click(Obj){
		global t1, t2, t3, t4
		if(Obj.Button = "Title"){
			Clipboard:= % t1
		}
		if(Obj.Button = "Class"){
			Clipboard:= % "ahk_class " t2
		}
		if(Obj.Button = "Process"){
			Clipboard:= % "ahk_exe " t3
		}
		if(Obj.Button = "PID"){
			Clipboard:= % "ahk_pid " t4
		}
		if(Obj.Button = "Close"){
			Gui,% Obj.Win ":Destroy"
		}
	}
	/*
		WinGetActiveTitle, A
		WinGet, vExe, ProcessName, A
		WinGet, vID, ID, A
		WinGetClass, vClass, A
		vWindowInfo := A "`n" . "ahk_class " vClass "`n" . "ahk_exe " vExe "`n" . "ahk_id " vID
		Notify().AddWindow(vWindowInfo,{Title:"Active Window Information",Font:"Sans Serif",TitleFont:"Sans Serif",Icon:"D:\Folder Icons\Games\Super Mario\ICO\Retro Block - Question (2).ico,1",Animate:"Right,Slide",ShowDelay:100,IconSize:64,TitleSize:14,Size:20,Radius:26,Time:2500,Background:"0xFFFFFF",Color:"0x282A2E",TitleColor:"0xFF0000"})
		Run, "C:\AHK Scripts\Tools\Process Name of Active Window.ahk"
	*/
}
else if(MasterScriptCommands = "remove line breaks" || MasterScriptCommands = "remove returns"){ ;~ Remove Line Breaks/Returns from Clipboard
	gui_destroy()
	StringReplace, Clipboard, Clipboard,  `r`n,%A_Space%, All 
	ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice.
	; ... here make temporary use of the clipboard, such as for pasting Unicode text via Transform Unicode ...
	Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
	Clipboard := RegExReplace(Clipboard,"\. +",".`n")
	Notify().AddWindow(Clipboard, {Title:"Clipboard has been changed", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "remove extra spaces"){ ;~ Remove Double or More Spaces from String on Clipboard
	gui_destroy()
	Clipboard:=RemoveExtraSpaces(Clipboard)
	Notify().AddWindow("On the Clipboard!", {Title:"Removed Extra Spaces from Clipboard", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
}
else if(MasterScriptCommands = "snip" || MasterScriptCommands = "windows snip"){ ;~ Run Joe's Window Snip Program
	gui_destroy()
	DMD_RunShortcut("C:\AHK Scripts\Tools\Window Snipping\WindowSnipping.ahk")
}
else if(MasterScriptCommands = "teamv"){ ;~ Run TeamViewer
	gui_destroy()
	Run, "C:\Program Files (x86)\TeamViewer\TeamViewer.exe"
}
else if(MasterScriptCommands = "kill teamv"){ ;~ Kill TeamViewer
	gui_destroy()
	Process, Close, TeamViewer.exe
}
else if(MasterScriptCommands = "msi util"){ ;~ Run MSI Utility for better GPU/CPU Performance
	gui_destroy()
	;~ DMD_RunShortcut("C:\Program Files\MSI Utility\3 MSI Mode Tool.exe")
	Run, "C:\Program Files\MSI Utility\3 MSI Mode Tool.exe"
}
else if(MasterScriptCommands = "home"){ ;~ Notion Home
	gui_destroy()
	MouseGetPos,xx,yy
	WinActivate, Home ahk_exe notion.exe
	WinGetActiveStats, Title, Width, Height, X, Y	
	MouseMove, Width / 2, Height / 2, 0
	SetMouseDelay, 50
	;~ Send, {WheelUp 10}
	;~ Sleep, % SN
	Send, {WheelDown 4}
	MouseMove, % xx, % yy
}
else if(MasterScriptCommands = "kill ahk"){ ;~ Kill ALL AHK Scripts besides MSC
	gui_destroy()
	;~ Run,%ComSpec% /c Taskkill -f -im autohotkey.exe,%A_ScriptDir%,
	ExitAll() ;   Exits all AHK apps except the calling script.	
	ExitAll() { ;~ by SKAN : www.autohotkey.com/forum/viewtopic.php?p=309841#309841
		DetectHiddenWindows, % ( ( DHW:=A_DetectHiddenWindows ) + 0 ) . "On"		
		WinGet, L, List, ahk_class AutoHotkey		
		Loop %L%			
			If ( L%A_Index% <> WinExist( A_ScriptFullPath " ahk_class AutoHotkey" ) )			
				PostMessage, 0x111, 65405, 0,, % "ahk_id " L%A_Index%		
		DetectHiddenWindows, %DHW%		
	}
}
else if(MasterScriptCommands = "purge kontakt"){ ;~ Purge Kontakt
	gui_destroy()
	SN:= 50 ;~ Sleep Number
	VEP:= "ahk_class SteinbergWindowClass" ;~ VEPRO Window Title	
	Sleep 500	
	Notify().AddWindow("Purge Kontakt", {Title:VEP, Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:Location, Animate:"Right, Slide", ShowDelay:100, IconSize:48, TitleSize:14, Size:20, Radius:26, Time:3000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Perform_Action({Type:"Mouse", Action:"Left", Actual:1, ClickCount:1, RestorePOS:"", Wait:2, WindowWait:2, Comment:"Mouse Click", Match:1, OffsetX:-15, OffsetY:10, Area:"ahk_exe Cubase11.exe", Bits:"zzzzzzzzlzzwTzk0Tw07z01zlwTkT1w7kT1w7wT7z01zk0Tw07zwTzz7zzzzzzzzzzy", Ones:280, Zeros:120, Threshold:132, W:20, H:20})	
	MouseGetPos,x,y
	Sleep, % SN
	MouseClick,L, % x, % y+293
	MouseGetPos,x,y
	Sleep, % SN
	MouseClick,L, % x-50, % y+50	
	WinActivate,%Title%
	MouseMove, % xx, % yy	
}
else if(MasterScriptCommands = "purge vepro"){ ;~ Purge Kontakt in VEPRO
	gui_destroy()
	Run, "C:\AHK Scripts\Kontakt Purge All v1.00 DMD.ahk"
}
else if(MasterScriptCommands = "shorcut notion"){ ;~ Convert Notion Link into Shorcut Link
	gui_destroy()
	CLipboard:= StrReplace(Clipboard, "https","notion",1)
	Notify().AddWindow(Clipboard, {Title:"Notion GLobal Link", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x1B1B1B", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
}
else if(MasterScriptCommands = "global link"){ ;~ Convert Link into Global Link for Notion
	gui_destroy()
	SplitPath,Clipboard,x,y
	x:=SubStr(StrSplit(x,"#").2,1)
	Clipboard:=y "/" x
	Notify().AddWindow(Clipboard, {Title:"Notion Global Link", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x1B1B1B", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
}
else if(MasterScriptCommands = "reg loc"){ ;~ Run Registry Software Location Software
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\regedit.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Reg Software Locations - Shortcut.lnk"
}
else if(MasterScriptCommands = "sum of clip"){ ;~ Sum of the Clipboard
	gui_destroy()
	StringSplit,Total,Clipboard,`n	
	New := 0.00
	Loop,%Total0%
	{
		New += Total%A_Index%
	}
	Clipboard:=Format("{:0.2f}", New)
	Notify().AddWindow(Clipboard, {Title:"Sum of Numbers", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "Studio"){ ;~ Run AHK Studio as ADMIN
	gui_destroy()
	DMD_RunShortcut("C:\AHK Studio\AHK-Studio.ahk")
}
else if(MasterScriptCommands = "n. color" || MasterScriptCommands = "color notion"){ ;~ Notion Color Selector GUI
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Notion Color Selector - Shortcut.lnk"
}
else if(MasterScriptCommands = "Cubase template"){ ;~ Load Cubase Template Dir
	gui_destroy()
	Run "F:\Cubase\Templates\2021 Master Template"
}
else if(MasterScriptCommands = "latencymon"){ ;~ Run/Start LatencyMon for Audio Problem Identifier
	gui_destroy()
	Run, "C:\Program Files\LatencyMon\LatMon.exe"
	/*
		Window:="ahk_exe LatMon.exe"
		SetKeyDelay, 300
		SN:= 500
		WinActivate, % Window	
		WinWaitActive, % Window
		Coord:="4.1"
		XY:=Acc_Get("Location", Coord, 0, Window)
		Action:="x"SubStr(StrSplit(XY," ").1,2)+10 " y" SubStr(StrSplit(XY," ").2,2)+10
		ControlClick, % Action, % Window,,Left,,NA
	*/
}
else if(MasterScriptCommands = "Remove Notify Breaks"){ ;~ Remove Notify Line Breaks
	gui_destroy()
	Row:= Clipboard
	;~ Part 1 - Removing Comments
	Row:= RegExReplace(Row, "m`a)(\R)?^\s*;.*(?(1)|\R)") ;~ Sort of worked
	C1:=" `;~ Remove " Chr(34) Chr(34) " if want to use a variable, NO percents!"
	C2 =
(
;~  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
)
	C3 =
(
;~ Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
)
	StringReplace,Row,Row,% C1,,All
	StringReplace,Row,Row,% C2,,All
	StringReplace,Row,Row,% C3,,All
	;~ Part 2 -Removing Line Breaks
	StringReplace Row, Row, %A_Space% `r`n, %A_Space%, All
	StringReplace Row, Row, `r`n, %A_Space%, All
	StringReplace, Row, Row, `n`t,, All
	StringReplace, Row, Row, `,,`,%A_Space%, All
	;~ Part 4 - Remove Tabs
	StringReplace, Row, Row, %A_Tab%, %A_Space%,All
	;~ Part 5 - Remove Double Spaces
	Row:=Trim(RegExReplace(Row, "\h\K\h+"))
	StringReplace, Row, Row, % " ,", `,,All ;~ Removes " ,"
	;~ Part 5 - Execution
	Clipboard:= ""
	ClipWait, 0
	Clipboard:= Row
	Notify().AddWindow("On the Clipboard!", {Title:"Converted Notify Breaks into Single Line"	, Font:"Sans Serif"	, TitleFont:"Sans Serif"	, Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico,  1" 	, Animate:"Right, Slide" 	, ShowDelay:100		, IconSize:64		, TitleSize:14	, Size:20	, Radius:26	, Time:2500	, Background:"0xFFFFFF"	, Color:"0x282A2E"		, TitleColor:"0xFF0000"})	
}
else if(MasterScriptCommands = "process explorer"){ ;~ Run Process Explorer
	gui_destroy()
	Run, "C:\Program Files\ProcessExplorer\procexp64.exe"
	Notify().AddWindow("Running Process Explorer", {Title:"Run Procexp64.exe", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\ProcessExplorer\procexp64.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "signal"){ ;~ Open Signal
	gui_destroy()
	wSignal := "ahk_exe Signal.exe"
	If !WinExist(wSignal){
		Run, "C:\Users\Dillon\AppData\Local\Programs\signal-desktop\Signal.exe"
	}
	Loop {
		WinActivate, % wSignal
		WinGet,winState,MinMax,% wSignal
		Sleep, 10
	}Until winState := 1
	WinWaitActive, % wSignal
	SendInput, #+{Right}
	Notify().AddWindow("Signal is Opened", {Title:"Running Signal", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Users\Dillon\AppData\Local\Programs\signal-desktop\Signal.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "qap"){ ;~ Quick Access Popup
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\QuickAccessPopup-64-bit.exe", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run *RunAs "C:\Users\Dillon\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\QuickAccessPopup.lnk" ;~ /k keep CMD window open after command || /c close CMD windowe after command
}
else if(MasterScriptCommands = "revo"){ ;~ Run Revo Uninstaller
	gui_destroy()
	Run, "C:\Program Files\VS Revo Group\Revo Uninstaller Pro\RevoUninPro.exe"
}
else if(MasterScriptCommands = "am I admin"){ ;~ Is MSC Running as Admin
	gui_destroy()
	if (A_IsAdmin ? m("I'm ADMIN") : m("I'm Not ADMIN"))
		Return
}
else if(MasterScriptCommands = "regedit"){ ;~ Open Windows Registry
	gui_destroy()	
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\regedit.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
	Run, regedit
}
else if(MasterScriptCommands = "services"){ ;~ Services Windows
	gui_destroy()
	Run, services.msc
}
else if(MasterScriptCommands = "install OSC"){ ;~ Install New Version of OSC
	gui_destroy()
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\OSC Install New Version.ahk")
}
else if(MasterScriptCommands = "info bios"){ ;~ Bios Information
	gui_destroy()
	strComputer := "."
	objWMIService := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . strComputer . "\root\cimv2")	
	colSettings := objWMIService.ExecQuery("Select * from Win32_BIOS")._NewEnum	
	While colSettings[objBiosItem]
	{
		m("BIOSVersion : " . objBiosItem.BIOSVersion
  . "`nBuildNumber : " . objBiosItem.BuildNumber
  . "`nCaption : " . objBiosItem.Caption
  . "`nCurrentLanguage : " . objBiosItem.CurrentLanguage
  . "`nDescription : " . objBiosItem.Description
  . "`nInstallableLanguages : " . objBiosItem.InstallableLanguages
  . "`nInstallDate : " . objBiosItem.InstallDate
  . "`nListOfLanguages : " . objBiosItem.ListOfLanguages
  . "`nManufacturer : " . objBiosItem.Manufacturer
  . "`nName : " . objBiosItem.Name
  . "`nPrimaryBIOS : " . objBiosItem.PrimaryBIOS
  . "`nReleaseDate : " . objBiosItem.ReleaseDate
  . "`nSerialNumber2 : " . objBiosItem.SerialNumber
  . "`nSMBIOSBIOSVersion : " . objBiosItem.SMBIOSBIOSVersion
  . "`nSMBIOSMajorVersion : " . objBiosItem.SMBIOSMajorVersion
  . "`nSMBIOSMinorVersion : " . objBiosItem.SMBIOSMinorVersion
  . "`nSMBIOSPresent : " . objBiosItem.SMBIOSPresent
  . "`nSoftwareElementID : " . objBiosItem.SoftwareElementID
  . "`nSoftwareElementState : " . objBiosItem.SoftwareElementState
  . "`nStatus : " . objBiosItem.Status
  . "`nTargetOperatingSystem : " . objBiosItem.TargetOperatingSystem
  . "`nVersion : " . objBiosItem.Version
  . "`nEmbedTest : " . objBiosItem.EmbeddedControllerMajorVersion)
	}
}
else if(MasterScriptCommands = "info computer"){ ;~ Computer Information
	gui_destroy()
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\Info Computer System.ahk")	
}
else if(MasterScriptCommands = "info mb"){ ;~ Motherboard Information
	gui_destroy()
	PropertyList := "Caption,CreationClassName,Depth,Description,Height,HostingBoard,HotSwappable,InstallDate,"
   . "Manufacturer,Model,Name,OtherIdentifyingInfo,PartNumber,PoweredOn,Product,Removable,Replaceable,"
   . "RequirementsDescription,RequiresDaughterBoard,SerialNumber,SKU,SlotLayout,SpecialRequirements,"
   . "Status,Tag,Version,Weight,Width"
	objWMIService := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\" . A_ComputerName . "\root\cimv2")
	WQLQuery = Select * From Win32_BaseBoard
	colMBInfo := objWMIService.ExecQuery(WQLQuery)._NewEnum
	While colMBInfo[objMBInfo]   
		Loop, Parse, PropertyList, `,
			MatherBoardInfo .= A_LoopField . ":`t" . objMBInfo[A_LoopField] . "`n"
	m(MatherBoardInfo)
}
else if(MasterScriptCommands = "info OS"){ ;~ Info on Windows OS
	gui_destroy()
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\Info OS.ahk")
}
else if(MasterScriptCommands = "reminder compression"){ ;~ Remind me of how compression works
	gui_destroy()
	Msgbox
	(
	Compression is one of the most powerful tools at your disposal. It's not only a technical tool, but a creative one that can significantly shape the sound of your mix:
    -fast attack to tame transients
    -slow attack/long release to extend sustain and create a fuller sound
    -impart consistency to an inconsistently performed instrumental part
    -alter timbre and tone
	)
}
else if(MasterScriptCommands = "reminder tax on stock sell"){ ;~ Reminder of How Tax works on Stocks
	gui_destroy()
	Msgbox
	(
	If you buy a stock today for $10, and you sell it tomorrow for $20, then you pay short terms capital gains on the $10 that you earned.
If you buy a stock tomorrow for $15, and you sell it the next day for $30, then you pay taxes on the $15 gain.
That's $25 in short term capital gains that you pay taxes on.
That's the same amount of taxes that you'd pay if you bought $10 in stock today and sold it in 2 days for $35.
Same total dollar amount, same taxes owed- the number of transactions is irrelevant.
Wash Sale:
If you take a loss and then repurchase the stock again in less than 30 days - you have a wash sale and would not be able to deduct the loss. Instead you would adjust the basis of thr newly re-purchased stock.
30 days each way. 30 days prior or 30 days after. So 60-day window.
You need to wait 30 days after a loss sale to repurchase if you don't want to have a wash sale. And it's still a wash if the security is similar. For a stock it would have to be the same company stock but say you were trading an ETF if you sold SPY and bought IVV within 30 days it would also be a wash sale, for example.
	)
}
else if(MasterScriptCommands = "gif signal"){ ;~ Upload Gif to Signal
	gui_destroy()
	vClip 	:= Clipboard
	vWindow 	:= "ahk_exe Signal.exe"
	SplitPath, vClip, vName, vDir, vEXT, vNNE, vDrive
	if (vEXT != "gif" || vEXT = "")									;~ Make sure clipboard is the *.gif otherwise error out
	{
		m("Gif not on Clipboard")
		Return
	}
	WinActivate, % vWindow
	WinWaitActive, % vWindow
	SendInput, ^u
	WinWaitActive, Open
	IfWinActive, Open
		SendInput, ^v
	Loop
		ControlGet, vEditField, Line, 1, Edit1, Open
	Until vEditField = vClip											;~ Loop until editfield = clipboard, to ensure gave enough time for paste of clipbaord
	ControlClick, Button1, Open,, Left,,NA
	WinWaitActive, % vWindow
	Perform_Action({Type:"Mouse",Action:"Left",Actual:0,ClickCount:1,RestorePOS:"",Wait:2,WindowWait:2,Comment:"Mouse Click",Match:1,OffsetX:63,OffsetY:7,Area:"Signal ahk_class Chrome_WidgetWin_1",Bits:"3zw1k3Uk0AM01g00D003UUEMQC673VUUEM006001U00Mk3761Xkzkq1UMk0A70C0zz2",Ones:118,Zeros:282,Threshold:211,W:20,H:20})
	SetWinDelay, 250 												;~ Needed otherwise won't upload gif because windelay is too quick!
	WinActivate, % vWindow
	SendInput, {Enter}
}
else if(MasterScriptCommands = "alt codes"){ ;~ Alt Codes for AHK
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Msgbox 
	(
	Chr(32) = a space
Chr(34) = quotes
Chr(37) = `%
	)
}
else if(MasterScriptCommands = "url" || MasterScriptCommands = "shorten url"){ ;~ Shorten URL
	gui_destroy()
	apiTiny 	:= "https://tinyurl.com/api-create.php?url="    
	url 		:= apiTiny . EncodeDecodeURI(Clipboard)
	Clipboard := HttpQuery(url)
	Notify().AddWindow("Clipboard:= "HttpQuery(url), {Title:MSC_Title(MasterScriptCommands, DIR), Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "doge"){ ;~ Run Dodge Fav Windows/Tabs
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	vFFox := "C:\Program Files\Mozilla Firefox\firefox.exe"
	vRunA := "https://robinhood.com/crypto/1ef78e1b-049b-4f12-90e5-555dcf2fe204/chart"
	vRunB := "https://coinmarketcap.com/"
	vRunC := "https://bitinfocharts.com/dogecoin/address/DCtMAyy9w2QCrWMRdZ28Kn7GwMfCEp2irP"
	vRunD := "https://bitinfocharts.com/dogecoin/address/DRSqEwcnJX3GZWH9Twtwk8D5ewqdJzi13k"
	Run, % vFFox A_Space vRunA A_Space vRunB A_Space vRunC A_Space vRunD
}
else if(MasterScriptCommands = "highlight"){ ;~ Highlight Area of Screen
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Highlight Screen with Rect Box.ahk")
}
else if(MasterScriptCommands = "align"){ ;~ Align Text by Variable
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Align Text by Variable.ahk")
}
else if(MasterScriptCommands = "sort clip"){ ;~ Sort Clipboard Alphabetically
	gui_destroy()
	Sort, Clipboard
	Notify().AddWindow(Clipboard, {Title:"Sorted Clipboard - Just Paste it!", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
}
else if(MasterScriptCommands = "system settings"){ ;~ Advanced System Settings
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\SystemPropertiesAdvanced.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "SystemPropertiesAdvanced"
}
else if(MasterScriptCommands = "signal save conversation"){ ;~ Save Signal Conversation, Run with VLC x2 Speed
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Signal ", 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Signal Save Conversation & Run.ahk")
}
else if(MasterScriptCommands = "swap editor"){ ;~ Swap Default Editor
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Editor Swap\Editor Swap.ahk")
}
else if(MasterScriptCommands = "kill all ahk"){ ;~ Kill every AHK Script
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Sleep, 2500
	DetectHiddenWindows, On 
	WinGet, List, List, ahk_class AutoHotkey	
	Loop % List 
	{ 
		WinGet, PID, PID, % "ahk_id " List%A_Index% 
		If ( PID <> DllCall("GetCurrentProcessId") ) 
			PostMessage,0x111,65405,0,, % "ahk_id " List%A_Index% 
	}
	Sleep, 500
	ExitApp
}
else if(MasterScriptCommands = "icon to dll"){ ;~ Resource Hacker Icon to DLL
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	Run, "C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe"
}
else if(MasterScriptCommands = "Startup"){ ;~ Enable / Disable Startup Programs
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\Tools\Add to Startup\AddToStartUp.ahk")
}
else if(MasterScriptCommands = "dir qap"){ ;~ Open Quick Access Popup Folder
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
	Run, % "C:\Program Files\Quick Access Popup"
}
else if(MasterScriptCommands = "list into obj" || MasterScriptCommands = "list to obj"){ ;~ List to Object
	gui_destroy()
	Clipboard := RegExReplace(Clipboard,"\n","") ;~ Remove any extra line breaks from clipboard
	oArr      := []
	Loop, Parse, % Clipboard, `n`r
	{
		if (A_LoopField = space) ;~ if A_LoopField is blank than loop again
			Continue
		if (A_LoopField ~= "^\d+(\.?)\d+$") ;~ If Line is a digit, number or integer don't wrap in quotes
			oArr.Push(A_LoopField ",")	
		else
			oArr.Push(chr(34) A_LoopField Chr(34) ",") ;~ Wrap every line with quotes
	}
	for key, value in oArr
	{
		vStr .= value ;~ Shove each value into a string
		oObj := "oObj := [" RegExReplace(vStr, ",",,,,-1) "]" ;~ Remove last "," in Obj[]
	}
	Clipboard := oObj
	ClipWait, 1
	if (ErrorLevel)
		Msgbox % "Object Couldn't Copy Into Clipboard"
	Notify().AddWindow(Clipboard, {Title:"Parse List into Object"})
}
else if(MasterScriptCommands = "install OSC"){ ;~ Install New Version of OSC
	gui_destroy()
	Notify().AddWindow(MSC_Title(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:AHK Scripts_Master ScriptResourcesMaster If Commands IconsCogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	DMD_RunShortcut("C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\OSC Install New Version.ahk")
}
Return ;~ End of Commands