; Created by Asger Juul BRunshøj
;~ Adapted by DMDComposer

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.

;~ Chr(32) = a space
;~ Chr(34) = quotes

;-------------------------------------------------------------------------------
;;; SEARCH GOOGLE ;;;
;-------------------------------------------------------------------------------
if (MasterScriptCommands = "g. " || MasterScriptCommands = "google"){ ;~ Search Google
	gui_search_title = LMGTFY
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
}

else if(MasterScriptCommands = "you " || MasterScriptCommands = "youtube "){ ;~ Search Youtube
	gui_search_title = Youtube Search
	gui_search("https://www.youtube.com/results?search_query=REPLACEME&page=&utm_source=opensearch")
}

else if(MasterScriptCommands = "ahk "){ ;~ Search for AHK Related Info
	gui_search_title = Autohotkey Google Search
	;~ gui_search("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk0356faDBEtpcEjEwIwMscFvTxXMmg%3A1590206661049&ei=xaDIXsXJAq6vytMPh5ChgAU&q=site%3Astackoverflow.com+REPLACEME&oq=site%3Astackoverflow.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DwR1iDZGCnZ2gAcAB4AIABhgGIAcQHkgEEMTAuMpgBAKABAqABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwiFwJq5jcnpAhWul3IEHQdICFAQ4dUDCAs&uact=5")
	;~ gui_search("https://www.google.com/search?client=firefox-b-1-d&channel=cus2&sxsrf=ALeKk02CuZqxN5n_fDw_33Asi02z9bthxw%3A1590206200889&ei=-J7IXuruNd6tytMP1b6sgAc&q=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&oq=site%3Awww.autohotkey.com%2Fboards%2F+REPLACEME&gs_lcp=CgZwc3ktYWIQAzoECAAQR1CViwlYpK8JYJuyCWgIcAF4AIABTYgBiAqSAQIxOZgBAKABAaoBB2d3cy13aXo&sclient=psy-ab&ved=0ahUKEwjqyuTdi8npAhXelnIEHVUfC3AQ4dUDCAs&uact=5")
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l=")
}

else if(MasterScriptCommands = "amazon "){ ;~ Search Amazon
	gui_search_title = Amazon	
	gui_search("https://www.amazon.com/s?k=REPLACEME&ref=nb_sb_noss_2")
}

else if(MasterScriptCommands = "private "){ ;~ Private Firefox Window
		;   A note on how this works:
	;   The function name "gui_search()" is poorly chosen.
	;   What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
	;   Before the command is Run, the word REPLACEME is replaced by your input.
	;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
	;   So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.	
	gui_search_title = Google Search as Private Window in Firefox
	;~ gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME")
	gui_search("C:\Program Files\Mozilla Firefox\firefox.exe -private-window https://www.google.com/search?safe=off&q=REPLACEME")
}

else if(MasterScriptCommands = "icon search" || MasterScriptCommands = "search icons"){ ;~ Search for Icons
	gui_destroy()
	;~ gui_search("https://www.pngegg.com/en/search?q=REPLACEME")
	gui_search("https://www.deviantart.com/search?q=REPLACEME%20icons")
	gui_search("https://iconscout.com/icons/REPLACEME?price=free")
	gui_search("https://icon-icons.com/search/icons/?filtro=REPLACEME")
	gui_search("https://material.io/resources/icons/?search=REPLACEME&icon=anchor&style=baseline")
	gui_search("https://www.flaticon.com/search?word=REPLACEME&search-type=icons&license=selection&order_by=4&grid=small")
}

else if(MasterScriptCommands = "udemy"){ ;~ Search for Free Udemy Courses
	gui_search_title = Search for Udemy Courses
	gui_search("https://www.google.com/search?sxsrf=ALeKk01lOccrdqCp22gQcH4RUd3zxa3mWw%3A1591452543507&ei=f6PbXr7GHoPj_Aaw_6WgBQ&q=site%3Afreecoursesite.com+puppeteer&oq=site%3Afreecoursesite.com+REPLACEME&gs_lcp=CgZwc3ktYWIQA1DQH1jQH2DpIWgAcAB4AIAB1gGIAeIFkgEFMC4zLjGYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwj-gaHcru3pAhWDMd8KHbB_CVQQ4dUDCAs&uact=5")
}

