#Include <Default_Settings>
;~ --------------------------------------

OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
FileDelete, % OSC_Folder "\*.*"
Loop, Files, % OSC_Folder "\*.*", D
	;~ FileDelete, % OSC_Folder "\" A_LoopFileName
	msgbox % OSC_Folder "\" A_LoopFileName

;~ FileMove, % OSC_Zip, % OSC_Folder


DebugWindow(OSC_Zip,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
Return