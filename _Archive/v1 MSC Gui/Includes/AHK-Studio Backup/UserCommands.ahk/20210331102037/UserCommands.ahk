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

else if(MasterScriptCommands = "fontawesome"){ ;~ Search FontAwesome & Other Icons
	gui_search_title = Search for FontAwesome Icons
	gui_search("https://fontawesome.com/icons?d=gallery&p=2&q=REPLACEME&m=free")
	
}
else if(MasterScriptCommands = "icon search"){ ;~ Search FontAwesome & Other Icons
	gui_search_title = Search for FontAwesome Icons
	gui_search("https://fontawesome.com/icons?d=gallery&q=REPLACEME")
	gui_search("https://iconscout.com/icons/REPLACME?price=free")
	gui_search("https://thenounproject.com/search/?q=REPLACEME")
	
}

else if(MasterScriptCommands = "gifs"){ ;~ Search for Gifs
	gui_search_title = Search Giphy for Gifs
	gui_search("https://giphy.com/search/REPLACEME")
}

else if(MasterScriptCommands = "album cover" || MasterScriptCommands = "search album cover"){ ;~ Search Album Covers
	gui_search_title = Search for Album Covers
	gui_search("https://www.albumartexchange.com/covers?q=REPLACEME&fltr=ALL&sort=DATE&status=&size=any")
}

;-------------------------------------------------------------------------------
;;; SEARCH OTHER THINGS ;;;
;-------------------------------------------------------------------------------

