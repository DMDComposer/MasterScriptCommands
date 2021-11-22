#Include <Default_Settings>
;~ --------------------------------------
OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
DebugWindow(! OSC_Folder . "\" . vName,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
While(FileExist(! OSC_Folder . "\" . vName)){
	DebugWindow("doesn't exist",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
}
Return

FileDelete, % OSC_Folder "\*.*"
Loop, Files, % OSC_Folder "\*.*", D
{
	Path := OSC_Folder "\" A_LoopFileName
	if (Path != OSC_Folder "\_Archive"){
		FileRemoveDir, % Path, 1
	}
}
FileMove, % OSC_Zip, % OSC_Folder



Return



Escape::
ExitApp
Return