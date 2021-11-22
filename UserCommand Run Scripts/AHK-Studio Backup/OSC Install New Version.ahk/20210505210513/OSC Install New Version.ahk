#Include <Default_Settings>
;~ --------------------------------------

OSC_Zip := ClipboardAll
DebugWindow(OSC_Zip,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
Return
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
FileMove, % OSC_Zip, % OSC_Folder