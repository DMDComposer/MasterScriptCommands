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

;~ AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS before first gui spawn
Gosub, gui_autoexecute
Return

;~ LAUNCH GUI
RAlt::
Gosub, gui_spawn
Return

;~ MSC Gui Creation & Hotkeys
#Include Includes\MSC_Gui Spawn.ahk
#Include Includes\MSC_Gui Hotkeys.ahk

;~ MSC Commands & Listbox Intellisense
#Include Includes\MSC_Commands n Intellisense.ahk

;~ Gui Multiple Search Engines based on command input
#Include Includes\MSC_Gui Search Engine.ahk

;~ MSC Gui_Destroy(), Reset, & Reload Functions
#Include Includes\MSC_Gui Exit n Reload.ahk

;~ General settings, includes, & Functions
#Include Includes\Miscellaneous.ahk


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


Return