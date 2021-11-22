; Created by Asger Juul Brunshøj https://github.com/plul/Public-AutoHotKey-Scripts
;~ Adapted by DMDComposer

#Include <Default_Settings>

Menu, Tray, Icon, % A_ScriptDir "\Icon.ico", 1 ;~ Set Icon of Script in Taskbar
;~ Menu, Tray, NoIcon

if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}

TmpDir:= A_ScriptDir "\tmpscrpts"

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
Return
;-------------------------------------------------------

; Load the GUI code ;*[Master Search Box]
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

gui_control_options := "xm w220 " . cForeground . " -E0x200" 	; -E0x200 removes border around Edit controls
gui_state = closed     ; Initialize variable to keep track of the state of the GUI

search_urls:= 0     ; Initialize search_urls as a variable set to zero
Return

;-------------------------------------------------------------------------------
; LAUNCH GUI
;-------------------------------------------------------------------------------
RAlt::
gui_spawn:
WinGetActiveTitle, Active_Title
if gui_state != closed
{
	   ; If the GUI is already open, close it.
	gui_destroy()
	Return
}

gui_state = main

Icon:="C:\Program Files\Steinberg\Dorico3.5\Dorico3.5.exe, 1"

Gui, Margin, 16, 16
Gui, Color, 1d1f21, 282a2e
Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
if((Ico:=StrSplit(Info.Icon,",")).1)
	Gui,Add,Picture,% (Info.IconSize?"w" Info.IconSize " h" Info.IconSize:""),% "HBITMAP:" LoadPicture(Foo:=(Ico.1+0?"Shell32.dll":Ico.1),Foo1:="Icon" (Ico.2!=""?Ico.2:Info.Icon)"GDI+ " (Info.IconSize?"w" Info.IconSize " h" Info.IconSize:""),2)
Gui, Font, s11, Segoe UI
Gui, Add, Text, %gui_control_options% vgui_main_title +Center, Master Script Commands
Gui, Font, s10, Segoe UI
Gui, Add, Edit, %gui_control_options% vMasterScriptCommands gFindus
Gui, Show,, myGUI
Return

;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
;-------------------------------------------------------------------------------
; Automatically triggered on Escape key:
GuiEscape:
gui_destroy()
search_urls := 0
Return

; The callback function when the text changes in the input field.
Findus:
Gui, Submit, NoHide
#Include %A_ScriptDir%\Includes\UserCommands.ahk
Return


;~ gui_destroy: Destroy the GUI after use.

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
	WinActivate % Active_Title
}

