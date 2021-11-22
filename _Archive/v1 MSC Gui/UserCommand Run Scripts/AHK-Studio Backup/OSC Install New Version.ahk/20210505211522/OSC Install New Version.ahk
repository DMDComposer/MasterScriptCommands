#Include <Default_Settings>
;~ --------------------------------------

OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
FileDelete, % OSC_Folder "\*.*"
;~ FileMove, % OSC_Zip, % OSC_Folder


DebugWindow(OSC_Zip,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
Return