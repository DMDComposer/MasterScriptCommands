#Include <Default_Settings>
;~ --------------------------------------
OSC_Zip := Clipboard
OSC_Folder := "C:\Program Files (x86)\Open Stage Control"
/*
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
*/
OSC_Zip_New := "C:\Program Files (x86)\Open Stage Control\open-stage-control-1.9.5-win32-x64.zip"
7zip := "C:\Program Files\7-Zip"
RunWait, "C:\Program Files\7-Zip\7z.exe" x "%OSC_Zip_New%" -o"%OSC_Folder%"\ -y, % 7zip,
Return
/*
	
	
	;alt + win + x
	!#x::
	temp = %clipboard%
	Send, {Ctrl Down}c{Ctrl Up}
	file = %clipboard% ;get file address
	clipboard = %temp% ;restore clipboard
	outdir := getdir(file)
	if (A_Is64bitOS = 1)
	{
	runwait, "C:\Program Files\7-Zip\7z.exe" x "%file%" -o"%outdir%" -y,,hide
	}
	else
	{
	runwait, "C:\Program Files (x86)\7-Zip\7z.exe" x "%file%" -o"%outdir%" -y,,hide
	}
	msgbox, 7zip has finished extracting "%file%".
	return
	getdir(input)
	{
		SplitPath, input,,parentdir,,filenoext
		final = %parentdir%\%filenoext%
		retur
*/