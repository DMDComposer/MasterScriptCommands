; Created by Asger Juul BrunshÃ¸j

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

SetCapsLockState, AlwaysOff

; #InstallKeybdHook

;-------------------------------------------------------
; AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS
; Scripts being included need to have their auto execute
; section in a function or subroutine which is then
; executed below.
;-------------------------------------------------------
Gosub, gui_autoexecute
;-------------------------------------------------------
; END AUTO EXECUTE SECTION
return
;-------------------------------------------------------

; Load the GUI code
; Created by Asger Juul BrunshÃ¸j

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in Â¯\_(ãƒ„)_/Â¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

#SingleInstance, Force ;Limit one running version of this script
;~ #Warn ; Enable warnings to assist with detecting common errors.
#NoEnv ;Avoids checking empty variables to see if they are environment variables
#KeyHistory 10 ;Sets the maximum number of keyboard and mouse events displayed
#MaxThreads 5 ;Sets the maximum number of simultaneous threads.
;~ #MaxMem 4095 ;#MaxMem Megabytes
A_Enter:="r'n" ;Create my own Line break variable
A_Return:="r'n" ;Create my own line break variable
;~ DetectHiddenWindows, On ;ensure can find hidden windows
ListLines On ;on helps debug a script-this is already on by default
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetBatchlines -1 ;run at maximum CPU utilization
SetTitleMatchMode 2 ;Sets the matching behavior of the WinTitle parameter in commands such as WinWait- 2 is match anywhere
SetTitleMatchMode Fast ; This is the default behavior. Performance may be substantially better than Slow, but certain types of controls are not detected. For instance, text is typically detected within Static and Button controls, but not Edit controls, unless they are owned by the script.
;~ SetFormat, IntegerFast, d
;~ SetFormat, FloatFast , .2
SetKeyDelay, -1, -1, -1 ;Sets the delay that will occur after each keystroke sent by Send and ControlSend.
SetMouseDelay, -1 ;Sets the delay that will occur after each mouse movement or click.
SetWinDelay, 0 ;Sets the delay that will occur after each windowing command, such as WinActivate
SetControlDelay, Â© ;Sets the delay that will occur after each control -modifying command.
SetDefaultMouseSpeed, 0 ;Sets the mouse speed that will be used if unspecified in Click and MouseMove/ClLick/Drag.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;-------------------------------------------------------------------------------
; AUTO EXECUTE
;-------------------------------------------------------------------------------
gui_autoexecute:
    ; Tomorrow Night Color Definitions:
cBackground := "c" . "1d1f21"
cCurrentLine := "c" . "282a2e"
cSelection := "c" . "373b41"
cForeground := "c" . "c5c8c6"
cComment := "c" . "969896"
cRed := "c" . "cc6666"
cOrange := "c" . "de935f"
cYellow := "c" . "f0c674"
cGreen := "c" . "b5bd68"
cAqua := "c" . "8abeb7"
cBlue := "c" . "81a2be"
cPurple := "c" . "b294bb"

gui_control_options := "xm w220 " . cForeground . " -E0x200"
    ; -E0x200 removes border around Edit controls

    ; Initialize variable to keep track of the state of the GUI
gui_state = closed

    ; Initialize search_urls as a variable set to zero
search_urls:= 0
command_inputs:= 0
return

;-------------------------------------------------------------------------------
; LAUNCH GUI
;-------------------------------------------------------------------------------
RAlt::
gui_spawn:
if gui_state != closed
{
        ; If the GUI is already open, close it.
        gui_destroy()
        return
    }

    gui_state = main

    Gui, Margin, 16, 16
    Gui, Color, 1d1f21, 282a2e
    Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
    Gui, Font, s11, Segoe UI
    Gui, Add, Text, %gui_control_options% vgui_main_title, Master Script Commands ;~Â¯\_(ãƒ„)_/Â¯
    Gui, Font, s10, Segoe UI
    Gui, Add, Edit, %gui_control_options% vMasterScriptCommands gFindus
    Gui, Show,, myGUI
    return

;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
;-------------------------------------------------------------------------------
; Automatically triggered on Escape key:
GuiEscape:
    gui_destroy()
    return

