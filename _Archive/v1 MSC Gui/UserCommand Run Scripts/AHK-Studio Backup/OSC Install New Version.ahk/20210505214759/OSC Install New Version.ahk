#Include <Default_Settings>
;~ --------------------------------------
OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
SplitPath, OSC_Zip, vName, vDir, vEXT, vNNE, vDrive
FileDelete, % OSC_Folder "\*.*"
Loop, Files, % OSC_Folder "\*.*", D
{
	Path := OSC_Folder "\" A_LoopFileName
	if (Path != OSC_Folder "\_Archive"){
		FileRemoveDir, % Path, 1
	}
}
FileMove, % OSC_Zip, % OSC_Folder
OSC_Zip_New := OSC_Folder . "\" . vName
While(!FileExist(OSC_Zip_New)){
	Sleep, 10
	DebugWindow("doesn't exist",Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)
}
RunWait, %ComSpec% 7z e %OSC_Zip_New% -oc:\soft *.cpp -r,,Hide
Return