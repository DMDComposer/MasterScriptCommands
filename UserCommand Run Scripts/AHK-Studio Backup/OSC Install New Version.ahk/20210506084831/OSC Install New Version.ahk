#Include <Default_Settings>
;~ --------------------------------------
OSC_Zip := Clipboard
;~ OSC_Folder := "C:\Program Files (x86)\Open Stage Control" ;~ Location of OSC Folder 
RegRead, OSC_Folder, HKCU, SOFTWARE\Metaserver\KnownApplications\open-stage-control.exe, ModuleName
DebugWindow(OSC_Folder,Clear:=0,LineBreak:=1,Sleep:=250,AutoHide:=0)

Return
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
OSC_Zip_New := "C:\Program Files (x86)\Open Stage Control\open-stage-control-1.9.5-win32-x64.zip"
7zip := "C:\Program Files\7-Zip"
Run, "C:\Program Files\7-Zip\7z.exe" x "%OSC_Zip_New%" -o"%OSC_Folder%"\ -y, % 7zip, Hide, PID
Sleep, 1000 ;~ Sleep has to be here otherwise the while loop hasn't had enough time to grab the PID
while WinExist("ahk_pid" PID){
	Sleep, 10
}
SplitPath, OSC_Zip_New, vvName, vvDir, vvEXT, vvNNE, vvDrive
OSC_Unzip := vvDir . "\" . vvNNE
SplitPath, OSC_Folder,,vvvDir
Loop, Files, % OSC_Unzip "\*.*", F
	FileMove, %A_LoopFileFullPath%, % vvvDir . "\Open Stage Control", 1
Loop, Files, % OSC_Unzip "\*.*", RD
	FileMoveDir, %A_LoopFileFullPath%, % vvvDir . "\Open Stage Control", 1
FileGetSize, vSize, % OSC_Unzip
If (vSize = 0)
	FileRemoveDir, % OSC_Unzip
If (!FileExist(OSC_Unzip))
	FileDelete, % OSC_Zip_New
Return

Escape::
ExitApp
Return
