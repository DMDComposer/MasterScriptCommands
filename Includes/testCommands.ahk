global vIni_Dir_Path := A_Dropbox "\AHK Scripts\_DMD Scripts\Hotstring Directory Paths\Directory Paths.ini"
	 , oDir_Paths    := DMD_Ini2Obj(vIni_Dir_Path)
	 , oDirs         := oDir_Paths.Directory_Paths
	 , oIcons        := oDir_Paths.Icon_Paths
	 , A_Variables   := {"A_ProgramFiles64":A_ProgramFiles64
                 		,"A_AppDataLocal":A_AppDataLocal
                 		,"A_AppData":A_AppData
		   	  	 		,"A_Dropbox":A_Dropbox
		   	  	 		,"A_GoogleDrive":A_GoogleDrive
		   	  	 		,"A_ProgramFiles":A_ProgramFiles
		   	  	 		,"A_UserName":A_UserName
		   	  	 		,"A_UserProfile":A_UserProfile
		   	  	 		,"A_WinDir":A_WinDir} 

/* for key,value in A_Variables { ; Creating a unqiue variable for each key in the object
	%key% := oOptions[key]
} 
*/
; #Include <JSON> ; Have to include JSON library for Parsing JSON Objects
DetectHiddenWindows, Off ; Ensure Window is off unless specificed by command. Important for certain AHK scripts for this to be off
; A note on how this works:
; The function name "mscSearchUrls()"
; What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
; Before the command is Run, the word REPLACEME is replaced by your input.
; It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
; So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.	

