;~ Created by Asger Juul Brunshøj https://github.com/plul/Public-AutoHotKey-Scripts
;~ Heavily Adapted by DMDComposer

#Include <Default_Settings>

#NoTrayIcon
Menu, Tray, Icon, Icon.ico, 1                               ;~ Set Icon of Script in Taskbar

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

gui_autoexecute: 																		       ;~ Load the GUI code
gui_control_options := "xm w220 " . cForeground . " -E0x200" 									       ;~ -E0x200 removes border around Edit controls
gui_state = closed																		       ;~ Initialize variable to keep track of the state of the GUI
search_urls		:= 0 																       ;~ Initialize search_urls as a variable set to zero

oCommands := {}
Loop, Read, Includes\UserCommands.ahk
{
	StringCaseSense, Off 
	If SubStr(A_LoopReadLine, 1, 1) != ";" 									;~ Do not display commented commands
	{
		If A_LoopReadLine contains % "MasterScriptCommands ="		
		{
			Command   := RegExMatch(A_LoopReadLine,"iO)(?<=\x22).*(?=\x22)", oCommand)
			Command   := oCommand.Value()
			mCommand  := RegExReplace(SubStr(Command,1,InStr(Command,"|")-2), "O)\x22", "$1") ;~ If multiple commands, just grab first one and remove extra "
			Command   := (Command ~= "\|\|" ? mCommand : Command)
			Comment   := RegExMatch(A_LoopReadLine,"iO);~(\s?).*", oComment)                  ;~ Grab the comment inside ""
			oCommands[Command] := oComment.Value()
		}
		
	}
}
for Key, Value in oCommands
{
	q := Chr(34) ;~ Quote
	oDataPadded .= q Key q "," q Value q "`n"
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