; The callback function when the text changes in the input field.
Findus:
    Gui, Submit, NoHide
    ; Created by Asger Juul BRunshÃ¸j
;~ Adapted by DMDComposer

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in Â¯\_(ãƒ„)_/Â¯ that wouldn't work otherwise.
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
else if MasterScriptCommands = x%A_Space% ; Search Google as Incognito
;   A note on how this works:
;   The function name "gui_search()" is poorly chosen.
;   What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
;   Before the command is Run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
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
	gui_search_title = Search Thesaurus
	gui_search("https://www.thesaurus.com/browse/REPLACEME?s=t")	
}

else if MasterScriptCommands = dic.%A_Space%
{
	gui_search_title = Search Dictionary
	gui_search("https://www.dictionary.com/browse/REPLACEME?s=t")	
}

else if MasterScriptCommands = amazon
{
	gui_search_title = Search Amazon
	gui_search("https://www.amazon.com/s?k=REPLACEME&i=tools&ref=nb_sb_noss")	
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
    Run Notepad
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


;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// Window Programs  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "calc"){ ;~ Calculator
	gui_destroy()
	Run, Calc.exe
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
    Run, notepad.exe "%A_ScriptFullPath%"
}
else if MasterScriptCommands = user ; Edit GUI user commands
{
    gui_destroy()
    Run, notepad.exe "%A_ScriptDir%\GUI\UserCommands.ahk"
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
else if MasterScriptCommands = logo ; Â¯\_(ãƒ„)_/Â¯
{
    gui_destroy()
    Send Â¯\_(ãƒ„)_/Â¯
}
else if MasterScriptCommands = clip ; Paste clipboard content without formatting
{
    gui_destroy()
    SendRaw, %ClipBoard%
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ ////////////////////////////////////// Folder Directories ///////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////


else if MasterScriptCommands = down%A_Space% ; Downloads
{
    gui_destroy()
    Run C:\Users\%A_Username%\Downloads
}

else if (MasterScriptCommands = "drop. " || MasterScriptCommands = "Dropbox"){ ; Dropbox folder (works when it is in the default directory)
    gui_destroy()
    Run, C:\Users\%A_Username%\Dropbox\
}

else if (MasterScriptCommands = "recycle. " || MasterScriptCommands = "trash"){ ;~ Recycle Bin
    gui_destroy()
    Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}

else if (MasterScriptCommands = "Ebooks. " || MasterScriptCommands = "Books. "){ ;~ Ebooks
	gui_destroy()
	Run, C:\Users\Dillon\Dropbox\Ebooks
}

else if (MasterScriptCommands = "Appdata" || MasterScriptCommands = "Books. "){ ;~ Ebooks
	gui_destroy()
	Run, C:\Users\Dillon\AppData\Roaming
}

else if (MasterScriptCommands = "Film Scores" || MasterScriptCommands = "Filmscores"){ ;~ Name of Command
	gui_destroy()
	Run, "D:\Users\Dillon\Google Drive\Film Scores"
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


;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// Run Programs //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "spy."){ ;~ AHK Spy
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AU3_Spy.exe"
}

else if (MasterScriptCommands = "edge."){ ;~ Edge
	gui_destroy()
	Run, microsoft-edge:http://www.google.com/
}

else if (MasterScriptCommands = "ie."){ ;~ Internet Explorer
	gui_destroy()
	Run, iexplore
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////// Commands ////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if (MasterScriptCommands = "convert "){ ;~ Convert Audio or Video files
	gui_CI_title = Convert Audio | Video
	Gui_Command_Input("REPLACEME")
	m(command_final_input)
	/*
		FFMpeg:="C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
		FFMpegFolder:="C:\Program Files (x86)\FFmpeg\bin\"
		global Width,Height,FFMpeg,FFMpegFolder
		Gui,Add,Edit,vWidth Number w300,640
		Gui,Add,Edit,vHeight Number w300,480
		Gui,Add,StatusBar
		SB_SetText("Ready")
		Gui,Show
		Return
		GuiClose:
		ExitApp
		Return
		GuiDropFiles(HWND,Files){
			Gui,Submit,Nohide
			for a,b in Files{
				SplitPath,b,FileName,Dir,Ext,NNE
				SB_SetText("Converting: " FileName)
				if(Ext="wav"){
					FileName:=Dir "\" NNE ".mp3"
					if(FileExist(FileName))
						FileDelete,%FileName%
					RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
				}else if(Ext~="i)\b(mov|mp4)\b"){
					FileName:=Dir "\" NNE ".mp4"
					if(FileExist(FileName))
						FileDelete,%FileName%
					Run,"%FFMpeg%" -i "%b%" -s %Width%x%Height% "%FileName%",,Hide
				}
			}
			SB_SetText("Done")
		}
	*/
}
    return

;
; gui_destroy: Destroy the GUI after use.
;
#WinActivateForce
gui_destroy() {
    global gui_state
    global gui_search_title

    gui_state = closed
    ; Forget search title variable so the next search does not re-use it
    ; in case the next search does not set its own:
    gui_search_title =

    ; Clear the tooltip
    Gosub, gui_tooltip_clear

    ; Hide GUI
    Gui, Destroy

    ; Bring focus back to another window found on the desktop
    WinActivate
}

gui_change_title(message,color = "") {
    ; If parameter color is omitted, the message is assumed to be an error
    ; message, and given the color red.
    If color =
    {
        global cRed
        color := cRed
    }
    GuiControl,, gui_main_title, %message%
    Gui, Font, s11 %color%
    GuiControl, Font, gui_main_title
    Gui, Font, s10 cffffff ; reset
}

;-------------------------------------------------------------------------------
; SEARCH ENGINES
;-------------------------------------------------------------------------------
;
; gui_search_add_elements: Add GUI controls to allow typing of a search query.
;
gui_search_add_elements:
    Gui, Add, Text, %gui_control_options% %cYellow%, %gui_search_title%
    Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
    Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
    GuiControl, Disable, MasterScriptCommands
    Gui, Show, AutoSize
    return

gui_search(url) {
    global
    if gui_state != search
    {
        gui_state = search
        ; if gui_state is "main", then we are coming from the main window and
        ; GUI elements for the search field have not yet been added.
        Gosub, gui_search_add_elements
    }

    ; Assign the url to a variable.
    ; The variables will have names search_url1, search_url2, ...

    search_urls:= search_urls + 1
    search_url%search_urls% := url
}

gui_SearchEnter:
    Gui, Submit
    gui_destroy()
    query_safe:= uriEncode(gui_SearchEdit)
    Loop, %search_urls%
    {
        StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
        run %search_final_url%
    }
    search_urls := 0
    return
    
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ////////////////////////////////////////                /////////////////////////////////////////
;~ //////////////////////////////////////// Command Engine /////////////////////////////////////////
;~ ////////////////////////////////////////                /////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

; gui_command_Input: Add GUI controls to allow typing of a search query.
;
gui_add_command_input:
    Gui, Add, Text, %gui_control_options% %cYellow%, %gui_CI_title%
    Gui, Add, Edit, %gui_control_options% %cYellow% vgui_CI_Edit -WantReturn
    Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_CI_Enter ; hidden button
    GuiControl, Disable, MasterScriptCommands
    Gui, Show, AutoSize
    return

Gui_Command_Input(CI) {
	global
	if gui_state != search
	{
		gui_state = search
        ; if gui_state is "main", then we are coming from the main window and
        ; GUI elements for the search field have not yet been added.
		Gosub, gui_add_command_input
	}
	
    ; Assign the command to a variable.
    ; The variables will have names command_input1, command_input2, ...
	
	command_inputs:= command_inputs + 1
	command_input%command_inputs% := CI
}

gui_CI_Enter:
    Gui, Submit
    gui_destroy()
    query_safe:= uriEncode(gui_CI_Edit)
    Loop, %command_inputs%
	{
		StringReplace, command_final_input, command_input%A_Index%, REPLACEME, %query_safe%		
	}
command_inputs:= 0
return

;-------------------------------------------------------------------------------
; TOOLTIP
; The tooltip shows all defined commands, along with a description of what
; each command does. It gets the description from the comments in UserCommands.ahk.
; The code was improved and fixed for Windows 10 with the help of schmimae.
;-------------------------------------------------------------------------------
gui_tooltip_clear:
ToolTip
return

gui_commandlibrary:
    ; hidden GUI used to pass font options to tooltip:
CoordMode, Tooltip, Screen ; To make sure the tooltip coordinates is displayed according to the screen and not active window
Gui, 2:Font,s10, Lucida Console
Gui, 2:Add, Text, HwndhwndStatic

tooltiptext =
maxpadding = 0
StringCaseSense, Off ; Matching to both if/If in the IfInString command below
Loop, read, %A_ScriptDir%/GUI/UserCommands.ahk
{
        ; search for the string If MasterScriptCommands =, but search for each word individually because spacing between words might not be consistent. (might be improved with regex)
        If Substr(A_LoopReadLine, 1, 1) != ";" ; Do not display commented commands
        {
            If A_LoopReadLine contains if
            {
                IfInString, A_LoopReadLine, MasterScriptCommands
                    IfInString, A_LoopReadLine, =
                    {
                        StringGetPos, setpos, A_LoopReadLine,=
                        StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 ; trim everything that comes before the = sign
                        StringReplace, trimmed, trimmed, `%A_Space`%,{space}, All
                        tooltiptext .= trimmed
                        tooltiptext .= "`n"

                        ; The following is used to correct padding:
                        StringGetPos, commentpos, trimmed,`;
                        if (maxpadding < commentpos)
                            maxpadding := commentpos
                    }
            }
        }
    }
    tooltiptextpadded =
    Loop, Parse, tooltiptext,`n
    {
        line = %A_LoopField%
        StringGetPos, commentpos, line, `;
        spaces_to_insert := maxpadding - commentpos
        Loop, %spaces_to_insert%
        {
            StringReplace, line, line,`;,%A_Space%`;
        }
        tooltiptextpadded .= line
        tooltiptextpadded .= "`n"
    }
    Sort, tooltiptextpadded
    ToolTip %tooltiptextpadded%, 3, 3, 1
    return


; General settings
m(x*){
	static list:={btn:{oc:1,ari:2,ync:3,yn:4,rc:5,ctc:6},ico:{"x":16,"?":32,"!":48,"i":64}}
	list.title:="AHK Studio",list.def:=0,list.time:=0,value:=0
	for a,b in x
		obj:=StrSplit(b,":"),(vv:=List[obj.1,obj.2])?(value+=vv):(list[obj.1]!="")?(List[obj.1]:=obj.2):txt.=b "`n"
	MsgBox,% (value+262144+(list.def?(list.def-1)*256:0)),% list.title,%txt%,% list.time
	for a,b in {OK:value?"OK":"",Yes:"YES",No:"NO",Cancel:"CANCEL",Retry:"RETRY"}
		IfMsgBox,%a%
			return b
}

;~ User Commands
; Created by Asger Juul BRunshÃ¸j
;~ Adapted by DMDComposer

; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in Â¯\_(ãƒ„)_/Â¯ that wouldn't work otherwise.
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
else if MasterScriptCommands = x%A_Space% ; Search Google as Incognito
;   A note on how this works:
;   The function name "gui_search()" is poorly chosen.
;   What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
;   Before the command is Run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
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
	gui_search_title = Search Thesaurus
	gui_search("https://www.thesaurus.com/browse/REPLACEME?s=t")	
}

else if MasterScriptCommands = dic.%A_Space%
{
	gui_search_title = Search Dictionary
	gui_search("https://www.dictionary.com/browse/REPLACEME?s=t")	
}

else if MasterScriptCommands = amazon
{
	gui_search_title = Search Amazon
	gui_search("https://www.amazon.com/s?k=REPLACEME&i=tools&ref=nb_sb_noss")	
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
    Run Notepad
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


;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////// Window Programs  ////////////////////////////////////////
;~ ///////////////////////////////////////                  ////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "calc"){ ;~ Calculator
	gui_destroy()
	Run, Calc.exe
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
    Run, notepad.exe "%A_ScriptFullPath%"
}
else if MasterScriptCommands = user ; Edit GUI user commands
{
    gui_destroy()
    Run, notepad.exe "%A_ScriptDir%\GUI\UserCommands.ahk"
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
else if MasterScriptCommands = logo ; Â¯\_(ãƒ„)_/Â¯
{
    gui_destroy()
    Send Â¯\_(ãƒ„)_/Â¯
}
else if MasterScriptCommands = clip ; Paste clipboard content without formatting
{
    gui_destroy()
    SendRaw, %ClipBoard%
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ ////////////////////////////////////// Folder Directories ///////////////////////////////////////
;~ //////////////////////////////////////                    ///////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////


else if MasterScriptCommands = down%A_Space% ; Downloads
{
    gui_destroy()
    Run C:\Users\%A_Username%\Downloads
}

else if (MasterScriptCommands = "drop. " || MasterScriptCommands = "Dropbox"){ ; Dropbox folder (works when it is in the default directory)
    gui_destroy()
    Run, C:\Users\%A_Username%\Dropbox\
}

else if (MasterScriptCommands = "recycle. " || MasterScriptCommands = "trash"){ ;~ Recycle Bin
    gui_destroy()
    Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}

else if (MasterScriptCommands = "Ebooks. " || MasterScriptCommands = "Books. "){ ;~ Ebooks
	gui_destroy()
	Run, C:\Users\Dillon\Dropbox\Ebooks
}

else if (MasterScriptCommands = "Appdata" || MasterScriptCommands = "Books. "){ ;~ Ebooks
	gui_destroy()
	Run, C:\Users\Dillon\AppData\Roaming
}

else if (MasterScriptCommands = "Film Scores" || MasterScriptCommands = "Filmscores"){ ;~ Name of Command
	gui_destroy()
	Run, "D:\Users\Dillon\Google Drive\Film Scores"
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


;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ ///////////////////////////////////////// Run Programs //////////////////////////////////////////
;~ /////////////////////////////////////////              //////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

else if (MasterScriptCommands = "spy."){ ;~ AHK Spy
	gui_destroy()
	Run, "C:\AHK Scripts\Tools\AU3_Spy.exe"
}

else if (MasterScriptCommands = "edge."){ ;~ Edge
	gui_destroy()
	Run, microsoft-edge:http://www.google.com/
}

else if (MasterScriptCommands = "ie."){ ;~ Internet Explorer
	gui_destroy()
	Run, iexplore
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////// Commands ////////////////////////////////////////////
;~ ///////////////////////////////////////////          ////////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
else if (MasterScriptCommands = "convert "){ ;~ Convert Audio or Video files
	gui_CI_title = Convert Audio | Video
	Gui_Command_Input("REPLACEME")
	m(command_final_input)
	/*
		FFMpeg:="C:\Program Files (x86)\FFmpeg\bin\ffmpeg.exe"
		FFMpegFolder:="C:\Program Files (x86)\FFmpeg\bin\"
		global Width,Height,FFMpeg,FFMpegFolder
		Gui,Add,Edit,vWidth Number w300,640
		Gui,Add,Edit,vHeight Number w300,480
		Gui,Add,StatusBar
		SB_SetText("Ready")
		Gui,Show
		Return
		GuiClose:
		ExitApp
		Return
		GuiDropFiles(HWND,Files){
			Gui,Submit,Nohide
			for a,b in Files{
				SplitPath,b,FileName,Dir,Ext,NNE
				SB_SetText("Converting: " FileName)
				if(Ext="wav"){
					FileName:=Dir "\" NNE ".mp3"
					if(FileExist(FileName))
						FileDelete,%FileName%
					RunWait,"%FFMpeg%" -i "%b%" "%FileName%",,Hide
				}else if(Ext~="i)\b(mov|mp4)\b"){
					FileName:=Dir "\" NNE ".mp4"
					if(FileExist(FileName))
						FileDelete,%FileName%
					Run,"%FFMpeg%" -i "%b%" -s %Width%x%Height% "%FileName%",,Hide
				}
			}
			SB_SetText("Done")
		}
	*/
}