else if(MasterScriptCommands = "fontawesome" || MasterScriptCommands = "icon search"){ ;~ Search FontAwesome & Other Icons
	gui_search_title = Search for FontAwesome Icons
	gui_search("https://fontawesome.com/icons?d=gallery&q=REPLACEME")
	gui_search("https://iconscout.com/icons/REPLACME?price=free")
	gui_search("https://thenounproject.com/search/?q=REPLACEME")
	
}

else if(MasterScriptCommands = "gifs"){ ;~ Search for Gifs
	gui_destroy()
	gui_search("https://giphy.com/search/REPLACEME")
}

;-------------------------------------------------------------------------------
;;; SEARCH OTHER THINGS ;;;
;-------------------------------------------------------------------------------

else if(MasterScriptCommands = "Facebook "){ ;~ Search Facebook
	gui_search_title = Search Facebook
	gui_search("https://www.facebook.com/search/results.php?q=REPLACEME")	
}

else if(MasterScriptCommands = "tor. "){ ;~ Search Torrent Networks
	gui_search_title = Search Torrent Networks
	gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://rutracker.org/forum/tracker.php?nm=REPLACEME")
}

else if(MasterScriptCommands = "the. "){ ;~ Search Thesaurus
	gui_search_title = Search Thesaurus
	gui_search("https://www.thesaurus.com/browse/REPLACEME?s=t")	
}

else if(MasterScriptCommands = "dic. "){ ;~ Search Dictionary
	gui_search_title = Search Dictionary
	gui_search("https://www.dictionary.com/browse/REPLACEME?s=t")	
}

else if(MasterScriptCommands = "amazon "){ ;~ Amazon
	gui_search_title = Search Amazon
	gui_search("https://www.amazon.com/s?k=REPLACEME&i=tools&ref=nb_sb_noss")	
}

else if(MasterScriptCommands = "Youtube "){ ;~ Search Youtube
	gui_search_title = Search Youtube
	gui_search("https://www.youtube.com/results?search_query=REPLACEME")	
	
}

else if(MasterScriptCommands = "keys"){ ;~ List of Key Modifiers AHK Help
	gui_destroy()
	Run https://www.autohotkey.com/docs/KeyList.htm#Keyboard
}

;-------------------------------------------------------------------------------
;;; LAUNCH WEBSITES AND PROGRAMS ;;;
;-------------------------------------------------------------------------------

else if(MasterScriptCommands = "calendar"){ ;~ Google Calendar
	gui_destroy()
	Run https://www.google.com/calendar
}

else if(MasterScriptCommands = "note"){ ;~ Notepad
	gui_destroy()
	Run Notepad.exe	
}

else if(MasterScriptCommands = "paint" || MasterScriptCommands = "mspaint"){ ;~ Name of Command
	gui_destroy()
	Run "C:\Windows\system32\mspaint.exe"
}

else if(MasterScriptCommands = "steam"){ ;~ Steam
	gui_destroy()
	Run, "C:\Program Files (x86)\Steam\steam.exe"
}

else if(MasterScriptCommands = "extract icons"){ ;~ Extract Icons
	gui_destroy()
	Run, "D:\Program Files (x86)\iconsext\iconsext.exe"
}

else if(MasterScriptCommands = "whats"){ ;~ WhatsAPP
	gui_destroy()
	Toggle_App("WhatsApp", "C:\Users\Dillon\AppData\Local\WhatsApp\WhatsApp.exe")
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// Window Programs  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "calc"){ ;~ Calculator
	gui_destroy()
	DetectHiddenWindows, Off ;~ Have to turn off for Calc to appear
	Toggle_App("Calc", "C:\Windows\System32\calc.exe")
	DetectHiddenWindows, On ;~ Returning to original state
}

;~ 	
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// AHK Scripts  //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "encrypt"){ ;~ Word Encryption
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Encryption Tool\Encryption User Tool.ahk"
}

else if (MasterScriptCommands = "screenclip"){ ;~ Joe Gline's Screen Clipping
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Screen_Clipping_with_OCR\Screen Clipping.ahk"
}

;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "rel" || MasterScriptCommands = "refresh"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	Reload	
}

else if(MasterScriptCommands = "_" || MasterScriptCommands = "master"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	Run, "D:\Users\Dillon\Google Drive\AHK Scripts\_Master Script\_Master Script.ahk" 	
}