gui_change_title(message,color = "") {
    ; If parameter color is omitted, the message is assumed to be an error
    ; message, and given the color red.
	If color =
	{
		global cRed
		color:= cRed
	}	
	Color:= StrReplace(Color, "#", "c") ;~ Replace # with c to function with GUI
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
;~ Notify Variables has to be here because of the sequence order how the gui search works.
Title:=RegExReplace(search_final_url, "s).*?(\d{12}).*?(?=\d{12}|$)", "$1`r`n")	
Font:="Segoe UI"
TitleFont:="Segoe UI"
Icon:="C:\Program Files\AutoHotkey\AutoHotkey.exe, 2" ;~  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
Animate:="Right,Slide" ;~ Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
ShowDelay:=100	
IconSize:=64	
TitleSize:=14
Size:=20
Radius:=26
Time:=2500
Background:="0x1d1f21"
Color:="0xFFFFFF"	
TitleColor:="0x00FF00"
Gui, Add, Text, %gui_control_options% %cYellow% +Center, %gui_search_title%
Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
GuiControl, Disable, MasterScriptCommands
Gui, Show, AutoSize
Return

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
	Run % search_final_url
	Notify().AddWindow(gui_SearchEdit ;~ Remove "" if want to use a variable, NO percents!
		,{Title:Title	
		,Font:Font
		,TitleFont:TitleFont
		,Icon:Icon ;~  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
		,Animate:Animate ;~ Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
		,ShowDelay:ShowDelay	
		,IconSize:IconSize	
		,TitleSize:TitleSize
		,Size:Size
		,Radius:Radius
		,Time:Time
		,Background:Background
		,Color:Color
		;~ ,Flash:150
		;~ ,FlashColor:"0x00FF00"
		;~ ,Progress: ;~ Progress: Adds a progress bar eg. {Progress:10} ;Starts with the progress set to 10%
		;~ ,Hide: ;~ Comma Separated List of Directions to Hide the Notification eg. {Hide:"Left,Top"}	
		;~ ,Sound: ;~ Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}
		;~ ,Buttons: ;~ Comma Delimited list of names for buttons eg. {Buttons:"One,Two,Three"}	
		,TitleColor:TitleColor})
}
/*
	Notify().AddWindow(gui_SearchEdit ;~ Remove "" if want to use a variable, NO percents!
			,{Title:"Searching For:"
			,Font:"Segoe UI"
			,TitleFont:"Segoe UI"
			,Icon:"C:\Program Files\AutoHotkey\AutoHotkey.exe, 2" ;~  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
			,Animate:"Right,Slide" ;~ Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
			,ShowDelay:100	
			,IconSize:64	
			,TitleSize:14
			,Size:20
			,Radius:26
			,Time:2500
			,Background:"0x1d1f21"
			,Color:"0xFFFFFF"	
			;~ ,Flash:150
			;~ ,FlashColor:"0x00FF00"
			;~ ,Progress: ;~ Progress: Adds a progress bar eg. {Progress:10} ;Starts with the progress set to 10%
			;~ ,Hide: ;~ Comma Separated List of Directions to Hide the Notification eg. {Hide:"Left,Top"}	
			;~ ,Sound: ;~ Plays either a beep if the item is an integer or the sound file if it exists eg. {Sound:500}
			;~ ,Buttons: ;~ Comma Delimited list of names for buttons eg. {Buttons:"One,Two,Three"}	
			,TitleColor:"0x00FF00"})
*/
search_urls := 0
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ////////////////////////////////////////                /////////////////////////////////////////
;~ //////////////////////////////////////// Command Engine /////////////////////////////////////////
;~ ////////////////////////////////////////                /////////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

; gui_command_Input: Add GUI controls to allow typing of a search query.

gui_add_command_input:
Gui, Add, Text, %gui_control_options% %cYellow%, %gui_CI_title%
Gui, Add, Edit, %gui_control_options% %cYellow% vgui_CI_Edit -WantReturn
Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_CI_Enter ; hidden button
GuiControl, Disable, MasterScriptCommands
Gui, Show, AutoSize
Return

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
	StringReplace, command_final_input, command_input%A_Index%, ReplaceMe, %query_safe%	
}
command_inputs:= 0
Return

;-------------------------------------------------------------------------------
; TOOLTIP
; The tooltip shows all defined commands, along with a description of what
; each command does. It gets the description from the comments in UserCommands.ahk.
; The code was improved and fixed for Windows 10 with the help of schmimae.
;-------------------------------------------------------------------------------
gui_tooltip_clear:
ToolTip
Return

gui_commandlibrary:
    ; hidden GUI used to pass font options to tooltip:
CoordMode, Tooltip, Screen ; To make sure the tooltip coordinates is displayed according to the screen and not active window
Gui, 2:Font,s10, Lucida Console
Gui, 2:Add, Text, HwndhwndStatic

tooltiptext =
maxpadding = 0
StringCaseSense, Off ; Matching to both if/If in the IfInString command below
Loop, read, %A_ScriptDir%/Includes/UserCommands.ahk
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
Return

RunReload:
Gosub, RunFile
Run, %A_AhkPath% "Includes\MSC_Restart.ahk"
ExitApp
Sleep 1000
Return

; Create restart file
RunFile:
FileDelete, %TmpDir%\restarttmp.ahk
While FileExist(TmpDir "\restarttmp.ahk")
	Sleep 100
if A_IsAdmin
	FileAppend, % "Run, *RunAs " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ; reload with command line parameters
else
	FileAppend, % "Run, " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ; reload with command line parameters
Sleep 100
Return

; General settings
#Include %A_ScriptDir%\Includes\Miscellaneous.ahk

;~ User Commands
;~ #Include %A_ScriptDir%\Includes\UserCommands.ahk
Return