Switch MasterScriptCommands
{
	Case "aaa": { ; Testing area
		; Notify().AddWindow("You've made it here", {Title:"Congrats!"})
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Title"})
		; t(oDirs.HasKey("drive"))
		; mscSearch()
		; t(MasterScriptCommands)
	}
	; NOTE: VSCode Workspace Launches
	Case "vs msc", "vs master search box": {
		Run, "%A_AppDataLocal%\Programs\Microsoft VS Code\Code.exe" "%A_Dropbox%\AHK Scripts\_DMD Scripts\Master Search Box"
	}
	Case "vs swal": {
		Run, "%A_AppDataLocal%\Programs\Microsoft VS Code\Code.exe" "%A_Dropbox%\AHK Scripts\Lib"
	}
	Case "vs music quick search": {
		Run, "%A_AppDataLocal%\Programs\Microsoft VS Code\Code.exe" "%A_Dropbox%\AHK Scripts\_DMD Scripts\Music Quick Search for DMD\AHK Boostrap Search Engine"
	}
	Case "add icon", "add dir": { ; Add Icon Path to ini File
		
		vType := RegExReplace(MasterScriptCommands, "i)add\s", "")
		Gui +LastFound +OwnDialogs +AlwaysOnTop ; Keep Inputbox Always on Top
		InputBox, vNew_Key, % "New " vType " Name", % "New " vType " Name: ~Add new Key to ini file"
		if ErrorLevel
			Return
		vIni_Section := (vType == "icon" ? "Icon_Paths" : "Directory_Paths")
		vIni_Key     := (vType == "icon" ? "icons." vNew_Key : "dir " vNew_Key)			
		IniRead, vOverwrite, % vIni_Dir_Path, % vIni_Section, % "icons." vNew_Key
		If(vOverwrite != "Error"){
			MsgBox,308,Name Exists,This icon already exists`, would you like to overwrite it?
			IfMsgBox,No
				Return	
		}	
		Gui +LastFound +OwnDialogs +AlwaysOnTop                                          ; Keep Inputbox Always on Top
		InputBox, vNew_Value, % "New Path for " vType,  % "New " vType " Path: ~Add new Value to ini file"
		if ErrorLevel
			Return	
		if (MasterScriptCommands ~= "dir")
		{
			IniWrite, % vNew_Value, % vIni_Dir_Path, Directory_Paths, % "dir " vNew_Key ; Write to Dir Paths		
		}
		if (MasterScriptCommands ~= "icon")
			IniWrite, % vNew_Value, % vIni_Dir_Path, Icon_Paths, % "icons." vNew_Key    ; Write to Icons Paths
		HS_Dir := A_LineFile "\..\..\..\Hotstring Directory Paths\HS_Dir Paths.ahk"                    ; edit with your full script path	
		DetectHiddenWindows, On 
		WinClose, % HS_Dir "ahk_class AutoHotkey"
		Run, % HS_Dir
		DetectHiddenWindows, Off
	}
	Case "ahk ": { ; Search for AHK Related Info
		mscSearch({title:"Autohotkey Google Search",color:"#00FF00",icon:"./Icons/AHK.ico"})
		mscSearchUrls("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l=")
		mscSearchUrls("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk0356faDBEtpcEjEwIwMscFvTxXMmg%3A1590206661049&ei=xaDIXsXJAq6vytMPh5ChgAU&q=site%3Astackoverflow.com+REPLACEME&oq=site%3Astackoverflow.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DwR1iDZGCnZ2gAcAB4AIABhgGIAcQHkgEEMTAuMpgBAKABAqABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwiFwJq5jcnpAhWul3IEHQdICFAQ4dUDCAs&uact=5")
		; mscSearchUrls("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk02CuZqxN5n_fDw_33Asi02z9bthxw%3A1590206200889&ei=-J7IXuruNd6tytMP1b6sgAc&q=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&oq=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&gs_lcp=CgZwc3ktYWIQAzoECAAQR1CViwlYpK8JYJuyCWgIcAF4AIABTYgBiAqSAQIxOZgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwjqyuTdi8npAhXelnIEHVUfC3AQ4dUDCAs&uact=5")
	}
	Case (oDirs.HasKey(MasterScriptCommands) ? MasterScriptCommands : false), (oDirs.HasKey("dir " MasterScriptCommands) ? MasterScriptCommands : false): { ; Add Icon Path to ini File
		for Key,Value in oDirs {
			if (Key ~= "i)^" MasterScriptCommands "|dir\s" MasterScriptCommands) {
				for a, b in A_Variables
					(Value ~= "i)" a ? Value := StrReplace(Value, a, b) : Value := Value)
				DMD_Run(Value)
				vPath := Value
			}
		}
		Loop, Files, % vPath "\*.*", F 
		{
			if (A_LoopFileFullPath ~= "i)desktop.ini"){
				IniRead, vIconResource, % A_LoopFileFullPath, % ".ShellClassInfo", % "IconResource"
				IniRead, vIconFile, % A_LoopFileFullPath, % ".ShellClassInfo", % "IconFile"
				vIniIcon := (vIconResource = "ERROR" ? vIconFile : vIconResource)
				vIcon := vIniIcon != "" ? vIniIcon : "C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1"
				vIcon := A_LoopFileFullPath ~= "i).ico" ? A_LoopFileFullPath : vIcon ; If folder has a *.ico, use that as Icon, otherwise use desktop.ini
			}
		}
		Notify().AddWindow(vPath, {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:vIcon, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case (oIcons.HasKey(MasterScriptCommands) ? MasterScriptCommands : false): { ; Icon Directory
		for Key,Value in oIcons
		{
			if (Key ~= "i)" MasterScriptCommands) 
			{
				for a, b in A_Variables{
					(Value ~= "i)" a ? Value := StrReplace(Value, a, b) : Value := Value)				
					DMD_RestoreClip(Value,250)	
				}
			}
		}
	}
	;------------------------------------------------------------------------------
	Case "album cover", "search album cover": { ; Search Album Covers
		mscSearch({title:"Search for Album Covers"})
		mscSearchUrls("https://www.albumartexchange.com/covers?q=REPLACEME&fltr=ALL&sort=DATE&status=&size=any")
	}
	Case "amazon ": { ; Search Amazon
		mscSearch({title:"Amazon Search",color:"#FF9900"})
		mscSearchUrls_title:= "What would you like to search?"
		mscSearchUrls("https://www.amazon.com/s?k=REPLACEME&ref=nb_sb_noss_2")
	}
	Case "fontawesome": { ; Search FontAwesome & Other Icons
		mscSearch({title:"Search for FontAwesome Icons"})
		mscSearchUrls("https://fontawesome.com/icons?d=gallery&p=2&q=REPLACEME&m=free")	
	}
	Case "g. ", "google": { ; Search Google
		mscSearch({title:"Google Search",subTitle:"Let Me Google That For You...",color:"#4285F4"})
		mscSearchUrls("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
	}
	Case "gifs": { ; Search for Gifs
		mscSearch({title:"Search Giphy for Gifs"})
		mscSearchUrls("https://giphy.com/search/REPLACEME")
	}
	Case "icon search", "search icons": { ; Search for Icons
		mscSearch({title:"Icon Search",color:"#00FF00",icon:Icon_AHK})
		mscSearchUrls(["https://www.deviantart.com/search?q=REPLACEME%20icons"
		           ,"https://iconscout.com/icons/REPLACEME?price=free"
		           ,"https://icon-icons.com/search/icons/?filtro=REPLACEME"
		           ,"https://material.io/resources/icons/?search=REPLACEME&icon=anchor&style=baseline"
		           ,"https://www.flaticon.com/search?word=REPLACEME&search-type=icons&license=selection&order_by=4&grid=small"])
	}
	Case "private ": { ; Private Firefox Window
		mscSearch({title:"Google Search as Private Window in Firefox"})
		mscSearchUrls("C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?safe=off&q=REPLACEME")
	}
	Case "tor. ": { ; Search Torrent Networks
		mscSearch({title:"Search Torrent Networks",color:"#20C6FD", icon:A_GoogleDrive "\Folder Icons\IOS Icons\Clay Icons - By octaviotti\ICO\qBittorrent.ico"})
		Chrome_Desktop := A_ProgramFiles "\Google\Chrome\Application\chrome.exe"
		Chrome_Laptop  := A_ProgramFiles64 "\Google\Chrome\Application\chrome.exe"
		Chrome         := (A_ComputerName != "CHERRYBLOSSOM" ? Chrome_Desktop : Chrome_Laptop)
		mscSearchUrls([Chrome A_Space "https://rutracker.org/forum/tracker.php?nm=REPLACEME"
		           ,Chrome A_Space "https://audioclub.in/?s=REPLACEME"
		           ,Chrome A_Space "https://audioz.download/"
		           ,Chrome A_Space "https://www.1377x.to/search/REPLACEME/1/"
		           ,Chrome A_Space "https://courseboat.com/gsearchv4/?q=REPLACEME"])
		; Notify Variables have to go below the GUI Actions.
		Icon:= "C:\Program Files (x86)\qBittorrent\qbittorrent.exe"
		; Title:= "New Title"
	}
	Case "udemy","Skillshare": { ; Search for Free Udemy Courses
		mscSearch({title:"Udemy/Skillshare Class Search",subTitle:"Type in the Name of the Class",color:"#00FF84"})
		mscSearchUrls(["https://www.google.com/search?sxsrf=ALeKk01lOccrdqCp22gQcH4RUd3zxa3mWw%3A1591452543507&ei=f6PbXr7GHoPj_Aaw_6WgBQ&q=site%3Afreecoursesite.com+puppeteer&oq=site%3Afreecoursesite.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DQH1jQH2DpIWgAcAB4AIAB1gGIAeIFkgEFMC4zLjGYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwj-gaHcru3pAhWDMd8KHbB_CVQQ4dUDCAs&uact=5"
		           ,"https://freecoursesite.us/?s=REPLACEME"
		           ,"https://www.1377x.to/search/REPLACEME/1/"])
	}
	Case "math", "Eval": { ; Perform Math Equation
		
		mscSearch({title:"Math Time!",subTitle:"Perform Math",color:"#00FF84"})
		mscSearchUrls(m("Fix mE"))
	}
	Case "you ", "youtube ", "yt. ": { ; Search Youtube
		mscSearch({title:"YouTube Search",color:"#E62522",icon:Icon_YouTube})
		mscSearchUrls("https://www.youtube.com/results?search_query=REPLACEME&page=&utm_source=opensearch")
	}
	Case "the. ": { ; Search Thesaurus
		mscSearch({title:"Search Thesaurus",color:"#E62522"})
		mscSearchUrls("https://www.thesaurus.com/browse/REPLACEME?s=t")	
	}
	Case "dic. ": { ; Search Dictionary
		mscSearch({title:"Search Dictonary",color:"#E62522"})
		mscSearchUrls("https://www.dictionary.com/browse/REPLACEME?s=t")	
	}
	Case "keys", "hk ahk": { ; List of Key Modifiers AHK Help
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % "https://www.autohotkey.com/docs/KeyList.htm#Keyboard" 
	}
	Case "calendar": { ; Google Calendar
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run https://www.google.com/calendar
	}
	Case "note": { ; Notepad
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\notepad.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run Notepad.exe
		; Run Notepad++.exe
	}
	Case "paint", "mspaint": { ; Run MS Paint
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run "C:\Windows\system32\mspaint.exe"
	}
	Case "steam": { ; Steam
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_Run(A_ProgramFiles "\Steam\steam.exe")
	}
	Case "extract icons": { ; Extract Icons
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_Run("D:\Program Files (x86)\iconsext\iconsext.exe")

	}
	Case "whats": { ; WhatsAPP
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Toggle_App("WhatsApp", "C:\Users\Dillon\AppData\Local\WhatsApp\WhatsApp.exe")
	}
	Case "calc": { ; Calculator
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\calc.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x464646", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
		DetectHiddenWindows, Off ; Have to turn off for Calc to appear
		Toggle_App("Calc", "C:\Windows\System32\calc.exe")
	}
	Case "encrypt": { ; Word Encryption
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, "C:\AHK Scripts\Tools\Encryption Tool\Encryption User Tool.ahk"
	}
	Case "asfyt ost": { ; Atun-Shei Films YouTube OST Link
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, "https://youtu.be/oPVpWYQuQsU"
	}
	Case "spin wheel": { ; Spin Distrokid Wheel
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\icons\Distrokid.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		;C:\Users\DMDCo\Dropbox\AHK Scripts\_DMD Scripts\Distrokid\Daily Spin Wheel\Distrokid Spin Wheel.ahk
		; DMD_RunShortcut("C:\AHK Scripts\_DMD Scripts\Master Search Box\UserCommand Run Scripts\Distrokid Spin Wheel.ahk")
		DMD_RunShortcut(A_LineFile "\..\..\..\Distrokid\Daily Spin Wheel\Distrokid Spin Wheel.ahk")
	}
	Case "distrokid week": { ; Distrokid's Weekly Voting Playlist
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\icons\Distrokid.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut("C:\AHK Scripts\Tools\Chrome\Distrokid Weekly Vote\Distrokid Weekly Vote.ahk")
	}
	Case "rel", "refresh": { ; Reload Script
		; removes the GUI even when the reload fails
		SendInput, {F21} ; Reload Script(s) Button	
		DMD_ReloadScript("HS_Dir Paths")
		Reload
	}
	Case "force rel": { ; Force Reload of MSC SCript
		
		Gosub, RunReload
	}
	Case "_", "master": { ; Reload Master Script
		 ; removes the GUI even when the reload fails
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\_Master Script\_Master Script.ahk") 	
	}
	Case "hosts": { ; Edit Hosts File
		
		Run "C:\Program Files\Notepad++\notepad++.exe" "C:\Windows\System32\drivers\etc\hosts"	
	}
	Case "date": { ; Date
		
		FormatTime, date,, LongDate
		MsgBox %date%
		date =	
	}
	Case "week": { ; Which week is it?
		
		FormatTime, weeknumber,, YWeek
		StringTrimLeft, weeknumbertrimmed, weeknumber, 4
		if (weeknumbertrimmed = 53)
			weeknumbertrimmed := 1
		MsgBox It is currently week %weeknumbertrimmed%
		weeknumber =
		weeknumbertrimmed =
	}
	Case "?": { ; Tooltip of List of Commands Available
		
		m(st_columnize(Sifted_Text, "csv", 2,,A_Tab))
	}
	Case "window position": { ; Get Active Window Positon
		
		WinGetActiveTitle, WinTitle
		WinGetPos, X, Y,,, A
		MsgBox, %WinTitle% is at %X%`,%Y%
	}
	Case "spy": { ; AHK Spy
		
		/*
			DMD_MoveWindow("C:\AHK Scripts\Tools\AU3_Spy.exe",{Position:"TR",Size:3})
			DMD_MoveWindow("C:\AHK Scripts\Tools\WinSpy\WinSpy.ahk",{Position:"BR",Size:4})
		*/
		Run, "C:\AHK Scripts\Tools\AU3_Spy.exe",,,001
		WinWaitActive, ahk_pid %001%
		WinMove,ahk_pid %001%,,1571,0
		Sleep, 100
		Run, "C:\AHK Scripts\Tools\WinSpy\WinSpy.ahk",,,002
		WinWaitActive, ahk_pid %002%
		WinMove,ahk_pid %002%,1516,548
	}
	Case "edge": { ; Edge
		
		Run, microsoft-edge:http://www.google.com/
	}
	Case "ie": { ; Internet Explorer
		
		Run, iexplore
	}
	Case "cap", "title": { ; Check Title Capilzation
		
		DMD_RunShortcut("C:\AHK Scripts\API Calls\Captilize My Title\Captilize My Title API.ahk")
	}
	Case "magick": { ; Magick
		
		; Run, "C:\AHK Scripts\Tools\Magick"
		; Run *Runas "C:\AHK Scripts\Tools\Magick\Base64 Images.ahk"
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\Audio Image Video\ImageMagick\Base64 Images.ahk")
	}
	Case "script icons": { ; Master Script Icon List
		
		Run, % A_ProgramFiles64 "\Notepad++\notepad++.exe" A_Space chr(34) A_Dropbox "\AHK Scripts\_DMD Scripts\_Master Script\Resources\Icons.ini" chr(34)
	}
	Case "scripts": { ; Open Script Directory
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_Run(A_Dropbox "\AHK Scripts")
	}
	Case "itunes": { ; Itunes
		
		Run, % A_ProgramFiles64 "\iTunes\iTunes.exe"
		Command_Gui({Icon:"Itunes",Background:"#FFFFFF",Title:"iTunes",Color:"#000000"}) ; Title | Icon | Background | Color | SleepTimer | Gradient |
	}
	Case "amt": { ; Automate My Task
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\Tools\Automate My Task\Automate_my_Task.ahk")
	}
	Case "winamp": { ; Winamp
		
		Run, % A_ProgramFiles "\Winamp\winamp.exe"	
	}
	Case "click spam", "spam click", "mouse click", "spam mouse": { ; Spam Left Click
		
		Run, % A_Dropbox "\AHK Scripts\Tools\Left Click Spam.ahk"
	}
	Case "piano": { ; Open Kontakt with Sketch Piano
		
		Notify().AddWindow("Piano", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Kontakt, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x000000", Color:"0xDF782F", TitleColor:"0xFFFFFF"})
		DriveGet, Drive_List, List
		Loop, Parse, Drive_List 
		{
			if (A_LoopField ~= "i)I")
				Run, "I:\Kontakt Channel Sets\Pianos\Sketch Piano_Walker 1955 Concert D - Binaural 1.1.nki"
		}	
	}
	Case "sketch": { ; Open Kontakt with Sketch Piano
		
		Notify().AddWindow("Piano", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Kontakt, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x000000", Color:"0xDF782F", TitleColor:"0xFFFFFF"})
		; Run, "C:\Users\Dillon\AppData\Local\Native Instruments\Kontakt\default\Sketching Template.nkm"
		Run, % A_AppDataLocal "\Native Instruments\Kontakt\default\Sketching Template.nkm"
	}
	Case "cubase convert": { ; Convert Audio or Video files
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		global Width,Height,FFMpeg,FFMpegFolder
		FFMpeg       := A_ProgramFiles "\FFmpeg\bin\ffmpeg.exe"
		FFMpegFolder := A_ProgramFiles "\FFmpeg\bin\"
		b            := Clipboard	
		; SB_SetText("Ready")
		SplitPath,b,FileName,Dir,Ext,NNE
		; m(b)
		; m(FileName)
		; SB_SetText("Converting: " FileName)
		if(Ext="wav"){
			FileName := Dir "\" NNE ".mp3"		
			RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
		}else if(Ext~="i)\b(mov|mp4)\b"){
			FileName := Dir "\" NNE """-converted"".mp4"		
			Run,"%FFMpeg%" -i "%b%" -s 640x480 "%FileName%",, ; Converting to low quality for use in Cubase etc.
		}
	}
	Case "convert": { ; Convert to Mp4
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		global Width,Height,FFMpeg,FFMpegFolder
		FFMpeg       := A_ProgramFiles "\FFmpeg\bin\ffmpeg.exe"
		FFMpegFolder := A_ProgramFiles "\FFmpeg\bin\"
		b            := Clipboard	
		; SB_SetText("Ready")
		SplitPath,b,FileName,Dir,Ext,NNE
		; m(b)
		; m(FileName)
		; SB_SetText("Converting: " FileName)
		if(Ext="wav"){
			FileName := Dir "\" NNE ".mp3"		
			RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
		}
		else if(Ext~="i)\b(mkv)\b"){
			FileName := Dir "\" NNE """.mp4"		
			Run,"%FFMpeg%" -i "%b%" -codec copy "%FileName%",,
		; cmd       := "ffmpeg -i input.mkv -codec copy output.mp4"
		}	
	}
	Case "Sound": { ; Open Sound Control Panel
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"c:\windows\system32\control.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_WinDir "\system32\rundll32.exe" " Shell32.dll,Control_RunDLL mmsys.cpl",,, PID
		vWindow := "ahk_pid " PID
		while(!WinActive(vWindow))
			WinActivate, % vWindow
		if WinActive(vWindow)
			MoveWindowtoCenter()
	}
	Case "mixer": { ; Open Volume Mixer
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_LineFile "\..\..\..\Master Search Box\UserCommand Run Scripts\Mixer.ahk")
	}
	Case "empty": { ; Empty RecycleBin
		
		Notify().AddWindow("Empty RecycleBin", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"D:\Folder Icons\WIndows 10 Icons\imageres_54.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x0489D8", TitleColor:"0x0489D8"})
		; A_WinDir "\System32\\imageres.dll,50"
		FileRecycleEmpty
	}
	Case "twitch": { ; Mute/Unmute Twitch Stream
		
		Focus_Send({Window:"Twitch Stream - VLC media player ahk_class Qt5QWindowIcon",Title:"Mute/Unmute Twitch Stream",Keys:"m",Focus:"1",Icon:"Twitch",Background:"#5A3E85"}) ; Focus_Send({}) ; Window | Title | Keys | Background | Color | TitleMatchMode | Focus | Icon | Gradient
	}
	Case "y2mp3": { ; Youtube to Mp3
		
		ydl   := Chr(34) "" A_Dropbox "\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe""" Chr(32)
		cmd   := "--extract-audio --audio-format mp3"Chr(32)
		vid   := Chr(34) Clipboard Chr(34) Chr(32)
		dir   := "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
		y2mp3 := ydl . cmd . vid . dir	
		Run, %y2mp3%,,,PID	
		Notify().AddWindow(y2mp3,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP3",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
		Run % SplitPath(A_Desktop).dir "\Downloads\Youtube Downloader"	
	}
	Case "y2mp4": { ; Youtube to Mp4
		
		ydl   := Chr(34) "" A_Dropbox "\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe""" Chr(32)
		vid   := Chr(34) Clipboard Chr(34) Chr(32)
		dir   := "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
		y2mp3 := ydl vid dir	
		Run, %y2mp3%,,,PID	
		Notify().AddWindow(y2mp4,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP4",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
		Run, "D:\Users\Dillon\Downloads\Youtube Downloader"
	}
	Case "pastebin", "share code": { ; Share AHK Code
		
		Clipboard:=AHKPastebin(Clipboard,"Dillon",1,1) ; 1 will run it in your default browser, 0 doesn't
	}
	Case "ip. ", "myip": { ; Grab my ip
		
		var:= ClipBoard
		Clipboard:="Public ip is: " GetIP("http://www.netikus.net/show_ip.html") "`n`nPrivate IP is:" A_IPAddress1
		Notify().AddWindow(Clipboard, {Title:"IP Addresses"})
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
	Case "mymac": { ; My Mac Address
			
		mymac:=GetMacAddress()
		ClipBoard:=mymac
		GetMacAddress(){
			Runwait, %ComSpec% /c getmac /NH | clip,,hide
			RegExMatch(clipboard, ".*?([0-9A-Z].{16})(?!\w\\Device)", mac)
			Return %mac1%
		}
		Notify().AddWindow(mymac, {Title:"Troublemaker MAC: Address", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "port": { ; Change Port for qBittorent
		
		Random,port,40000,70000
		Toggle_App(qBittorent, "C:\Program Files (x86)\qBittorrent\qbittorrent.exe")
		while(!WinActive("qBittorrent")){
			WinActivate, "qBittorrent"
			Sleep, 100
		}	
		SendInput, !o
		while(!WinActive("Options ahk_exe qbittorrent.exe")){
			WinActivate, "Options ahk_exe qbittorrent.exe"
			Sleep, 100
		}
		SendInput, +Tab {Down 2}{Sleep 10}{Tab}
		Send, % port
		SendInput, {+Tab 4}{Return}
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
	Case "test": { ; Open Code Quick Tester
		
		Run, % A_Dropbox "\AHK Scripts\Tools\CodeQuickTester\CodeQuickTester.ahk"
	}
	Case "mom": { ; Message Mom
		
		Clipboard := "mom"
		vMessenger := "ahk_exe Messenger.exe"
		WinActivate, % vMessenger
		while(!WinActive(vMessenger))
			WinActivate, % vMessenger
		SendInput,^k
		SendEvent, ^v
		Sleep, 1500 ; Sleep needed while search for contact is being processed.
		SendEvent, ^1
		Sleep, 750
		Send % "mom"
	}
	Case "midi": { ; Rest Midi Devices
		
		Process, Close, midiox.exe
		Run, % A_ProgramFiles "\MIDIOX\midiox.exe"
		while(!WinActive("ahk_exe midiox.exe"))
		{
			WinActivate, "ahk_exe midiox.exe"
			Sleep 100
		}
		WinMinimize, ahk_exe midiox.exe
	}
	Case "notion": { ; Toggle Notion App
		
		Toggle_App("Notion", "C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe")
	}
	Case "evernote": { ; Toggle Evernote App
		
		Toggle_App("Evernote", "D:\Program Files (x86)\Evernote\Evernote\Evernote.exe")
	}
	Case "166": { ; Open JXL Project 166
		
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
	Case "compress": { ; Run Compress ImagMagick Script
		
		Run, "C:\AHK Scripts\Tools\Magick\Compress Image.ahk"
	}
	Case "action": { ; Action Zone
		
		Toggle_App("Action Zone", "C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe")
	}
	Case "task": { ; AHK Task Manager
		
		Run, "C:\AHK Scripts\Tools\Task Manager\TaskManager.ahk"
		; Toggle_App("Task Manager", "C:\AHK Scripts\Tools\Task Manager\TaskManager.ahk")
	}
	Case "reset audio", "reset sound": { ; Enable/Disable Default Audio Device
		
		DMD_RunShortcut("C:\AHK Scripts\Audio Image Video\Toggle Default Audio Device.ahk")
	}
	Case "messenger": { ; Run Faceboook Messenger
		
		Run, "C:\Program Files\WindowsApps\FACEBOOK.317180B0BB486_720.6.119.0_x64__8xx8rvfyw5nnt\app\Messenger.exe"
	}
	Case "loud": { ; Loudness Meter Website
			
		Run, "https://www.loudnesspenalty.com/"
		Run, "https://youlean.co/file-loudness-meter/"
	}
	Case "volume": { ; Volume Defaults for Applications
		
		Run, "C:\AHK Scripts\Tools\Volume Per Application.ahk"
	}
	Case "to ico", ".ico": { ; Convert Image on Clipboard to Ico
		
		DMD_RunShortcut("C:\AHK Scripts\Audio Image Video\ImageMagick\Convert to ICO.ahk")
	}
	Case "kill vep": { ; Kill Vepro
		
		Notify().AddWindow("Force Quitting VEPRO", {Title:"Kill VEPRO", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Vienna Ensemble Pro.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:32, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x0B86C5", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
		Process, Close, Vienna Ensemble Pro.exe
	}
	Case "kill dorico": { ; Kill Dorico
		
		Notify().AddWindow("Force Quitting Dorico", {Title:"Kill Dorico", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, Dorico3.5.exe
		Process, Close, VSTAudioEngine3.exe
	}
	Case "kill cubase": { ; Kill Cubase
		
		Notify().AddWindow("Force Quitting Cubase", {Title:"Kill Cubase", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, Cubase11.exe
	}
	Case "kill firefox": { ; Kill Firefox
		
		Notify().AddWindow("Force Quitting FireFox", {Title:"Kill Firefox", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, Firefox.exe
	}
	Case "kill protools": { ; Kill Pro Tools
		
		Notify().AddWindow("Force Quitting ProTools", {Title:"Kill ProTools", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, ProTools.exe
	}
	Case "fix elicenser": { ; Fix Elicenser / Kill Synsopos
		
		Notify().AddWindow("Force Quitting SYNSOPOS.exe", {Title:"Kill ProTools", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, SYNSOPOS.exe
	}
	Case "rec": { ; Record Screen
		
		Run, "C:\AHK Scripts\Tools\AHK Screen Recording\Screen Recording.ahk"
	}
	Case "cfu": { ; Check for Updates
		
		Run, ms-settings:windowsupdate-action
	}
	Case "disk": { ; Run Disk Management
		
		Run, diskmgmt.msc
	}
	Case "device": { ; Run Device Management
			
		Run, *RunAs devmgmt.msc,,,DM
		WinWaitActive, ahk_pid %DM%
		WinMove,ahk_pid %DM%,,,, 1200, 900
	}
	Case "kill xbox": { ; Kill Xbox Chat/Live
		
		Process, Close, XboxApp.exe
		Process, Close, GameBar.exe
		Process, Close, GameBarFTServer.exe
		Process, Close, XboxAppServices.exe
	}
	Case "xbox on": { ; Restore Xbox Chat/Live
		
		RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR, AppCaptureEnabled, 1
	}
	Case "xbox off": { ; Turn Off Xbox Chat/Live
		
		RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR, AppCaptureEnabled, 0
	}
	Case "amd", "ryzen": { ; Find Ryzen
		
		Run, "https://www.newegg.com/amd-ryzen-9-5900x/p/N82E16819113664"
		Run, "https://www.bhphotovideo.com/c/product/1598373-REG/amd_100_100000061wof_ryzen_9_5900x_3_7.html"
		Run, "https://www.bestbuy.com/site/amd-ryzen-9-5900x-4th-gen-12-core-24-threads-unlocked-desktop-processor-without-cooler/6438942.p?skuId=6438942"
		Run, "https://www.microcenter.com/product/630283/amd-ryzen-9-5900x-vermeer-37ghz-12-core-am4-boxed-processor"
		Run, "https://www.amazon.com/Ryzen-5900X-12-Core-Desktop-Processor/dp/B08NXYLBN5"
		Run, "https://www.amd.com/en/where-to-buy/ryzen-5000-series-processors"
		Run, "https://www.walmart.com/ip/AMD-Ryzen-9-5900X-12-core-24-thread-Desktop-Processor/647899167?irgwc=1&sourceid=imp_V-k1NFz4UxyLRBgwUx0Mo388UkERS3R5wWfWUQ0&veh=aff&wmlspartner=imp_62662&clickid=V-k1NFz4UxyLRBgwUx0Mo388UkERS3R5wWfWUQ0&sharedid=&affiliates_ad_id=612734&campaign_id=9383"
	}
	Case "cmd": { ; Command Prompt
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\cmd.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
		Run %comspec% /k
	}
	Case "facebook audio": { ; Open Facebook Audio to Download MP3
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Facebook, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, "https://m.facebook.com/messages/?entrypoint=jewel&no_hist=1 "
	}
	Case "mute": { ; Mute System via RME
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\TotalMixFX.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x6F6E6E", Color:"0xFFFFFF", TitleColor:"0xFF0000"})
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
		WinWaitActive(vWindow)
		Perform_Action({Type:"Mouse",Action:"Left",Actual:0,ClickCount:1,RestorePOS:0,Wait:2,WindowWait:2,Comment:"Mouse Click",Match:1,OffsetX:-119,OffsetY:43,Area:"RME TotalMix FX: Babyface Pro ahk_exe TotalMixFX.exe",Bits:"zzzzzzzzzzzzzzzzzzzzzSrzrhzyvTyyrzjhzsPTxyrzzhzzzzzzzzzzzzzzzzzzzzy",Ones:374,Zeros:26,Threshold:129,W:20,H:20})	
		If (vState = -1)
			WinMinimize, % vWindow
		DetectHiddenWindows, Off
	}
	Case "TotalMix": { ; Open Total Mix RME App
		
		Run, % A_WinDir "\System32\TotalMixFX.exe"
	}
	Case "dorico": { ; Open Dorico Composition Folder
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Dorico, Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_Run("F:\Dorico")
	}
	Case "hk signal": { ; Hotkeys for Signal
		
		Run, "https://support.signal.org/hc/en-us/articles/360036517511-Signal-Desktop-Keyboard-Shortcuts"
	}
	Case "backup music": { ; Backup
		
		Run, "C:\Program Files\DirSyncPro\DirSyncPro.exe" /sync "C:\Program Files\DirSyncPro\Backup of Jedi Archives Config.dsc"
	}
	Case "bravura": { ; Bravura Text Help Doc
		
		Run, "https://w3c.github.io/smufl/latest/index.html"
	}
	Case "shuffle": { ; Newegg Shuffle
		
		Run, "https://www.newegg.com/product-shuffle"
	}
	Case "notify help": { ; List of Notify Options
		
		x = Usage:`rNotify:=Notify()`rWindow:=Notify.AddWindow("Your Text Here",{Icon:4,Background:"0xAA00AA"})`r|---Window ID|--------Options`rOptions:`rWindow ID will be used when making calls to Notify.SetProgress(Window,ProgressValue)`rAnimate: Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)`rBackground: Color value in quotes eg. {Background:"0xAA00AA"}`rButtons: Comma Delimited list of names for buttons eg. {Buttons:"One,Two,Three"}`rColor: Font color eg.{Color:"0xAAAAAA"}`rFlash: Flashes the background of the notification every X ms eg. {Flash:1000}`rFlashColor: Sets the second color that your notification will change to when flashing eg. {FlashColor:"0xFF00FF"}`rFont: Face of the message font eg. {Font:"Consolas"}`rIcon: Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}`rIconSize: Width and Height of the Icon eg. {IconSize:20}`rHide: Comma Separated List of Directions to Hide the Notification eg. {Hide:"Left,Top"}`rProgress: Adds a progress bar eg. {Progress:10} Starts with the progress set to 10`rRadius: Size of the border radius eg. {Radius:10}`rSize: Size of the message text eg {Size:20}`rShowDelay: Time in MS of how long it takes to show the notification`rSound: Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}`rTime: Sets the amount of time that the notification will be visible eg. {Time:2000}`rTitle: Sets the title of the notification eg. {Title:"This is my title"}`rTitleColor: Title font color eg. {TitleColor:"0xAAAAAA"}`rTitleFont: Face of the title font eg. {TitleFont:"Consolas"}`rTitleSize: Size of the title text eg. {TitleSize:12}
		m(x)
	}
	Case "skype": { ; Run Skype
		
		Notify().AddWindow("Running Skype", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\Microsoft\Skype for Desktop\Skype.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x00A0E1", Color:"0xFFFFFF", TitleColor:"0xFFFFFF;"})
		RegRead, vRun, HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run, Skype for Desktop
		Run, % vRun
	}
	Case "website stuff": { ; open folder to website stuff
		
		Run, "D:\Users\Dillon\Desktop\Desktop Items\website stuff"
	}
	Case "photoshop": { ; Adobe Photoshop
		
		Run, % A_ProgramFiles64 "\Adobe\Photoshop\Photoshop.exe"
		Notify().AddWindow("Running Adobe Photoshop", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Adobe\Photoshop\Photoshop.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Photoshop := "Adobe Creative Cloud ahk_exe Adobe Desktop Service.exe"
		WinWaitActive, %Photoshop%
		WinActivate, %Photoshop%
		ControlClick,Quit,%Photoshop%,,L,2
	}
	Case "premiere": { ; Adobe Premiere
		
		Run, % A_ProgramFiles64 "\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe"
		Notify().AddWindow("Adobe Premiere", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "chrome": { ; Run Chrome
		
		Run, % A_ProgramFiles "\Google\Chrome\Application\chrome.exe"
	}
	Case "disable internet": { ; Disable LAN Connection
		
		Run *RunAs %comspec% /c netsh interface set interface name="Ethernet" admin=DISABLED
	}
	Case "enable internet": { ; Enable LAN Connection
		
		Run *RunAs %comspec% /c netsh interface set interface name="Ethernet" admin=ENABLE
	}
	Case "vep": { ; Run VEPRO 7
		
		Run, "C:\Program Files\Vienna Ensemble Pro\Vienna Ensemble Pro.exe" -server
		Notify().AddWindow("Running VEPRO 7",{Animate:"Center",ShowDelay:100,Icon:236,IconSize:50,Title:"",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	}
	Case "winsquare", "window square": { ; Make Active Window into Square Format for Recording
		
		WinGetActiveTitle,A
		Sleep, 50
		WinMove, %A%,,,,1080,1080
	}
	Case "win9:16", "winvertical": { ; Make Active Window into Square Format for Recording
		
		WinGetActiveTitle,A
		Sleep, 50
		WinMove, %A%,,,,1080,1920
	}
	Case "shell icons": { ; Shell Icon List
		
		Run, % A_Dropbox "\AHK Scripts\Tools\Shell Icon List.ahk"
	}
	Case "how to Dorico": { ; Dorico HOW TO in Notion
		
		Run, % A_Dropbox "\AHK Scripts\_DMD Scripts\_Master Script\Run\Shortcuts\Dorico How To's.url"
	}
	Case "nyu": { ; NY Unemployment Questions
		
		Run, % A_Dropbox "\AHK Scripts\_DMD Scripts\_Master Script\Run\Shortcuts\NY Unemployment Questions.url"
	}
	Case "disaster": { ; Disaster Grant
		
		Run, "https://covid19relief1.sba.gov/Account/Login?Ticket=d746563b2dc94ecf81d1eee115fbfdff"
	}
	Case "accv": { ; Acc Viewer
		
		Run, % A_Dropbox "\AHK Scripts\Tools\ACC_Viewer\AccViewer_JG.ahk"
	}
	Case "Atlantis": { ; Notion Atlantis Overview
		
		Run, % A_Dropbox "\AHK Scripts\_DMD Scripts\_Master Script\Run\Shortcuts\Atlantis.url"
	}
	Case "Window Pos", "Win Pos": { ; Get Window Position
		
		WinGetActiveTitle,T
		WinGetPos,x,y,w,h,A
		WinPos:="x"x A_Tab "y"y "`n" "w"w A_Tab "h"h
		Clipboard:= "x"x " " "y"y
		Notify().AddWindow(WinPos, {Title:T, Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "wininfo", "wintitle": { ; Get Window Info of Current Window
		
		Sleep, 50 ; Needed for window to bounce back to original after opening MSC
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
	Case "remove line breaks", "remove returns": { ; Remove Line Breaks/Returns from Clipboard
		
		StringReplace, Clipboard, Clipboard,  `r`n,%A_Space%, All 
		ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice.
		; ... here make temporary use of the clipboard, such as for pasting Unicode text via Transform Unicode ...
		Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
		Clipboard := RegExReplace(Clipboard,"\. +",".`n")
		Notify().AddWindow(Clipboard, {Title:"Clipboard has been changed", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "remove extra spaces": { ; Remove Double or More Spaces from String on Clipboard
		
		Clipboard:=RemoveExtraSpaces(Clipboard)
		Notify().AddWindow("On the Clipboard!", {Title:"Removed Extra Spaces from Clipboard", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
	}
	Case "snip", "windows snip": { ; Run Joe's Window Snip Program
		
		DMD_RunShortcut(A_Dropbox "\Tools\Window Snipping\WindowSnipping.ahk")
	}
	Case "teamv": { ; Run TeamViewer
		
		Run, % A_ProgramFiles "\TeamViewer\TeamViewer.exe"
	}
	Case "kill teamv": { ; Kill TeamViewer
		
		Process, Close, TeamViewer.exe
	}
	Case "kill vscode": { ; Kill TeamViewer
		
		Process, Close, Code.exe

	}
	Case "kill kontakt": { ; Kill Kontakt
		
		Process, Close, Kontakt.exe
	}
	Case "msi util": { ; Run MSI Utility for better GPU/CPU Performance
		
		; DMD_RunShortcut("C:\Program Files\MSI Utility\3 MSI Mode Tool.exe")
		Run, % A_ProgramFiles64 "\MSI Utility\3 MSI Mode Tool.exe"
	}
	Case "home": { ; Notion Home
		
		MouseGetPos,xx,yy
		WinActivate, Home ahk_exe notion.exe
		WinGetActiveStats, Title, Width, Height, X, Y	
		MouseMove, Width / 2, Height / 2, 0
		SetMouseDelay, 50
		; Send, {WheelUp 10}
		; Sleep, % SN
		Send, {WheelDown 4}
		MouseMove, % xx, % yy
	}
	Case "kill ahk": { ; Kill ALL AHK Scripts besides MSC
		
		; Run,%ComSpec% /c Taskkill -f -im autohotkey.exe,%A_ScriptDir%,
		ExitAll() ;   Exits all AHK apps except the calling script.	
		ExitAll() { ; by SKAN : www.autohotkey.com/forum/viewtopic.php?p=309841#309841
			DetectHiddenWindows, % ( ( DHW:=A_DetectHiddenWindows ) + 0 ) . "On"		
			WinGet, L, List, ahk_class AutoHotkey		
			Loop %L%			
				If ( L%A_Index% <> WinExist( A_ScriptFullPath " ahk_class AutoHotkey" ) )			
					PostMessage, 0x111, 65405, 0,, % "ahk_id " L%A_Index%		
			DetectHiddenWindows, %DHW%		
		}
	}
	Case "purge kontakt": { ; Purge Kontakt
		
		SN:= 50 ; Sleep Number
		VEP:= "ahk_class SteinbergWindowClass" ; VEPRO Window Title	
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
	Case "purge vepro": { ; Purge Kontakt in VEPRO
		
		Run, % A_Dropbox "\AHK Scripts\Music Scripts\Kontakt\Global Purge Kontakt\Kontakt Purge All v1.00 DMD.ahk"
	}
	Case "shorcut notion": { ; Convert Notion Link into Shorcut Link
		
		CLipboard:= StrReplace(Clipboard, "https","notion",1)
		Notify().AddWindow(Clipboard, {Title:"Notion GLobal Link", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x1B1B1B", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
	}
	Case "global link": { ; Convert Link into Global Link for Notion
		
		SplitPath,Clipboard,x,y
		x:=SubStr(StrSplit(x,"#").2,1)
		Clipboard:=y "/" x
		Notify().AddWindow(Clipboard, {Title:"Notion Global Link", Font:"Madness Hyperactive", TitleFont:"Madness Hyperactive", Icon:"C:\Users\Dillon\AppData\Local\Programs\Notion\Notion.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:6000, Background:"0x1B1B1B", Color:"0xFFFFFF", TitleColor:"0xFFFFFF"})
	}
	Case "reg loc": { ; Run Registry Software Location Software
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\regedit.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_Dropbox "\AHK Scripts\_Master Script\Run\Shortcuts\Reg Software Locations - Shortcut.lnk"
	}
	Case "sum of clip": { ; Sum of the Clipboard
		
		StringSplit,Total,Clipboard,`n	
		New := 0.00
		Loop,%Total0%
			New += Total%A_Index%
		Clipboard:=Format("{:0.2f}", New)
		Notify().AddWindow(Clipboard, {Title:"Sum of Numbers", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "Studio": { ; Run AHK Studio as ADMIN
		
		DMD_RunShortcut("C:\AHK Studio\AHK-Studio.ahk")
	}
	Case "n. color", "color notion": { ; Notion Color Selector GUI
		
		Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Notion Color Selector - Shortcut.lnk"
	}
	Case "Cubase template": { ; Load Cubase Template Dir
		
		Run "F:\Cubase\Templates\2021 Master Template"
	}
	Case "latencymon": { ; Run/Start LatencyMon for Audio Problem Identifier
		
		Run, % A_ProgramFiles64 "\LatencyMon\LatMon.exe"
	}
	Case "Remove Notify Breaks": { ; Remove Notify Line Breaks
		
		Row:= Clipboard
		; Part 1 - Removing Comments
		Row:= RegExReplace(Row, "m`a)(\R)?^\s*;.*(?(1)|\R)") ; Sort of worked
		C1:=" `; Remove " Chr(34) Chr(34) " if want to use a variable, NO percents!"
		C2 =
		(
		;  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
		)
		C3 =
		(
		; Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
		)
		StringReplace,Row,Row,% C1,,All
		StringReplace,Row,Row,% C2,,All
		StringReplace,Row,Row,% C3,,All
		; Part 2 -Removing Line Breaks
		StringReplace Row, Row, %A_Space% `r`n, %A_Space%, All
		StringReplace Row, Row, `r`n, %A_Space%, All
		StringReplace, Row, Row, `n`t,, All
		StringReplace, Row, Row, `,,`,%A_Space%, All
		; Part 4 - Remove Tabs
		StringReplace, Row, Row, %A_Tab%, %A_Space%,All
		; Part 5 - Remove Double Spaces
		Row:=Trim(RegExReplace(Row, "\h\K\h+"))
		StringReplace, Row, Row, % " ,", `,,All ; Removes " ,"
		; Part 5 - Execution
		Clipboard:= ""
		ClipWait, 0
		Clipboard:= Row
		Notify().AddWindow("On the Clipboard!", {Title:"Converted Notify Breaks into Single Line"	, Font:"Sans Serif"	, TitleFont:"Sans Serif"	, Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico,  1" 	, Animate:"Right, Slide" 	, ShowDelay:100		, IconSize:64		, TitleSize:14	, Size:20	, Radius:26	, Time:2500	, Background:"0xFFFFFF"	, Color:"0x282A2E"		, TitleColor:"0xFF0000"})	
	}
	Case "process explorer", "proc explorer": { ; Run Process Explorer
		
		Run, % A_ProgramFiles64 "\ProcessExplorer\procexp64.exe"
		Notify().AddWindow("Running Process Explorer", {Title:"Run Procexp64.exe", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\ProcessExplorer\procexp64.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "process monitor", "proc mon": { ; Run Process Monitor
		
		Run, % A_ProgramFiles64 "\ProcessMonitor\Procmon.exe"
		Notify().AddWindow("Running Process Monitor", {Title:"Run Procexp64.exe", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\ProcessExplorer\procexp64.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "registry changes", "reg changes": { ; Run Registry Changes
		
		Run, % A_ProgramFiles64 "\Registry Changes View\RegistryChangesView.exe"
		Notify().AddWindow("Running Process Monitor", {Title:"Run Procexp64.exe", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\ProcessExplorer\procexp64.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "signal": { ; Open Signal
		
		wSignal := "ahk_exe Signal.exe"
		If !WinExist(wSignal){
			Run, A_AppDataLocal "\Programs\signal-desktop\Signal.exe"
		}
		Loop { ; Wait til Signal exists...
			WinActivate, % wSignal
			WinGet,winState,MinMax,% wSignal
			Sleep, 10
		}Until winState := 1
		WinWaitActive, % wSignal
		SendInput, #+{Right}
		Notify().AddWindow("Signal is Opened", {Title:"Running Signal", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Users\Dillon\AppData\Local\Programs\signal-desktop\Signal.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "qap": { ; Quick Access Popup
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files\Quick Access Popup\QuickAccessPopup-64-bit.exe", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		; vQAP := A_ProgramFiles64 "\Quick Access Popup\QuickAccessPopup-64-bit.exe"
		vQAP := A_Dropbox "\Quick Access Popup\QuickAccessPopup-64-bit.exe"
		Run, % vQAP, % SplitPath(vQAP).dir
		; Run *RunAs %ComSpec% /k %vQAP% ; /k keep CMD window open after command || /c close CMD window after command
	}
	Case "revo": { ; Run Revo Uninstaller
		
		Run, A_ProgramFiles64 "\VS Revo Group\Revo Uninstaller Pro\RevoUninPro.exe"
	}
	Case "am I admin": { ; Is MSC Running as Admin
		
		A_IsAdmin ? m("I'm ADMIN") : m("I'm Not ADMIN")
	}
	Case "regedit": { ; Open Windows Registry
			
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\regedit.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
		Run, regedit
	}
	Case "services": { ; Services Windows
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\regedit.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
		Run, services.msc
	}
	Case "install OSC": { ; Install New Version of OSC
		
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\OSC Install New Version.ahk")
	}
	Case "info bios": { ; Bios Information
		
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
	Case "info computer": { ; Computer Information
		
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\Master Search Box\UserCommand Run Scripts\Info Computer System.ahk")	
	}
	Case "info mb": { ; Motherboard Information
		
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
	Case "info OS": { ; Info on Windows OS
		
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\Master Search Box\UserCommand Run Scripts\Info OS.ahk")
	}
	Case "reminder compression": { ; Remind me of how compression works
		
		Msgbox
		(
		Compression is one of the most powerful tools at your disposal. It's not only a technical tool, but a creative one that can significantly shape the sound of your mix:
	    -fast attack to tame transients
	    -slow attack/long release to extend sustain and create a fuller sound
	    -impart consistency to an inconsistently performed instrumental part
	    -alter timbre and tone
		)
	}
	Case "reminder tax on stock sell": { ; Reminder of How Tax works on Stocks
		
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
	Case "gif signal": { ; Upload Gif to Signal
		
		vClip 	:= Clipboard
		vWindow 	:= "ahk_exe Signal.exe"
		SplitPath, vClip, vName, vDir, vEXT, vNNE, vDrive
		if (vEXT != "gif" || vEXT = "")									; Make sure clipboard is the *.gif otherwise error out
		{
			m("Gif not on Clipboard")
			Return
		}
		while(!WinActive(vWindow)){
			WinActivate, % vWindow
			Sleep, 100
		}
		SendInput, ^u
		WinWaitActive, Open
		IfWinActive, Open
			SendInput, ^v
		Loop
			ControlGet, vEditField, Line, 1, Edit1, Open
		Until vEditField = vClip											; Loop until editfield = clipboard, to ensure gave enough time for paste of clipbaord
		ControlClick, Button1, Open,, Left,,NA
		WinWaitActive, % vWindow
		Perform_Action({Type:"Mouse",Action:"Left",Actual:0,ClickCount:1,RestorePOS:"",Wait:2,WindowWait:2,Comment:"Mouse Click",Match:1,OffsetX:63,OffsetY:7,Area:"Signal ahk_class Chrome_WidgetWin_1",Bits:"3zw1k3Uk0AM01g00D003UUEMQC673VUUEM006001U00Mk3761Xkzkq1UMk0A70C0zz2",Ones:118,Zeros:282,Threshold:211,W:20,H:20})
		SetWinDelay, 250 												; Needed otherwise won't upload gif because windelay is too quick!
		WinActivate, % vWindow
		SendInput, {Enter}
	}
	Case "alt codes": { ; Alt Codes for AHK
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Msgbox 
		(
		Chr(32) = a space
		Chr(34) = quotes
		Chr(37) = `%
		)
	}
	Case "url", "shorten url": { ; Shorten URL
		
		apiTiny 	:= "https://tinyurl.com/api-create.php?url="    
		url 		:= apiTiny . EncodeDecodeURI(Clipboard)
		Clipboard := HttpQuery(url)
		Notify().AddWindow("Clipboard:= "HttpQuery(url), {Title:getMSCTitle(MasterScriptCommands, DIR), Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "doge": { ; Run DodgeCoin Stocks Fav Windows/Tabs
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		vFoFFox := ["C:\Program Files\Mozilla Firefox\firefox.exe"
	                ,"https://robinhood.com/crypto/1ef78e1b-049b-4f12-90e5-555dcf2fe204/chart"
	                ,"https://coinmarketcap.com/"
	                ,"https://bitinfocharts.com/dogecoin/address/DCtMAyy9w2QCrWMRdZ28Kn7GwMfCEp2irP"
	                ,"https://bitinfocharts.com/dogecoin/address/DRSqEwcnJX3GZWH9Twtwk8D5ewqdJzi13k"]
		for Key, Value in OFFox
		{
			vRun .= Value A_Space
		}
		Run, % SubStr(vRun,1,StrLen(vRun)-1)
	}
	Case "highlight": { ; Highlight Area of Screen
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\Tools\Highlight Screen with Rect Box.ahk")
	}
	Case "align": { ; Align Text by Variable
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\Align Text by Variable.ahk")
	}
	Case "sort clip": { ; Sort Clipboard Alphabetically
		
		Sort, Clipboard
		Notify().AddWindow(Clipboard, {Title:"Sorted Clipboard - Just Paste it!", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "system settings": { ; Advanced System Settings
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Windows\System32\SystemPropertiesAdvanced.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, "SystemPropertiesAdvanced"
	}
	Case "signal save conversation": { ; Save Signal Conversation, Run with VLC x2 Speed
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_Signal ", 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\_DMD Scripts\Signal\Signal Save Conversation & Run.ahk")
	}
	Case "swap editor": { ; Swap Default Editor
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\Joe Glines Nifty Scripts\Editor Swap\Editor Swap.ahk")
	}
	Case "kill all ahk": { ; Kill every AHK Script
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
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
		DetectHiddenWindows, Off
		ExitApp
	}
	Case "icon to dll": { ; Resource Hacker Icon to DLL
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_ProgramFiles "\Resource Hacker\ResourceHacker.exe"
	}
	Case "Startup": { ; Enable / Disable Startup Programs
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut(A_Dropbox "\AHK Scripts\Tools\Add to Startup\AddToStartUp.ahk")
	}
	Case "dir qap": { ; Open Quick Access Popup Folder
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})	
		Run, % A_ProgramFiles64 "\Quick Access Popup"
	}
	Case "list into obj", "list to obj": { ; List to Object
		
		Clipboard := RegExReplace(Clipboard,"\n","") ; Remove any extra line breaks from clipboard
		oArr      := []
		Loop, Parse, % Clipboard, `n`r
		{
			if (A_LoopField = space) ; if A_LoopField is blank than loop again
				Continue
			if (A_LoopField ~= "^\d+(\.?)\d+$") ; If Line is a digit, number or integer don't wrap in quotes
				oArr.Push(A_LoopField ",")	
			else
				oArr.Push(chr(34) A_LoopField Chr(34) ",") ; Wrap every line with quotes
		}
		for key, value in oArr
		{
			vStr .= value ; Shove each value into a string
			oObj := "oObj := [" RegExReplace(vStr, ",",,,,-1) "]" ; Remove last "," in Obj[]
		}
		Clipboard := oObj
		ClipWait, 1
		if (ErrorLevel)
			Msgbox % "Object Couldn't Copy Into Clipboard"
		Notify().AddWindow(Clipboard, {Title:"Parse List into Object"})
	}
	Case "install OSC": { ; Install New Version of OSC
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:AHK Scripts_Master ScriptResourcesMaster If Commands IconsCogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut("C:\AHK Scripts\_DMD Scripts\Master Search Box\UserCommand Run Scripts\OSC Install New Version.ahk")
	}
	Case "keyboard OSD": { ; Keyboard OSD
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_RunShortcut("C:\AHK Scripts\Tools\KeyboardOSD\KeysPressedOSD.ahk")
	}
	Case "edit dirs": { ; Edit Directory Paths
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_Dropbox "\AHK Scripts\_DMD Scripts\Hotstring Directory Paths\Directory Paths.ini"
	}
	Case "temp": { ; Open Temp Folder
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run % A_Temp
	}
	Case "message spy": { ; Run Spy++ to catch window messages
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_ProgramFiles "\Microsoft Visual Studio\2017\Community\Common7\Tools\spyxx.exe"
	}
	Case "msconfig": { ; MSConfig
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run % A_WinDir "\SysNative\msconfig.exe"
	}
	Case "edit Dorico commands": { ; Open Dorico Usermacro Location
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_AppData "\Steinberg\Dorico 3.5\Script Plug-ins"
	}
	Case "backup dorico": { ; Backup Dorico
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		DMD_Run(A_Dropbox "\AHK Scripts\_DMD Scripts\Dorico Settings Backup & Restore.ahk")
	}
	Case "network sharing": { ; Network Sharing Control Panel
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % "control.exe /name Microsoft.NetworkandSharingCenter"
	}
	Case "filepath to html path": { ; Convert file path to HTML path
		
		Clipboard := RegExReplace(Clipboard,"\\","/")
		Notify().AddWindow(Clipboard, {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "filepath to js esc \\": { ; Convert file path to js esc with double \\
		
		Clipboard := RegExReplace(Clipboard,"\\","\\")
		Notify().AddWindow(Clipboard, {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
	}
	Case "ep drop": { ; Open NW Dropbox
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		if FileExist(EnvVars("%LOCALAPPDATA%\Dropbox\info.json"))
			FileRead, strDropboxJsonFileContent, % EnvVars("%LOCALAPPDATA%\Dropbox\info.json")
		else if FileExist(EnvVars("%APPDATA%\Dropbox\info.json"))
			FileRead, strDropboxJsonFileContent, % EnvVars("%APPDATA%\Dropbox\info.json")
		; RegExMatch(strDropboxJsonFileContent, "(?<=\x22path\x22: \x22).*(?=\x22,)", oMatch)
		; return StrReplace(oMatch, "\\", "\")
		Run % JSON.parse(strDropboxJsonFileContent).business.path "\Mothra" ; personal not business dropbox
	}
	Case "ep cpa": { ; Open NW Dropbox CPA
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		if FileExist(EnvVars("%LOCALAPPDATA%\Dropbox\info.json"))
			FileRead, strDropboxJsonFileContent, % EnvVars("%LOCALAPPDATA%\Dropbox\info.json")
		else if FileExist(EnvVars("%APPDATA%\Dropbox\info.json"))
			FileRead, strDropboxJsonFileContent, % EnvVars("%APPDATA%\Dropbox\info.json")
		; RegExMatch(strDropboxJsonFileContent, "(?<=\x22path\x22: \x22).*(?=\x22,)", oMatch)
		; return StrReplace(oMatch, "\\", "\")
		Run % JSON.parse(strDropboxJsonFileContent).business.path . "\Mothra\CPA" ; personal not business dropbox
	}
	Case "spaces to underscores": { ; Spaces to Underscores
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Clipboard := RegExReplace(Clipboard, "\s", "_")
	}
	Case "ep 2mx to folder": { ; 2mx to Netflix folder COPY
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		InputBox, vPath, Folder of 2mxs
		if (ErrorLevel)
			return
		InputBox, vDest, Destination Folder
		if (ErrorLevel)
			return
		Loop, Files, % vPath "\*.*", FDR 
		{
			if A_LoopFileName ~= "i)MASTER"
				FileCopy, % A_LoopFileFullPath, % vDest . "\*.*"
		}
	}
	Case "ep netflix renaming": { ; Rename files according to Netflix Rules
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		; Fix naming scheme
		; parse by _
		MsgBox,48,Warning!,Make local copy (backup) before proceeding as there is no undoing.
		InputBox, vPath, FolderPath of Original Score Multi-Track Recordings
		; vPath := "F:\Pro Tools Local\Deliverables\101\a. Original Music\01. CPA 101 Original Score Multi-Track Recordings\01. CPA 101 Original Score Multi-Track Recordings\CPA_NW_101_m02A_BeZenPhilJackson_p200720_v1.00_48k_24b"
		; vPath := "F:\Pro Tools Local\Deliverables\101\a. Original Music\01. CPA 101 Original Score Multi-Track Recordings\01. CPA 101 Original Score Multi-Track Recordings"
		o := []
		Loop, Files, % vPath "\*.*", FR 
		{
			o := []
			o.push(StrSplit(A_LoopFileName, "_"))
			; m(o)
			i = 1
			x := o[i].1 "_"                                                    ; CPA - project abbrev
	   		   . o[i].2 "_"                                                    ; NW - composer initials
	   		   . o[i].3 "_"                                                    ; 101 - episode
	   		   . o[i].4 "_"                                                    ; m02A - cue number
	   		   . RegExReplace(o[i].5, "[/?<>\\:;|'\x22+*#\s]") "_"             ; BeZenPhilJackson - title of cue
	   		   . o[i].10 "_"                                                   ; Stem name (bass/guitar/etc)
	   		   . (o[i].11 ~= "i)2ch" ? "" : StrReplace(o[i].11,".wav","") "_") ; "version"
	   		   . o[i].6 "_" 
	   		   . o[i].8 "_" 
	   		   . o[i].9 "_" 
	   		   . (o[i].11 ~= "click" ? "mono_" : "2ch_")
	   		   . o[i].7
			; i++
			FileMove, % A_LoopFileFullPath, % A_LoopFileDir . "\" . x . ".wav"
		}
		o := []
		Loop, Files, % vPath "\*.*", D 
		{
			o := []
			o.push(StrSplit(A_LoopFileName, "_"))
			; m(o)
			i = 1
			x := o[i].1 "_"                                               	   ; CPA - project abbrev
	   		   . o[i].2 "_"                                                    ; NW - composer initials
	   		   . o[i].3 "_"                                                    ; 101 - episode
	   		   . o[i].4 "_"                                                    ; m02A - cue number
	   		   . RegExReplace(o[i].5, "[/?<>\\:;|'\x22+*#\s]") "_"             ; BeZenPhilJackson - title of cue
	   		   ; . o[i].10 "_"                                                   ; Stem name (bass/guitar/etc)
	   		   ; . (o[i].11 ~= "i)2ch" ? "" : StrReplace(o[i].11,".wav","") "_") ; "version"
	   		   . o[i].6 "_" 
	   		   . o[i].8 "_" 
	   		   . o[i].9 "_" 
	   		   ; . (o[i].11 ~= "click" ? "mono_" : "2ch_")
	   		   . "2ch_"
	   		   . o[i].7
				; i++
				; m(x)
			FileMoveDir, % A_LoopFileFullPath, % A_LoopFileDir . "\" . x
		}
		m("done")
	}
	Case "ep hub": { ; NW Script Hub
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run % "D:\Users\Dillon\Dropbox\AHK Scripts\_DMD Scripts\NW Work Scripts\NW Scripts Hub\NW Scripts Hub.ahk"
	}
	Case "reset midi": { ; Reset MidiOX
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\MIDIOX\midiox.exe, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Process, Close, midiox.exe
		If !WinExist("ahk_class MIDIOX:Frame")
			Run, % "C:\Program Files (x86)\MIDIOX\midiox.exe",,Min
	}
	Case "install qap": { ; Install New QAP Port Version
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run % A_Dropbox "\AHK Scripts\_DMD Scripts\QAP\QAP Install New Portable Version.ahk"
	}
	Case "sum of times": { ; Sum of Times from Clipboard
		
		vDuration := 0
		Loop, Parse, Clipboard, "`n`r" 
		{
			value := A_LoopField
			if (value = "") {
				Continue
			}
			vTime  := StrSplit(value,":")
			RegExReplace(value,":","",vTotal)
			if (vTotal = 1) {
				vDuration += vTime.1 * 60 + vTime.2   ; mm/ss
			}
			if (vTotal = 2){
				m("here")
				vDuration += vTime.1 * 3600 + vTime.2 * 60 + vTime.3   ; hh/mm/ss
			}
		}
		vTotalDuration      := Format("{1:.2f}", vDuration/60)
		vTotalDuration      := StrReplace(vTotalDuration,"-","") ; if negative
		vTotalDurationSplit := StrSplit(vTotalDuration,".")
		vMinutes            := vTotalDurationSplit.1
		vSeconds            := "0." (vTotalDurationSplit.2) * 60
		vSeconds            := vTotalDurationSplit.2 * 0.6
		vTotalDuration      := vMinutes ":" Format("{1:d}", (vSeconds ~= "0." ? StrReplace(vSeconds,"0.","") : vSeconds))
		vTotalDuration      := StrReplace(vTotalDuration,".",":") (vTotalDurationSplit.1 = "0" ? " secs" : " mins")
		Clipboard := vTotalDuration
		; if (vTotalDurationSplit.2 >= 60) {
		;     vTotalDuration := (vTotalDurationSplit.1 + 1) ":" Format("{1:02}", (vTotalDurationSplit.2 - 60))
		; }
		; Notify().AddWindow(vTotalDuration, {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Swal.toast(vTotalDuration)
	}
	Case "difference of times", "diff of times": { ; Difference of Times
		
		vDuration := 0
		oDuration := []
		Loop, Parse, Clipboard, "`n`r" 
		{
			value := A_LoopField
			if (value = "") {
				Continue
			}
			vTime  := StrSplit(value,":")
			RegExReplace(value,":","",vTotal)
			if (vTotal = 1) {
				vDuration := vTime.1 * 60 + vTime.2   ; mm/ss
				oDuration.push(vDuration)
			}
			if (vTotal = 2){
				vDuration := vTime.1 * 3600 + vTime.2 * 60 + vTime.3   ; hh/mm/ss
				oDuration.push(vDuration)
			}
		}
		vTotalDuration      := Format("{1:.2f}", (oDuration.1 - oDuration.2)/60)
		vTotalDuration      := StrReplace(vTotalDuration,"-","") ; if negative
		vTotalDurationSplit := StrSplit(vTotalDuration,".")
		vMinutes            := vTotalDurationSplit.1
		vSeconds            := vTotalDurationSplit.2 * 0.6
		vSeconds            := Format("{:.2f}", vSeconds)
		vTotalDuration      := vMinutes ":" Format("{1:d}", Round(vSeconds))
		vTotalDuration      := StrReplace(vTotalDuration,".",":") (vTotalDurationSplit.1 = "0" ? " secs" : " mins")
		/* vTotalDuration      := StrReplace(vTotalDuration,"-","") ; if negative
		vTotalDurationSplit := StrSplit(vTotalDuration,".")
		vTotalDuration      := StrReplace(vTotalDuration,".",":") " mins" 
		*/
		; if (vTotalDurationSplit.2 >= 60) {
		; 	vTotalDuration := (vTotalDurationSplit.1 + 1) ":" (vTotalDurationSplit.2 - 60)
		; }
		Clipboard := vTotalDuration
		; Notify().AddWindow(vTotalDuration, {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Swal.Toast(vTotalDuration)
	}
	Case "crom": { ; Load Remote Server Chrome
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:AHK Scripts_Master ScriptResourcesMaster If Commands IconsCogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % A_MyDocuments "\CROM.rdp"
	}
	Case "server": { ; Load Remote Server DMD
		
		vExe := A_MyDocuments "\server.rdp"
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:vExe ", 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run, % vExe
	}
	Case "% diff": { ; Percentage Difference Calculator
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		JS =
		(LTrim Join`n
			Swal.fire({
				className: "swal-css",
						showClass: {
							backdrop: "rgba(0,0,0,0.0);swal2-noanimation",
							popup: "",
						},
				title: 'Percetange Difference Calculator',
				html: '<input id="swal-input1" class="swal2-input" placeholder="Value 1">' +
					'<input id="swal-input2" class="swal2-input" placeholder="Value 2">',
				icon: "question",
				showDenyButton: true,
				showCancelButton: true,
				confirmButtonText: "Ok",
				cancelButtonText: "ExitApp",
				cancelButtonColor: '#d33',
				denyButtonText: '<i class="fa fa-edit"></i> Clipboard',
				denyButtonColor: "#D0A548",
				focusConfirm: false,
				allowEscapeKey: false,
				preConfirm: function () {
					const val1 = Swal.getPopup().querySelector('#swal-input1').value
					const val2 = Swal.getPopup().querySelector('#swal-input2').value
					if (!val1 || !val2) {
						Swal.resetValidationMessage()
						Swal.showValidationMessage("Please enter values 1 & 2")
					}
					return { val1: val1, val2: val2 }
				},
				preDeny: function () {
					const val1 = Swal.getPopup().querySelector('#swal-input1').value
					const val2 = Swal.getPopup().querySelector('#swal-input2').value
					if (!val1 || !val2) {
						Swal.resetValidationMessage()
						Swal.showValidationMessage("Please enter values 1 & 2 PLEASE!!!")
					}
					return ((val1 && val2) ? true : false)
				}
			}).then(function (result) {
				let v1 = Number($("#swal-input1").val())
				let v2 = Number($("#swal-input2").val())
				let vDiff = ((v1-v2)/((v1+v2)/2))*100
				if (result.isConfirmed) {
					Swal.update({
					
					})
					swal.exitSwal(neutron)
				}
				if (result.isDenied) {
					swal.setClipboard(neutron, vDiff)
					swal.exitSwal(neutron)
				}
				if (result.isDismissed) {
					swal.exitSwal(neutron)
				}
			})
			$("#swal-input1").show()
		)
		Swal.Fire(JS,,,0)
		Clipboard := RegExReplace(Format("{:.2f}", Clipboard),"-","") "%"
		(A.isUndefined(Clipboard) ? "" : Swal.Toast(Clipboard,{timer:1500}))
	}
	Case "neutron debug": { ; IeChooser
		
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})
		Run % A_ComSpec "\..\F12\IEChooser.exe"
	}
}