else if(MasterScriptCommands = "dir"){ ;~ Directory of Script
	gui_destroy()
	Run, %A_ScriptDir%	
}

else if(MasterScriptCommands = "edit"){ ;~ Edit Script Commands --- WIP
	gui_destroy()
	var:="C:\AHK Scripts\_Master Script\Run\Master Search Box\Includes\UserCommands.ahk"
	WinActivate, AHK Studio
	WinWaitActive
	Send, ^o
	Sleep, 100
	ControlSetText,Edit1,% var, Select File - AHK-Studio.ahk
	ControlSend,Button1,LClick, Select File - AHK-Studio.ahk
}
/*
	else if MasterScriptCommands = host ; Edit host script
	{
		gui_destroy()
		Run, notepad.exe "%A_ScriptFullPath%"
	}
*/

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ ////////////////////////////////////// Folder Directories ///////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////


else if(MasterScriptCommands = "down"){ ;~ Downloads
	gui_destroy()
	Run D:\Users\%A_Username%\Downloads	
}

else if (MasterScriptCommands = "drop" || MasterScriptCommands = "Dropbox"){ ; Dropbox folder (works when it is in the default directory)
	gui_destroy()
	RegRead, Var,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting Dropbox Location
	Run, %Var%
}

else if (MasterScriptCommands = "drive" || MasterScriptCommands = "gdrive"){ ; Google Drive
	gui_destroy()
	;~ RegRead, Var,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting GDrive Location
	;~ Run, %Var%
	Run, D:\Users\%A_Username%\Google Drive
}

else if (MasterScriptCommands = "jxl drive"){ ; Google Drive JXL
	gui_destroy()
	;~ RegRead, Var,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting GDrive Location
	;~ Run, %Var%
	Run, D:\Users\%A_Username%\Google Drive JXL
}

else if (MasterScriptCommands = "recycle" || MasterScriptCommands = "trash"){ ;~ Recycle Bin
	gui_destroy()
	Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}

else if (MasterScriptCommands = "Ebooks" || MasterScriptCommands = "Books"){ ;~ Ebooks
	gui_destroy()
	Run, D:\Users\%A_Username%\Google Drive\Ebooks
}

else if (MasterScriptCommands = "Appdata"){ ;~ Appdata
	gui_destroy()
	Run, C:\Users\%A_Username%\AppData\Roaming
}

else if (MasterScriptCommands = "Film Scores" || MasterScriptCommands = "Filmscores" || MasterScriptCommands = "Scores"){ ;~ Score Collections
	gui_destroy()
	Run, "D:\Users\%A_Username%\Google Drive\Film Scores"
}

else if(MasterScriptCommands = "Scripts"){ ;~ AHK Scripts Folder
	gui_destroy()
	Run, "C:\AHK Scripts"
	
}

else if(MasterScriptCommands = "AHK Tools" || MasterScriptCommands = "Tools"){ ;~ AHK Tools Folder
	gui_destroy()
	Run, "C:\AHK Scripts\Tools"
	
}

else if(MasterScriptCommands = "osc"){ ;~ Open Stage Control
	gui_destroy()
	Run, "C:\Program Files (x86)\Open Stage Control"
}

else if(MasterScriptCommands = "todo"){ ;~ Microsoft's To Do
	gui_destroy()
	Run, "C:\AHK Scripts\WinStoreAppLinks\Microsoft To Do - Shortcut.lnk"
}

else if(MasterScriptCommands = "down" || MasterScriptCommands = "downloads"){ ;~ Downloads Folder
	gui_destroy()
	Run, "D:\Users\%A_Username%\Downloads"
}

else if(MasterScriptCommands = "tchai"){ ;~ Tchaikovsky Music Folder
	gui_destroy()
	Run, "D:\Users\%A_Username%\Google Drive\Film Scores\Classical\Tchaikovsky"
}

else if(MasterScriptCommands = "tv"){ ;~ TV Shows
	gui_destroy()
	Run, "J:\T.V. Shows"
}

else if(MasterScriptCommands = "movies"){ ;~ Movies
	gui_destroy()
	Run, "J:\Movies"
}

else if(MasterScriptCommands = "edu"){ ;~ Education Folder
	gui_destroy()
	Run, "J:\Education"
}

else if(MasterScriptCommands = "pics"){ ;~ Pictures
	gui_destroy()
	Run, "D:\Users\%A_Username%\Pictures"
}

