#Include <Default_Settings>
; --------------------------------------
Gosub, getListOfCommands
m(Data)
ExitApp

getListOfCommands:
oCommands := {}
Loop, Read, % "Includes\UserCommands.ahk"
{
	StringCaseSense, Off 
	If SubStr(A_LoopReadLine, 1, 1) != ";" ; Do not display commented commands
	{
		If A_LoopReadLine contains % "MasterScriptCommands ="
		{
			Command   := RegExMatch(A_LoopReadLine,"iO)(?<=\x22).*(?=\x22)", oCommand)
			Command   := oCommand.Value()
			mCommand  := RegExReplace(SubStr(Command,1,InStr(Command,"|")-2), "O)\x22", "$1") ; If multiple commands, just grab first one and remove extra "
			Command   := (Command ~= "\|\|" ? mCommand : Command)
			Comment   := RegExMatch(A_LoopReadLine,"iO);(\s?).*", oComment)                  ; Grab the comment inside ""
			oCommands[Command] := StrReplace(oComment.Value(), ";~ ", "")
		}
	}
}
oFinalCommandsList := {}
for key,value in oCommands {
    oObj := {"command":"","comment":""}
    oObj["command"] := key
    oObj["comment"] := value
	oFinalCommandsList.push(oObj)
}
m(oFinalCommandsList)
/* 
for Key, Value in oCommands
{
	q := Chr(34) ; Quote
	oDataPadded .= q Key q "," q Value q "`n"
}
Sort, oDataPadded
Data := oDataPadded 
*/
return