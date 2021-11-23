; Created by Asger Juul BRunshøj
;~ Adapted by DMDComposer

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.

;~ Chr(32) = a space


;-------------------------------------------------------------------------------
;;; SEARCH GOOGLE ;;;
;-------------------------------------------------------------------------------
if (MasterScriptCommands = "g. " || MasterScriptCommands = "google"){ ;~ Search Google
	gui_search_title = LMGTFY
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
}

else if(MasterScriptCommands = "you "){ ;~ Search Youtube
	gui_search_title = Youtube Search
	gui_search("https://www.youtube.com/results?search_query=REPLACEME&page=&utm_source=opensearch")
}


else if MasterScriptCommands = ahk ; Search Google for AutoHotkey related stuff
{
	gui_search_title = Autohotkey Google Search
	gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l=")
}
else if MasterScriptCommands = l%A_Space% ; Search Google with ImFeelingLucky
{
	gui_search_title = I'm Feeling Lucky
	gui_search("http://www.google.com/search?q=REPLACEME&btnI=Im+Feeling+Lucky")
}
else if MasterScriptCommands = m%A_Space% ; Open more than one URL
{
	gui_search_title = multiple
	gui_search("https://www.google.com/search?&q=REPLACEME")
	gui_search("https://www.bing.com/search?q=REPLACEME")
	gui_search("https://duckduckgo.com/?q=REPLACEME")
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

;-------------------------------------------------------------------------------
;;; LAUNCH WEBSITES AND PROGRAMS ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = / ; Go to subreddit. This is a quick way to navigate to a specific URL.
{
	gui_search_title := "/r/"
	gui_search("https://www.reddit.com/r/REPLACEME")
}
else if MasterScriptCommands = face ; facebook.com
{
	gui_destroy()
	Run www.facebook.com
}
else if MasterScriptCommands = red ; reddit.com
{
	gui_destroy()
	Run www.reddit.com
}
else if MasterScriptCommands = calendar ; Google Calendar
{
	gui_destroy()
	Run https://www.google.com/calendar
}
else if MasterScriptCommands = note ; Notepad
{
	gui_destroy()
	Run Notepad++
}
else if MasterScriptCommands = paint ; MS Paint
{
	gui_destroy()
	Run "C:\Windows\system32\mspaint.exe"
}
else if MasterScriptCommands = maps ; Google Maps focused on the Technical University of Denmark, DTU
{
	gui_destroy()
	Run "https://www.google.com/maps/@55.7833964`,12.5244754`,12z"
}
else if MasterScriptCommands = inbox ; Open google inbox
{
	gui_destroy()
	Run https://inbox.google.com/u/0/
    ; Run https://mail.google.com/mail/u/0/#inbox  ; Maybe you prefer the old gmail
}
else if MasterScriptCommands = mes ; Opens Facebook unread messages
{
	gui_destroy()
	Run https://www.facebook.com/messages?filter=unread&action=recent-messages
}
else if MasterScriptCommands = url ; Open an URL from the clipboard (naive - will try to Run whatever is in the clipboard)
{
	gui_destroy()
	Run %ClipBoard%
}

else if(MasterScriptCommands = "steam"){ ;~ Steam
	gui_destroy()
	Run, "C:\Program Files (x86)\Steam\steam.exe"
}

else if(MasterScriptCommands = "extract icons"){ ;~ Name of Command
	gui_destroy()
	Run, "D:\Program Files (x86)\iconsext\iconsext.exe"
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// Window Programs  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "calc"){ ;~ Calculator
	gui_destroy()
	toggle_app("Calc", "C:\Windows\System32\calc.exe")
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
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
else if(MasterScriptCommands = "reload" || MasterScriptCommands = "refresh"){ ;~ Reload Script
	gui_destroy() ; removes the GUI even when the reload fails
	Reload	
}

else if(MasterScriptCommands = "dir"){ ;~ Directory of Script
	gui_destroy()
	Run, %A_ScriptDir%	
}

else if(MasterScriptCommands = "edit"){ ;~ Edit Script Commands
	gui_destroy()
	WinActivate AHK Studio ahk_class AutoHotkeyGUI
	WinWaitActive
	SendInput, ^o
	Send, %A_ScriptFullPath%
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

else if (MasterScriptCommands = "drop. " || MasterScriptCommands = "Dropbox"){ ; Dropbox folder (works when it is in the default directory)
	gui_destroy()
	RegRead, Var,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting Dropbox Location
	Run, %Var%
}

else if (MasterScriptCommands = "recycle" || MasterScriptCommands = "trash"){ ;~ Recycle Bin
	gui_destroy()
	Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}

else if (MasterScriptCommands = "Ebooks" || MasterScriptCommands = "Books"){ ;~ Ebooks
	gui_destroy()
	Run, D:\Users\%A_Username%\Dropbox\Ebooks
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
}

else if (MasterScriptCommands = "edge"){ ;~ Edge
	gui_destroy()
	Run, microsoft-edge:http://www.google.com/
}

else if (MasterScriptCommands = "ie"){ ;~ Internet Explorer
	gui_destroy()
	Run, iexplore
}

else if(MasterScriptCommands = "cap"){ ;~ Check Title Capilzation
	gui_destroy()
	Run,"C:\AHK Scripts\Tools\Title Capitalization.ahk"	
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

else if(MasterScriptCommands = "grabby"){ ;~ Grabby
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Grabby v1.0.ahk"
}

else if(MasterScriptCommands = "winamp"){ ;~ Winamp
	gui_destroy()
	Run, "C:\Program Files (x86)\Winamp\winamp.exe"	
}

else if(MasterScriptCommands = "click spam" || MasterScriptCommands = "spam click"){ ;~ Spam Left Click
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\Left Click Spam.ahk"
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
		return
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

else if(MasterScriptCommands = "ip. "){ ;~ Grab my ip
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
		return http.ResponseText
	}
}