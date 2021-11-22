;~ Created by Asger Juul Brunshøj https://github.com/plul/Public-AutoHotKey-Scripts
;~ Heavily Adapted by DMDComposer

#Include <Default_Settings>

Menu, Tray, Icon, % A_ScriptDir "\Icon.ico", 1              ;~ Set Icon of Script in Taskbar

if (! A_IsAdmin){                                           ;~ http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"                        ;~ Requires v1.0.92.01+
	ExitApp
}

;~ Variables for Icons, Colors and Paths
#Include Includes\MSC_Variables.ahk
#Include Includes\MSC_Colors.ahk

Notify().AddWindow("Reloaded Master Script Commands", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:Icon_MSCDefault ",1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})

;~ AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS
Gosub, gui_autoexecute
Return

;~ LAUNCH GUI
RAlt::
Gosub, gui_spawn
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ ///////////////////////////////////// ;*[GUI AUTO EXECUTE] //////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

gui_autoexecute: 																		       ;~ Load the GUI code
gui_control_options := "xm w220 " . cForeground . " -E0x200" 									       ;~ -E0x200 removes border around Edit controls
gui_state = closed																		       ;~ Initialize variable to keep track of the state of the GUI
search_urls		:= 0 																       ;~ Initialize search_urls as a variable set to zero

Loop, Read, Includes\UserCommands.ahk
{
	StringCaseSense, Off 
	If SubStr(A_LoopReadLine, 1, 1) != ";" 									;~ Do not display commented commands
	{
		If A_LoopReadLine contains MasterScriptCommands =		
		{
			
			Trimmed 	:= SubStr(A_LoopReadLine,InStr(A_LoopReadLine,"MasterScriptCommands = ",,,1)) ;~ Find each line with a "command =" in it
			Trimmed 	:= StrReplace(Trimmed,"`%A_Space`%",A_Space)				;~ Trimming excess spaces
			Trimmed	:= StrReplace(Trimmed, "MasterScriptCommands = ", "",,1)
			Setpos 	:= InStr(Trimmed,"`)")
			StringTrimRight,command,trimmed,StrLen(trimmed)-setpos+1 			;~ Trim everything from the right of ")" to get the COMMAND
			Setpos 	:= InStr(Trimmed,"`;")
			StringTrimLeft,comment,trimmed,setpos-1							;~ Trim everything from the left to get the COMMENT	
			;~ oData 	.= Command "," Chr(34) "`;~" Comment Chr(34)
			oData 	.= Command "," Chr(34) Comment Chr(34)
			oData 	.= "`n" 											;~ Breaking each command into a new line
			
			CommentPOS 	:= InStr(Comment, "`;") 							;~ Getting the position of the comments
			if (maxpadding < CommentPOS)
				maxpadding := CommentPOS
			
			;~ oArray.Push(SubStr(Trimmed.2,1,3))
			;~ oArray.Push(Substr(Trimmed.2,7))
		}
		
	}
}
Loop, Parse, oData,`n
{
	Line 		:= A_LoopField
	CommentPOS 	:= InStr(Line, "`;")
	Insert_Spaces 	:= maxpadding - commentpos
	Loop, % Insert_Spaces
	{
		Line 	:= StrReplace(Line,"`;",A_Space "`;")
	}
	oDataPadded 	.= line
	oDataPadded 	.= "`n"
}
Sort, oDataPadded
Data := oDataPadded

;* [Sift Intellisense Variables]
Display      := Data
Options      := "oc"
NgramSize    := 3
NgramLimit   := .50
DisplayLimit := 0

Return

#Include Includes\MSC_Gui Spawn.ahk

;~ Up & Down Arrows for Listbox Selection
#If WinActive("ahk_id " MSC_GUI) && (getFokus() == QueryEditField || getFokus() == hEdtValue2)			       ;~ If GUI is in focus and Edit box is the main focus of the GUI
^Backspace:: 																			       ;~ Active Window's Delete Word Shorcut
Send, ^+{Left}{Delete}
Return

~Down::
~Up::
MSC_KeybindFocus()
Return
~Enter:: 																				       ;~ Press Enter from Editfield to Activate Listbox
MSC_KeybindFocus(1)
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ //////////////////////////////                                    ///////////////////////////////
;~ ////////////////////////////// ;*[GUI FUNCTIONS AND SUBROUTINES]  ///////////////////////////////
;~ //////////////////////////////                                    ///////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

;~ Automatically triggered on Escape key:
GuiEscape:
gui_destroy() 																			       ;~ Includes restoring previously active window
search_urls := 0
Return

;~ The callback function when the text changes in the input field.
Findus:
Gui, Submit, NoHide
Gosub, GUI_Intellisense 																	       ;~ Enable for GUI Intellisense
#Include Includes\UserCommands.ahk 														       ;~ Has to be here for Commands to execute
if ErrorLevel
	Msgbox, 48, % "ERROR "A_LastError, % DMD_GetErrorStr(A_LastError)
Return