else if(MasterScriptCommands = "icons"){ ;~ Icons Folder
	gui_destroy()
	Run, "D:\Folder Icons"
}

else if(MasterScriptCommands = "atyd"){ ;~ And Then You Die Folder...
	gui_destroy()
	;~ m(Var)
	RegRead, Var,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting Dropbox Location
	Run, %Var%\ATYD
}

else if(MasterScriptCommands = "lib"){ ;~ Script Library Functions
	gui_destroy()
	Run, C:\AHK Studio\Lib
}

else if(MasterScriptCommands = "compositions"){ ;~ Open Compositions Folder
	gui_destroy()
	Run, D:\Users\Dillon\Dropbox\Compositions\Sibelius Files
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
	Gosub, gui_commandlibrary	
}


;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// Run Programs //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "spy"){ ;~ AHK Spy
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AU3_Spy.exe"
	Run, "C:\AHK Scripts\Tools\Simple Spy\SimpleSpy.ahk"
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
	Run,"C:\AHK Scripts\Tools\Title Caplization Check\Title Caplization Check.ahk"
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

else if(MasterScriptCommands = "eye" || MasterScriptCommands = "color"){ ;~ Eyedropper Color
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Eyedropper\eyedropper.exe"
}

else if(MasterScriptCommands = "itunes"){ ;~ Itunes
	gui_destroy()
	Run, "C:\Program Files\iTunes\iTunes.exe"
	Command_Gui({Icon:"Itunes",Background:"#FFFFFF",Title:"iTunes",Color:"#000000"}) ;~ Title | Icon | Background | Color | SleepTimer | Gradient |
}

else if(MasterScriptCommands = "grabby" || MasterScriptCommands = "amt"){ ;~ Grabby / Automate My Task
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Automate My Task\Automate My Task v1.3.ahk"
}

else if(MasterScriptCommands = "winamp"){ ;~ Winamp
	gui_destroy()
	Run, "C:\Program Files (x86)\Winamp\winamp.exe"	
}

else if(MasterScriptCommands = "click spam" || MasterScriptCommands = "spam click"){ ;~ Spam Left Click
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Left Click Spam.ahk"
}

else if(MasterScriptCommands = "piano"){ ;~ Open Kontakt with Sketch Piano
	gui_destroy()
	Run, "I:\Kontakt Channel Sets\Pianos\Sketch Piano_Walker 1955 Concert D - Binaural 1.1.nki"
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////// Commands ////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "convert "){ ;~ Convert Audio or Video files
	gui_destroy()
	global Width,Height,FFMpeg,FFMpegFolder
	FFMpeg:="C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
	FFMpegFolder:="C:\Program Files (x86)\FFmpeg\bin\"
	b:=Clipboard	
	;~ SB_SetText("Ready")
	SplitPath,b,FileName,Dir,Ext,NNE
	m(b)
	m(FileName)
	;~ SB_SetText("Converting: " FileName)
	if(Ext="wav"){
		FileName:=Dir "\" NNE ".mp3"
		if(FileExist(FileName))
			FileDelete,%FileName%
		RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
	}else if(Ext~="i)\b(mov|mp4)\b"){
		FileName:=Dir "\" NNE ".mp4"
		if(FileExist(FileName))
			FileDelete,%FileName%
		Run,"%FFMpeg%" -i "%b%" -s 640x480 "%FileName%",,Hide
	}	
	Return
}

else if(MasterScriptCommands = "Sound"){ ;~ Open Sound Control Panel
	gui_destroy()
	Command_Gui("Sound Control Panel")
	Run c:\windows\system32\control.exe mmsys.cpl,,2
	WinWait, ahk_exe rundll32.exe
	MoveWindowtoCenter("ahk_exe rundll32.exe")
}

else if(MasterScriptCommands = "mixer"){ ;~ Open Volume Mixer
	gui_destroy()
	Run C:\Windows\System32\SndVol.exe
	WinWait, ahk_exe SndVol.exe
	If WinExist("ahk_exe SndVol.exe")  
		WinActivate, ahk_exe SndVol.exe
	WinMove, ahk_exe SndVol.exe,, 825, 690, 1100, 300
}

else if(MasterScriptCommands = "empty"){ ;~ Empty RecycleBin
	gui_destroy()
	Command_Gui({Title:"Empty Recycle Bin",Color:"#0489D8",Icon:"Recyclebin",Background:"White"})
	FileRecycleEmpty
}

