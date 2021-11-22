﻿; Created by Asger Juul Brunshøj

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.

;-------------------------------------------------------------------------------
;;; SEARCH GOOGLE ;;;
;-------------------------------------------------------------------------------
if MasterScriptCommands = g%A_Space% ; Search Google
{
    gui_search_title = LMGTFY
    gui_search("https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=")
}
else if MasterScriptCommands = a%A_Space% ; Search Google for AutoHotkey related stuff
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
else if MasterScriptCommands = x%A_Space% ; Search Google as Incognito
;   A note on how this works:
;   The function name "gui_search()" is poorly chosen.
;   What you actually specify as the parameter value is a command to run. It does not have to be a URL.
;   Before the command is run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
{
    gui_search_title = Google Search as Incognito
    gui_search("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME")
}


;-------------------------------------------------------------------------------
;;; SEARCH OTHER THINGS ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = f%A_Space% ; Search Facebook
{ 
		gui_search_title = Search Facebook
		gui_search("https://www.facebook.com/search/results.php?q=REPLACEME")
}
else if MasterScriptCommands = yt.%A_Space% ; Search Youtube
{
    gui_search_title = Search Youtube
    gui_search("https://www.youtube.com/results?search_query=REPLACEME")
}
else if MasterScriptCommands = tor.%A_Space% ; Search torrent networks
{
	gui_search_title = Search Torrent Networks
	gui_search("https://rutracker.org/forum/tracker.php?nm=REPLACEME")
}
/*
	else if MasterScriptCommands = kor ; Translate English to Korean
	{
	    gui_search_title = English to Korean
	    gui_search("https://translate.google.com/#en/ko/REPLACEME")
	}
	
*/
else if MasterScriptCommands = the.%A_Space%
{
	gui_search_title = Thesaurus Search
	gui_search("https://www.thesaurus.com/browse/REPLACEME?s=t")	
}

else if MasterScriptCommands = dic.%A_Space%
{
	gui_search_title = Dictionary Search
	gui_search("https://www.dictionary.com/browse/REPLACEME?s=t")	
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
    run www.facebook.com
}
else if MasterScriptCommands = red ; reddit.com
{
    gui_destroy()
    run www.reddit.com
}
else if MasterScriptCommands = cal ; Google Calendar
{
    gui_destroy()
    run https://www.google.com/calendar
}
else if MasterScriptCommands = note ; Notepad
{
    gui_destroy()
    Run Notepad
}
else if MasterScriptCommands = paint ; MS Paint
{
    gui_destroy()
    run "C:\Windows\system32\mspaint.exe"
}
else if MasterScriptCommands = maps ; Google Maps focused on the Technical University of Denmark, DTU
{
    gui_destroy()
    run "https://www.google.com/maps/@55.7833964`,12.5244754`,12z"
}
else if MasterScriptCommands = inbox ; Open google inbox
{
    gui_destroy()
    run https://inbox.google.com/u/0/
    ; run https://mail.google.com/mail/u/0/#inbox  ; Maybe you prefer the old gmail
}
else if MasterScriptCommands = mes ; Opens Facebook unread messages
{
    gui_destroy()
    run https://www.facebook.com/messages?filter=unread&action=recent-messages
}
else if MasterScriptCommands = url ; Open an URL from the clipboard (naive - will try to run whatever is in the clipboard)
{
    gui_destroy()
    run %ClipBoard%
}


;-------------------------------------------------------------------------------
;;; INTERACT WITH THIS AHK SCRIPT ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = rel ; Reload this script
{
    gui_destroy() ; removes the GUI even when the reload fails
    Reload
}
else if MasterScriptCommands = dir ; Open the directory for this script
{
    gui_destroy()
    Run, %A_ScriptDir%
}
else if MasterScriptCommands = host ; Edit host script
{
    gui_destroy()
    run, notepad.exe "%A_ScriptFullPath%"
}
else if MasterScriptCommands = user ; Edit GUI user commands
{
    gui_destroy()
    run, notepad.exe "%A_ScriptDir%\GUI\UserCommands.ahk"
}


;-------------------------------------------------------------------------------
;;; TYPE RAW TEXT ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = @ ; Email address
{
    gui_destroy()
    Send, my_email_address@gmail.com
}
else if MasterScriptCommands = name ; My name
{
    gui_destroy()
    Send, My Full Name
}
else if MasterScriptCommands = phone ; My phone number
{
    gui_destroy()
    SendRaw, +45-12345678
}
else if MasterScriptCommands = int ; LaTeX integral
{
    gui_destroy()
    SendRaw, \int_0^1  \; \mathrm{d}x\,
}
else if MasterScriptCommands = logo ; ¯\_(ツ)_/¯
{
    gui_destroy()
    Send ¯\_(ツ)_/¯
}
else if MasterScriptCommands = clip ; Paste clipboard content without formatting
{
    gui_destroy()
    SendRaw, %ClipBoard%
}


;-------------------------------------------------------------------------------
;;; OPEN FOLDERS ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = down ; Downloads
{
    gui_destroy()
    run C:\Users\%A_Username%\Downloads
}
else if MasterScriptCommands = drop ; Dropbox folder (works when it is in the default directory)
{
    gui_destroy()
    run, C:\Users\%A_Username%\Dropbox\
}
else if MasterScriptCommands = rec ; Recycle Bin
{
    gui_destroy()
    Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}


;-------------------------------------------------------------------------------
;;; MISCELLANEOUS ;;;
;-------------------------------------------------------------------------------
else if MasterScriptCommands = ping ; Ping Google
{
    gui_destroy()
    Run, cmd /K "ping www.google.com"
}
else if MasterScriptCommands = hosts ; Open hosts file in Notepad
{
    gui_destroy()
    Run notepad.exe C:\Windows\System32\drivers\etc\hosts
}
else if MasterScriptCommands = date ; What is the date?
{
    gui_destroy()
    FormatTime, date,, LongDate
    MsgBox %date%
    date =
}
else if MasterScriptCommands = week ; Which week is it?
{
    gui_destroy()
    FormatTime, weeknumber,, YWeek
    StringTrimLeft, weeknumbertrimmed, weeknumber, 4
    if (weeknumbertrimmed = 53)
        weeknumbertrimmed := 1
    MsgBox It is currently week %weeknumbertrimmed%
    weeknumber =
    weeknumbertrimmed =
}
else if MasterScriptCommands = ? ; Tooltip with list of commands
{
    GuiControl,, MasterScriptCommands, ; Clear the input box
    Gosub, gui_commandlibrary
}