;~ Hidden Button when submitting the Listbox selection
ButtonOK:
Gui, Submit, NoHide
GuiControl,, MasterScriptCommands, % Trim(RegExReplace(StrSplit(Gui_Display, "`t").1, "\h\K\h+")) 		       ;~ Give the name of our edit and what will go in it. Leave param 2 blank will retrieve it's contents
GuiControl,, Gui_Display, 																       ;~ Remove Intellisense so GUI Hides & Doesn't Overlap over Search Engine
Gosub, Findus
Return

;~ GUI for Intellisense
Gui_Intellisense:
GuiControl, Show, Gui_Display
Gui, Show, AutoSize
MSC_RoundedEdges(MSC_GetGuiSize().w,MSC_GetGuiSize().h)
Sifted_Text := Sift_Regex((MasterScriptCommands = "" ? Data = "" : Data := Data), MasterScriptCommands, Options)

/*
	resScores := {}
	Loop, Parse, Sifted_Text, `n, `r
	{
		command := StrSplit(A_LoopField, ",").1
		resScores[levenshtein_distance(command, MasterScriptCommands)] := A_LoopField  ;~ Object
	}
	;~ m(resScores)
	bestResult := resScores[resScores.MinIndex()]
	Sifted_Text := bestResult
*/


;~ Sifted_Text := Sift_Ngram((MasterScriptCommands = "" ? Data = "" : Data := Data), MasterScriptCommands, .5,,1)
Display     := st_columnize(Sifted_Text, "csv", 1,,A_Tab)                                                       ;~ justify everything correctly. 3 = center, 2= right, 1=left.
GuiControl,, Gui_Display, `n%Display%
if (MasterScriptCommands = Space)                                                                               ;~ If Query field is blank then show NOTHING
{
	GuiControl,, Gui_Display, 														
	GuiControl, Hide, Gui_Display
	Gui, Show, AutoSize
	MSC_RoundedEdges(MSC_GetGuiSize().w,MSC_GetGuiSize().h)
}
Return

#WinActivateForce
gui_destroy() { ;~ gui_destroy() Destroy the GUI after use.
	global gui_state, gui_search_title, Active_Title
	gui_state = closed
	gui_search_title = 	                                                                                       ;~ Forget search title variable so the next search does not re-use it in case the next search does not set its own:
	
	GuiControl,, Gui_Display,                                                                                  ;~ Reset Intellisense Gui to BLANK
	Gui, Destroy                                                                                               ;~ Hide GUI
	WinActivate % Active_Title                                                                                 ;~ Bring focus back to another window found on the desktop
}

;~ Gui Multiple Search Engines based on command input
#Include Includes\MSC_Gui Search Engine.ahk

/*
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ //////////////////////////////////////// ;*[COMMAND ENGINE] /////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////
	gui_add_command_input: 																	;~ gui_command_Input: Add GUI controls to allow typing of a search query.
	Gui, Add, Text, % gui_control_options cYellow, % gui_CI_title
	Gui, Add, Edit, %gui_control_options% %cYellow% vgui_CI_Edit -WantReturn							;~ "-WantReturn" allows command to execute without the need for RETURN KEY
	Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_CI_Enter 										;~ Hidden button
	GuiControl, Disable, MasterScriptCommands
	Gui, Show, AutoSize
	MSC_RoundedEdges(MSC_GetGuiSize().w,MSC_GetGuiSize().h)
	Return
	
	Gui_Command_Input(CI) {
		global ;~ has to be here.
		if gui_state != search
		{
			gui_state = search
		;~ if gui_state is "main", then we are coming from the main window and
		;~ GUI elements for the search field have not yet been added.
			Gosub, gui_add_command_input
		}
		;~ Assign the command to a variable.
		;~ The variables will have names command_input1, command_input2, ...
		command_inputs := command_inputs + 1
		command_input%command_inputs% := CI
	}
	
	gui_CI_Enter:
	Gui, Submit
	gui_destroy()
	Loop, % command_inputs
		command_final_input := StrReplace(command_input%A_Index%, "REPLACEME", uriEncode(gui_CI_Edit))
	command_inputs := 0
	Return
	
*/

RunReload:
Reload
Return

/*
	;~ DLL Call with restarttmp was causing Encoding issue with the GetCommandLineW (W for whitespace), just use reload.
	RunReload:
	Gosub, RunFile
	Run, %A_AhkPath% "Includes\MSC_Restart.ahk"
	ExitApp
	Sleep, 1000
	Return
	
	RunFile:                                                                                         ;~ Create restart file
	FileDelete, %TmpDir%\restarttmp.ahk
	While FileExist(TmpDir "\restarttmp.ahk")
		Sleep 100
	FileAppend, % "Run, *RunAs " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8 ;~ reload with command line parameters
	;~ if A_IsAdmin
		;~ FileAppend, % "Run, *RunAs " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ;~ reload with command line parameters
	;~ else
		;~ FileAppend, % "Run, " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ;~ reload with command line parameters
	Sleep 100
	Return
*/

;~ General settings, includes, & Functions
#Include Includes\Miscellaneous.ahk
Return