else if(MasterScriptCommands = "tor. "){ ;~ Search Torrent Networks
	gui_search_title = Search Torrent Networks
	gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://rutracker.org/forum/tracker.php?nm=REPLACEME")
	gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://audioclub.in/?s=REPLACEME")
	gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe https://audioz.download/")
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

else if(MasterScriptCommands = "Youtube " || MasterScriptCommands = "yt "){ ;~ Search Youtube
	gui_search_title = Search Youtube
	gui_search("https://www.youtube.com/results?search_query=REPLACEME")	
	
}

else if(MasterScriptCommands = "keys" || MasterScriptCommands = "hk ahk"){ ;~ List of Key Modifiers AHK Help
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
	;~ Run Notepad++.exe
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

;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if(MasterScriptCommands = "rel" || MasterScriptCommands = "refresh"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	SendInput, {F21} ;~ Reload Script Button
	Reload	
}

else if(MasterScriptCommands = "_" || MasterScriptCommands = "master"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	Run, "C:\AHK Scripts\_Master Script\_Master Script.ahk" 	
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
	Run, "C:\AHK Scripts\Tools\AU3_Spy.exe",,,001
	Run, "C:\AHK Scripts\Tools\Simple Spy\SimpleSpy.ahk",,,002
	WinWaitActive, ahk_pid %001%
	WinMove,ahk_pid %001%,,400,800
	WinWaitActive, 002
	If WinActive(002) {
		WinMove,A,,400,800
	}
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

else if(MasterScriptCommands = "click spam" || MasterScriptCommands = "spam click" || MasterScriptCommands = "mouse click" || MasterScriptCommands = "spam mouse"){ ;~ Spam Left Click
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

else if (MasterScriptCommands = "cubase convert"){ ;~ Convert Audio or Video files
	gui_destroy()
	global Width,Height,FFMpeg,FFMpegFolder
	FFMpeg:="C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
	FFMpegFolder:="C:\Program Files (x86)\FFmpeg\bin\"
	b:=Clipboard	
	;~ SB_SetText("Ready")
	SplitPath,b,FileName,Dir,Ext,NNE
	;~ m(b)
	;~ m(FileName)
	;~ SB_SetText("Converting: " FileName)
	if(Ext="wav"){
		FileName:=Dir "\" NNE ".mp3"		
		RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
	}else if(Ext~="i)\b(mov|mp4)\b"){
		FileName:=Dir "\" NNE """-converted"".mp4"		
		Run,"%FFMpeg%" -i "%b%" -s 640x480 "%FileName%",, ;~ Converting to low quality for use in Cubase etc.
	}
	Return
}
else if(MasterScriptCommands = "convert"){ ;~ Convert to Mp4
	gui_destroy()
	global Width,Height,FFMpeg,FFMpegFolder
	FFMpeg:="C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
	FFMpegFolder:="C:\Program Files (x86)\FFmpeg\bin\"
	b:=Clipboard	
	;~ SB_SetText("Ready")
	SplitPath,b,FileName,Dir,Ext,NNE
	;~ m(b)
	;~ m(FileName)
	;~ SB_SetText("Converting: " FileName)
	if(Ext="wav"){
		FileName:=Dir "\" NNE ".mp3"		
		RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
	}else if(Ext~="i)\b(mov|mp4)\b"){
		FileName:=Dir "\" NNE """-converted"".mp4"		
		Run,"%FFMpeg%" -i "%b%" -s 640x480 "%FileName%",, ;~ Converting to low quality for use in Cubase etc.
	}	
	else if(Ext~="i)\b(mkv)\b"){
		FileName:=Dir "\" NNE """.mp4"		
		Run,"%FFMpeg%" -i "%b%" -codec copy "%FileName%",, ;~ Converting to low quality for use in Cubase etc.
	;~ cmd:= "ffmpeg -i input.mkv -codec copy output.mp4"
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
	Run, "C:\AHK Scripts\_Master Script\Run\UserCommand Run Scripts\Mixer.ahk"
	;Run C:\Windows\System32\SndVol.exe
	;WinWaitActive, ahk_exe SndVol.exe
	;WinMove, ahk_exe SndVol.exe,, 825, 690, 1100, 300
}

else if(MasterScriptCommands = "empty"){ ;~ Empty RecycleBin
	gui_destroy()
	Command_Gui({Title:"Empty Recycle Bin",Color:"#0489D8",Icon:"Recyclebin",Background:"White"})
	FileRecycleEmpty
}

else if(MasterScriptCommands = "Short"){ ;~ Shorten URL
	gui_destroy()
	IE:=FixIE(11)
	Gui, 3: Add,ActiveX,vWB w800 h800 VScroll HScroll hwndID,mshtml
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
	ShortUrl:=WB.Document.GetElementsByTagName("INPUT").item[0].Value
	ClipBoard=%ShortUrl%
	Gui, 3: Destroy
}

else if(MasterScriptCommands = "twitch"){ ;~ Mute/Unmute Twitch Stream
	gui_destroy()
	Focus_Send({Window:"Twitch Stream - VLC media player ahk_class Qt5QWindowIcon",Title:"Mute/Unmute Twitch Stream",Keys:"m",Focus:"1",Icon:"Twitch",Background:"#5A3E85"}) ;~ Focus_Send({}) ;~ Window | Title | Keys | Background | Color | TitleMatchMode | Focus | Icon | Gradient
}

else if(MasterScriptCommands = "y2mp3"){ ;~ Youtube to Mp3
	gui_destroy()
	ydl:= """C:\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe"""Chr(32)
	cmd:= "--extract-audio --audio-format mp3"Chr(32)
	vid:= Chr(34) Clipboard Chr(34) Chr(32)
	dir:= "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
	y2mp3:= ydl cmd vid dir	
	Run, %y2mp3%,,,PID	
	Notify().AddWindow(y2mp3,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP3",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	Run, "D:\Users\Dillon\Downloads\Youtube Downloader"
	/*
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
	*/
}

else if(MasterScriptCommands = "y2mp4"){ ;~ Youtube to Mp4
	gui_destroy()
	;~ cmd:= "--extract-audio --audio-format mp3"Chr(32)
	ydl:= """C:\AHK Scripts\Tools\Youtube Downloader\youtube-dl.exe"""Chr(32)
	vid:= Chr(34) Clipboard Chr(34) Chr(32)
	dir:= "-o " """D:\Users\Dillon\Downloads\Youtube Downloader\"Chr(37)"(title)s."Chr(37)"(ext)s"""
	y2mp3:= ydl vid dir	
	Run, %y2mp3%,,,PID	
	Notify().AddWindow(y2mp4,{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"Converting Video to MP4",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	Run, "D:\Users\Dillon\Downloads\Youtube Downloader"
}

else if(MasterScriptCommands = "pastebin" || MasterScriptCommands = "share code"){ ;~ Share AHK Code
	gui_destroy()
	Clipboard:=AHKPastebin(Clipboard,"Dillon",1,0) ;~ 1 will run it in your default browser, 0 doesn't
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

else if(MasterScriptCommands = "name"){ ;~ Name of Active Window
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Process Name of Active Window.ahk"
}

else if(MasterScriptCommands = "kill vep"){ ;~ Kill Vepro
	gui_destroy()
	Process, Close, Vienna Ensemble Pro.exe
}

else if(MasterScriptCommands = "kill dorico"){ ;~ Kill Dorico
	gui_destroy()
	Notify().AddWindow("Force Quitting Dorico"
		,{Title:"Kill Dorico"
		,Font:"Madness Hyperactive"
		,TitleFont:"Madness Hyperactive"
		,Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\dorico.ico"
		,Animate:"Right,Slide"
		;~ ,Flash:150
		;~ ,FlashColor:"0x00FF00"
		,ShowDelay:100	
		,IconSize:64	
		,TitleSize:14
		,Size:20
		,Radius:26
		,Time:6000
		,Background:"0xFFFFFF"
		,Color:"0x282A2E"
		,TitleColor:"0xFF0000"})
	Process, Close, Dorico3.5.exe
	Process, Close, VSTAudioEngine3.exe
}


else if(MasterScriptCommands = "rec"){ ;~ Record Screen
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AHK Screen Recording\Screen Recording.ahk"
}

else if(MasterScriptCommands = "cfu"){ ;~ Check for Updates
	gui_destroy()
	Run, ms-settings:windowsupdate
}

else if(MasterScriptCommands = "disk"){ ;~ Run Disk Management
	gui_destroy()
	Run, diskmgmt.msc
}

else if(MasterScriptCommands = "device"){ ;~ Run Device Management
	gui_destroy()
	Run, devmgmt.msc
}

else if(MasterScriptCommands = "kill xbox"){ ;~ Kill Vepro
	gui_destroy()
	Process, Close, XboxApp.exe
	Process, Close, GameBar.exe
	Process, Close, GameBarFTServer.exe
	Process, Close, XboxAppServices.exe
}

else if(MasterScriptCommands = "xbox on"){ ;~ Kill Vepro
	gui_destroy()
	RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR, AppCaptureEnabled, 1
}

else if(MasterScriptCommands = "xbox off"){ ;~ Kill Vepro
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

else if(MasterScriptCommands = "cmd"){ ;~ Name of Command
	gui_destroy()
	Run %comspec% /k
}

else if(MasterScriptCommands = "facebook audio"){ ;~ Name of Command
	gui_destroy()
	Run, "https://m.facebook.com/messages/?entrypoint=jewel&no_hist=1 "
}

else if(MasterScriptCommands = "mute"){ ;~ Name of Command
	gui_destroy()
	WinActivate("ahk_exe TotalMixFX.exe")
	Perform_Action({Type:"Mouse",Action:"Left",Actual:"",ClickCount:1,Wait:2,WindowWait:2,Comment:"Mouse Click",Match:1,OffsetX:-59,OffsetY:36,Area:"RME TotalMix FX: Babyface Pro (1) - 48.0k ahk_class Afx:00B20000:b:0001000D:00000006:000703B7",Bits:"UrzAzyN0Au99YGH8YUl9",Ones:53,Zeros:66,Threshold:104,W:17,H:7})	
	/*
		If WinActive("ahk_exe TotalMixFX.exe"){
			Notify().AddWindow("yes",{Animate:"Center",ShowDelay:1000,Icon:300,IconSize:50,Title:"",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
			SendInput, {F4}
		}
		Return
	*/
}

else if(MasterScriptCommands = "dorico"){ ;~ Open Dorico Composition Folder
	gui_destroy()
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
	Run, "C:\Program Files (x86)\Microsoft\Skype for Desktop\Skype.exe"
}
else if(MasterScriptCommands = "website stuff"){ ;~ open folder to webstie stuff
	gui_destroy()
	Run, "D:\Users\Dillon\Desktop\Desktop Items\website stuff"
}
else if(MasterScriptCommands = "photoshop"){ ;~ Adobe Photoshop
	gui_destroy()
	Run, "C:\Program Files\Adobe\Photoshop\Photoshop.exe"
	Notify().AddWindow("Running Adobe Photoshop",{Animate:"Center",ShowDelay:100,Icon:236,IconSize:50,Title:"",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
	Photoshop:= "Adobe Creative Cloud ahk_exe Adobe Desktop Service.exe"
	WinWaitActive, %Photoshop%
	WinActivate, %Photoshop%
	ControlClick,Quit,%Photoshop%,,L,2
}
else if(MasterScriptCommands = "premiere"){ ;~ Adobe Premiere
	gui_destroy()
	Run, "C:\Program Files\Adobe\Adobe Premiere Pro 2021\Adobe Premiere Pro.exe"
	Notify().AddWindow("Running Adobe Premiere",{Animate:"Center",ShowDelay:100,Icon:236,IconSize:50,Title:"",TitleSize:14,Size:12,Time:6000,Background:0x0000FF})
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
else if(MasterScriptCommands = "how to Dorico"){ ;~ Name of Command
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\Dorico How To's.url"
}
else if(MasterScriptCommands = "nyu"){ ;~ NY Unemployment Questions
	gui_destroy()
	Run, "C:\AHK Scripts\_Master Script\Run\Shortcuts\NY Unemployment Questions.url"
}
else if(MasterScriptCommands = "disaster"){ ;~ Name of Command
	gui_destroy()
	Run, "https://covid19relief1.sba.gov/Account/Login?Ticket=d746563b2dc94ecf81d1eee115fbfdff"
}
Return ;~ End of Commands