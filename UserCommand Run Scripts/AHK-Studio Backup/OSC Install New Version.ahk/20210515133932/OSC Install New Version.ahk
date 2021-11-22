#Include <Default_Settings>
;~ --------------------------------------
if WinExist("Open Stage Control")												;~ Close OSC before installing new version
	WinClose, Open Stage Control
OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"							;~ Location of OSC Folder 
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
}
7zip := "C:\Program Files\7-Zip"
Run, "C:\Program Files\7-Zip\7z.exe" x "%OSC_Zip_New%" -o"%OSC_Folder%"\ -y, % 7zip, Hide, PID
Sleep, 1000 																;~ Sleep has to be here otherwise the while loop hasn't had enough time to grab the PID
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
FileMove, % OSC_Unzip "\open-stage-control.exe", % vvvDir . "\Open Stage Control", 1   	;~ Cuationary as Loop sometimes wouldn't move the EXE file
FileGetSize, vSize, % OSC_Unzip
If (vSize = 0)
	FileRemoveDir, % OSC_Unzip
If (!FileExist(OSC_Unzip))
	FileDelete, % OSC_Zip_New
Notify().AddWindow("has been Installed", {Title:vName, Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\Program Files (x86)\Open Stage Control\open-stage-control.exe", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x2C323A", Color:"0xD8DFE9", TitleColor:"0xD8DFE9"})
Run, % OSC_Folder . "\open-stage-control.exe"
Sleep, 2500
ExitApp