else if(MasterScriptCommands = "Short"){ ;~ Shorten URL
	gui_destroy()
	IE:=FixIE(11)
	Gui,Add,ActiveX,vWB w800 h800 VScroll HScroll hwndID,mshtml
	FixIE(IE)
	ComObjError(0)
	WB.Navigate("https://bitly.com/")
	while(WB.ReadyState!=4)
		Sleep,50
	My_Link:=Clipboard
	;~ m(My_Link)
	if(ErrorLevel)
		Return
	;~ Gui,Show
	WB.Document.GetElementByID("shorten_url").Value:=Format("{:L}",My_Link)
	WB.Document.GetElementByID("shorten_btn").Click()
	while (! Element:=WB.Document.GetElementsByTagName("INPUT").item[0].Value) ;Make sure element exists before moving forward
		Sleep, 50
	m(WB.Document.GetElementsByTagName("INPUT").item[0].Value) ;Get Tagname and Array value
	Gui,Destroy
}

else if(MasterScriptCommands = "twitch"){ ;~ Mute/Unmute Twitch Stream
	gui_destroy()
	Focus_Send({Window:"Twitch Stream - VLC media player ahk_class Qt5QWindowIcon",Title:"Mute/Unmute Twitch Stream",Keys:"m",Focus:"1",Icon:"Twitch",Background:"#5A3E85"}) ;~ Focus_Send({}) ;~ Window | Title | Keys | Background | Color | TitleMatchMode | Focus | Icon | Gradient
}

else if(MasterScriptCommands = "y2mp3"){ ;~ Youtube to Mp3
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Youtube Downloader\YouTubeDL.ahk"
	WinWaitActive, YouTubeDL v0.5.1
	Sleep, 500
	ControlClick,Button2,YouTubeDL v0.5.1
	ControlClick,Button8,YouTubeDL v0.5.1
	ControlClick,Button6,YouTubeDL v0.5.1
	Sleep,1000	
	ControlSetText,Edit1,D:\Users\Dillon\Downloads\Youtube Conversions,Browse For Folder
	Sleep,1000
	ControlClick,Button2,Browse For Folder
	Sleep, 100
	ControlClick,Button3,YouTubeDL v0.5.1
	WinMinimize, YouTubeDL v0.5.1
}

else if(MasterScriptCommands = "y2mp4"){ ;~ Youtube to Mp4
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Youtube Downloader\YouTubeDL.ahk"
	WinWaitActive, YouTubeDL v0.5.1
	Sleep, 100
	ControlClick,Button1,YouTubeDL v0.5.1
	ControlClick,Button8,YouTubeDL v0.5.1
	ControlClick,Button6,YouTubeDL v0.5.1
}

else if(MasterScriptCommands = "pastebin" || MasterScriptCommands = "share code"){ ;~ Share AHK Code
	gui_destroy()
	Clipboard:=AHKPastebin(Clipboard,"Dillon",1,0) ;~ 1 will run it in your default browser, 0 doesn't
}

else if(MasterScriptCommands = "ip. " || MasterScriptCommands = "myip"){ ;~ Grab my ip
	gui_destroy()
	var:= ClipBoard
	clipboard:="Public ip is: " GetIP("http://www.netikus.net/show_ip.html") "`n`nPrivate IP is:" A_IPAddress1
	MsgBox 64, IP Address, % Clipboard
	clipboard:= % var
	
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
	WinActivate, ahk_exe midiox.exe
	m("here")
	WinWaitActive, ahk_exe midiox.exe
	If WinActive("ahk_exe midiox.exe")
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
}

else if(MasterScriptCommands = "volume"){ ;~ Volume Defaults for Applications
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Volume Per Application.ahk"
}

else if(MasterScriptCommands = "to ico"|| MasterScriptCommands = ".ico"){ ;~ Convert Image on Clipboard to Ico
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Magick\Convert to ICO.ahk"
}

else if(MasterScriptCommands = "mute"){ ;~ Mute/Unmute Speakers
	gui_destroy()
	WinActivate, ahk_exe TotalMixFX.exe
	WinWaitActive, ahk_exe TotalMixFX.exe
	If WinActive("ahk_exe TotalMixFX.exe"){
		SendInput, {F4}
	}
	Return
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// End of Commands  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
Return