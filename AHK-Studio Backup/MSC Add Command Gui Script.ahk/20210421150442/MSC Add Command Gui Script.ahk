#Include <Default_Settings>
;~ --------------------------------------

Gui, -Caption			;removes caption and border
Gui, color, black				; sets window color
Gui, Font, s10 bold cwhite, Segoe UI   ;now this sets the font for all of the GUI
Gui, Add, Text, x78 y11 w120 h20, Add Command?
Gui, Font, norm
;~ Gui, Add, Text, cAqua  Center, Some text to display.		;text color and centered
;~ Gui, Add, Edit, x130 y40 vGui_Display ReadOnly +0x300000 -wrap -Hidden,
Gui, Add, Edit, cblack x130 y40 w800 h400 vGui_Display +0x300000 -E0x200 -wrap -WantReturn HWNDAdd_Command_ID vAdd_Command,
GuiControlGet, Add_Command ; the Edit control is called Add_Command
;~ Default Command Text
Add_Command .="
(
else if(MasterScriptCommands = """"){ ;~ Name of Command
	gui_destroy()
	
}
)"
GuiControl, Text, Add_Command, %Add_Command%
GuiControl, Focus, Add_Command ;~ when you hit the button, Editbox "keeps" the focus, but everything is selected
SendMessage, 0xB1, 32, 32,, ahk_id %Add_Command_ID% ;~ Puts cursor at 32 character position -- now play with the numbers, 0 = first character, 1 = second character, ..., -1 = last character
SendMessage, 0xB7,,,, ahk_id %Add_Command_ID% ;~ scrolls the caret into view. EM_SCROLLCARET := 0x00B7

Gui, Add, Button, gAdd_Command_Button, Add Command
Gui, Show, AutoSize
Return

F1::
Gui, Submit, NoHide ;~ Needed to add custom input
StringGetPos,setpos,Add_Command,`" ;~ Get position of comment
SendMessage, 0xB1, % setpos+1, % setpos+1,, ahk_id %Add_Command_ID% ;~ Puts cursor at 32 character position -- now play with the numbers, 0 = first character, 1 = second character, ..., -1 = last character
SendMessage, 0xB7,,,, ahk_id %Add_Command_ID% ;~ scrolls the caret into view. EM_SCROLLCARET := 0x00B7
Return

F2::
Gui, Submit, NoHide ;~ Needed to add custom input
StringGetPos,setpos,Add_Command,`; ;~ Get position of comment
SendMessage, 0xB1, % setpos+3, % setpos+18,, ahk_id %Add_Command_ID% ;~ Puts cursor at 32 character position -- now play with the numbers, 0 = first character, 1 = second character, ..., -1 = last character
;~ SendInput, {Backspace} ;~ Remove the Comment to enter in custom
SendMessage, 0xB7,,,, ahk_id %Add_Command_ID% ;~ scrolls the caret into view. EM_SCROLLCARET := 0x00B7
Return

F3::
Gui, Submit, NoHide ;~ Needed to add custom input
StringGetPos,setpos,Add_Command,gui_destroy() ;~ Get position of comment
SendMessage, 0xB1, % setpos+16, % setpos+16,, ahk_id %Add_Command_ID% ;~ Puts cursor at 32 character position -- now play with the numbers, 0 = first character, 1 = second character, ..., -1 = last character
SendMessage, 0xB7,,,, ahk_id %Add_Command_ID% ;~ scrolls the caret into view. EM_SCROLLCARET := 0x00B7

Return


+Enter::
Gosub, Add_Command_Button
Return

Tab::SendInput, {Space 4}

Add_Command_Button:
Gui, Submit, NoHide ;~ Needed to add custom input
UC_File:="!D:\Users\Dillon\Documents\Testing FileAppend.txt" ;~ ! is needed for TF Function to overwrite original file
Final_Line:=TF_CountLines(UC_File) ; store the number of lines of file in a variable
TF_InsertLine(UC_File,Final_Line-1,Final_Line-1,Add_Command)     ; insert --- in lines 2 4 and 9. 5 is endline will be ignored
;~ FileAppend,`n%Add_Command%,D:\Users\Dillon\Documents\Testing FileAppend.txt,UTF-8 ;~ `n is to ensure a new line is created for formatting
Gosub, GuiClose
Return

;~ FileAppend,% Add_Command,C:\AHK Scripts\_Master Script\Run\Master Search Box\Includes\UserCommands.ahk,UTF-8

GuiClose:
Gui, Destroy
ExitApp

Escape::
ExitApp
Return