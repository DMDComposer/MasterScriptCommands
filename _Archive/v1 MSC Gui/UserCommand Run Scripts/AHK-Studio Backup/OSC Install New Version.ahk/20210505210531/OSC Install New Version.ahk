#Include <Default_Settings>
;~ --------------------------------------

OSC_Zip := ClipboardAll
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
DebugWindow(vName,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
Return
FileMove, % OSC_Zip, % OSC_Folder