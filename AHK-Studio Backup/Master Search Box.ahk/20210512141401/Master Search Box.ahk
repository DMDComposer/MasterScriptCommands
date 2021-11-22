;~ Created by Asger Juul Brunshøj https://github.com/plul/Public-AutoHotKey-Scripts
;~ Heavily Adapted by DMDComposer

#Include <Default_Settings>

Menu, Tray, Icon, % A_ScriptDir "\Icon.ico", 1 												;~ Set Icon of Script in Taskbar

if (! A_IsAdmin){ 																		;~ http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  														;~ Requires v1.0.92.01+
	ExitApp
}

;~ Variable for Force Restart Script
TmpDir		:= A_ScriptDir "\tmpscrpts"
Dir 			:= A_ScriptDir "\Includes\UserCommands.ahk"
;~ #InstallKeybdHook																		;~ Not sure if I need this? -DMD

Notify().AddWindow("Reloaded Master Script Commands", {Title:"Master Script Commands", Font:"Sans Serif", TitleFont:"Sans Serif", Icon:"C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico, 1", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0xFFFFFF", Color:"0x282A2E", TitleColor:"0xFF0000"})

;-------------------------------------------------------
;~ AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS
;~ Scripts being included need to have their auto execute
;~ section in a function or subroutine which is then
;~ executed below.
;-------------------------------------------------------
Gosub, gui_autoexecute
;-------------------------------------------------------
;~ END AUTO EXECUTE SECTION
Return
;-------------------------------------------------------

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ ///////////////////////////////////// ;*[GUI AUTO EXECUTE] //////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

gui_autoexecute: 																		;~ Load the GUI code
;~ Tomorrow Night Color Definitions:
cBackground 		:= "c" . "1d1f21"
cCurrentLine 		:= "c" . "282a2e"
cSelection 		:= "c" . "373b41"
cForeground 		:= "c" . "c5c8c6"
cComment 			:= "c" . "969896"
cRed 			:= "c" . "cc6666"
cOrange 			:= "c" . "de935f"
cYellow 			:= "c" . "f0c674"
cGreen 			:= "c" . "b5bd68"
cAqua 			:= "c" . "8abeb7"
cBlue 			:= "c" . "81a2be"
cPurple 			:= "c" . "b294bb"

gui_control_options := "xm w220 " . cForeground . " -E0x200" 									;~ -E0x200 removes border around Edit controls
gui_state = closed																		;~ Initialize variable to keep track of the state of the GUI

search_urls		:= 0     																;~ Initialize search_urls as a variable set to zero

;-------------------------------------------------------------------------------
;~ TOOLTIP
;~ The tooltip shows all defined commands, along with a description of what
;~ each command does. It gets the description from the comments in UserCommands.ahk.
;~ The code was improved and fixed for Windows 10 with the help of schmimae.
;-------------------------------------------------------------------------------
/*
	tooltiptext = 																			;~ Resets Tooltip Text
	maxpadding = 0
	StringCaseSense, Off 																	;~ Matching to both if/If in the IfInString command below
	Loop, read, Includes\UserCommands.ahk
	{
																						;~ search for the string If MasterScriptCommands =, 
																						;~ but search for each word individually because spacing between words might not be consistent. (might be improved with regex)
		If Substr(A_LoopReadLine, 1, 1) != ";" 													;~ Do not display commented commands
		{
			If A_LoopReadLine contains if
			{
				IfInString, A_LoopReadLine, MasterScriptCommands
				IfInString, A_LoopReadLine, =
				{
					StringGetPos, setpos, A_LoopReadLine,=
					StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 							;~ trim everything that comes before the = sign				
					StringReplace, trimmed, trimmed, `%A_Space`%,{space}, All 						;~ Trimming excess spaces
					StringGetPos, setpos, trimmed,`) 
					StringTrimRight,command,trimmed,StrLen(trimmed)-setpos 						;~ Trim everything from the right of ")" to get the COMMAND
					StringGetPos, setpos, trimmed,`;~ 
					StringTrimLeft,comment,trimmed,setpos										;~ Trim everything from the left to get the COMMENT			
					tooltiptext .= Command "," Chr(34) Comment Chr(34)
					tooltiptext .= "`n" 													;~ Breaking each command into a new line
					
																						;~ The following is used to correct padding:
					StringGetPos, commentpos, Comment,`;~  										;~ Getting the position of the comments
					if (maxpadding < commentpos)
						maxpadding := commentpos
				}
			}
		}
	}
	tooltiptextpadded =
	Loop, Parse, tooltiptext,`n
	{
		line = %A_LoopField%
		StringGetPos, commentpos, line, `;
		spaces_to_insert := maxpadding - commentpos
		Loop, %spaces_to_insert%
		{
			StringReplace, line, line,`;,%A_Space%`;
		}
		tooltiptextpadded .= line
		tooltiptextpadded .= "`n"
	}
	Sort, tooltiptextpadded
	Data:= tooltiptextpadded
*/

Loop, read, Includes\UserCommands.ahk
{
	StringCaseSense, Off 
	If SubStr(A_LoopReadLine, 1, 1) != ";" 									;~ Do not display commented commands
	{
		If A_LoopReadLine contains MasterScriptCommands =		
		{
			
			;~ Trimmed 	:= StrSplit(A_LoopReadLine,"MasterScriptCommands = ") 		;~ Find each line with a "command =" in it
			Trimmed 	:= SubStr(A_LoopReadLine,InStr(A_LoopReadLine,"MasterScriptCommands = ",,,1))
			Trimmed 	:= StrReplace(Trimmed,"`%A_Space`%",A_Space)				;~ Trimming excess spaces
			Trimmed	:= StrReplace(Trimmed, "MasterScriptCommands = ", "",,1)
			Setpos 	:= InStr(Trimmed,"`)")
			StringTrimRight,command,trimmed,StrLen(trimmed)-setpos+1 			;~ Trim everything from the right of ")" to get the COMMAND
			Setpos 	:= InStr(Trimmed,"`;")
			StringTrimLeft,comment,trimmed,setpos-1							;~ Trim everything from the left to get the COMMENT	
			;~ oData 	.= Command "," Chr(34) "`;~" Comment Chr(34)
			oData 	.= Command "," Chr(34) Comment Chr(34)
			oData 	.= "`n" 											;~ Breaking each command into a new line
			
			
			CommentPOS 	:= InStr(Comment, "`;") 							;~ Getting the position of the comments
			if (maxpadding < CommentPOS)
				maxpadding := CommentPOS
			
			;~ oArray.Push(SubStr(Trimmed.2,1,3))
			;~ oArray.Push(Substr(Trimmed.2,7))
		}
		
	}
}
Loop, Parse, oData,`n
{
	Line 		:= A_LoopField
	CommentPOS 	:= InStr(Line, "`;")
	Insert_Spaces 	:= maxpadding - commentpos
	Loop, % Insert_Spaces
	{
		Line 	:= StrReplace(Line,"`;",A_Space "`;")
	}
	oDataPadded 	.= line
	oDataPadded 	.= "`n"
}
Sort, oDataPadded
Data:= oDataPadded

;* [Sift Intellisense Variables]
Display := Data
Options := "oc"
NgramSize := 3
NgramLimit := .50
DisplayLimit := 0

Return

;-------------------------------------------------------------------------------
;~ LAUNCH GUI
;-------------------------------------------------------------------------------
RAlt::
gui_spawn:
WinGetActiveTitle, Active_Title 															;~ Get Active Title before GUI Spawn
if gui_state != closed
{
	;~ If the GUI is already open, close it.
	gui_destroy()
	ToolTip,,, 																		;~ Clear Tooltip to reset Intellisense
	Return
}
ToolTip,,, 																			;~ Clear Tooltip to reset Intellisense
gui_state = main

/*
	Icon:="C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico" 		;~ Add icon to Main GUI Spawn
	
	MSC_Width:=(A_ScreenWidth/4) 																;~ Scalable Width depending on screen size
	MSC_Height:=(A_ScreenHeight/8) 															;~ Scalable Width depending on screen size
	
	;~ Standard GUI
	Gui, Margin, 16, 16
	Gui, Color, 1d1f21, 282a2e
	Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border HWNDMSC_GUI
	if((Ico:=StrSplit(Info.Icon,",")).1)
		Gui,Add,Picture,% (Info.IconSize?"w" Info.IconSize " h" Info.IconSize:""),% "HBITMAP:" LoadPicture(Foo:=(Ico.1+0?"Shell32.dll":Ico.1),Foo1:="Icon" (Ico.2!=""?Ico.2:Info.Icon)"GDI+ " (Info.IconSize?"w" Info.IconSize " h" Info.IconSize:""),2)
	
*/

MSC_Title 				:= "Master Script Commands"
MSC_Background 			:= "#1d1f21"
MSC_Color 				:= "#c5c8c6"
MSC_Icon 					:= "MasterIcon"
MSC_Radius 				:= 1
MSC_Font 					:= "Segoe UI"
MSC_FontSize 				:= "15"
MSC_Width 				:= (A_ScreenWidth/4) 												;~ Scalable Width depending on screen size
MSC_Height 				:= (A_ScreenHeight/8) 												;~ Scalable Width depending on screen size
MSC_Margin 				:= 16
MSC_IconSize:=IconW:=IconH	:= 32

IniRead, Img, C:\AHK Scripts\_Master Script\Resources\Icons.ini, Icons,% Icon,0							;~ Read Ini file of B64 Icons
;~ Images[Icon]:=Img

Img := "C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico"
;~ Img := "C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Notion.ico"

;~ Standard GUI
Gui, Margin, % MSC_Margin, % MSC_Margin
Gui, Color, 1d1f21, 282a2e
Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border HWNDMSC_GUI									;~ Removes header/toolbar/menu from IE Window

IE := FixIE(11)
Gui,Add,ActiveX,vWB w%MSC_Height% h%MSC_IconSize% hwndhID,mshtml										;~ The final parameter "mshtml" is the name of the ActiveX component
FixIE(IE)
;~ Background:=Info.Background,Color:=Info.Color,Gradient:=(Info.Gradient?"background: linear-gradient" Info.Gradient:""),Title:=Info.Title
HTML=
	(
	<body style='margin:0px; background-color:%MSC_Background%;color:%MSC_Color%;font-size:%MSC_FontSize%; font-family:%MSC_Font%;'>
		<div style='width:%MSC_Width%px;height:%IconH%px;%Gradient%;'>
			<img align='middle' style='width:%IconW%px;height:%IconH%px;'>
				<span style='Margin-Left:8px'>%MSC_Title%</span>
			</img>
		</div>
	</body>
	)
wb.Navigate("about:" HTML) 																	;~ Travel to the made up page variable "HTML" that we created above
while(wb.ReadyState!=4)
	Sleep,10
if (StrLen(Img)>1000)																		;~ Dirty way of comparing B64 string vs simple ICO/PNG Dir Path String Length
{
	wb.Document.GetElementsByTagName("Img").Item[0].src:="data:image/png;base64," Img					;~ Giving the IMG tag the Base64 IMG
}
else
	wb.Document.GetElementsByTagName("Img").Item[0].src:= Img										;~ Giving IMG tag the PNG/ICO
Width:=wb.Document.GetElementsByTagName("span").Item[0].GetBoundingClientRect().Width 					;~ Getting auto width based on title length
Width:= wb.Document.GetElementsByTagName("Div").Item[0].Style.Width := Width+StrLen(MSC_Title)+IconW		;~ Grab div > style > width and the width = width set above + 84px
GuiControl, Move, %hID%, % "Section " "w" Width "h" MSC_IconSize "x" ((MSC_Width-Width)/2)+(IconW/2)		;~ Moving HTML & Centering it Above Edit Field


/*
	Gui, Font, s11, Segoe UI
	Gui, Add, Text, xm w%MSC_Width% cc5c8c6 -E0x200 +Center Section vgui_main_title HWNDMSC_Title, Master Script Commands ;~ Title
*/
Gui, Font, s10, Segoe UI
Gui, Add, Edit, xs w%MSC_Width% cc5c8c6 -E0x200 vMasterScriptCommands gFindus HWNDQueryEditField ;~ Search edit field
SendMessage 0x1501, 1, "Search",, ahk_id %QueryEditField% ;~ EM_SETCUEBANNER -- Add "Search" blank to the edit field.

;~ Search Engine GUI Params
Gui, Add, Text, xs w%MSC_Width% -E0x200 %cYellow% +Center vGui_Search_title_var, %gui_search_title%
Gui, Add, Edit, xs w%MSC_Width% -E0x200 %cYellow% vgui_SearchEdit -WantReturn hWndhEdtValue2 
SendMessage 0x1501, 1, "Search",, ahk_id %hEdtValue2% ;~ EM_SETCUEBANNER -- Add "Search" blank to the edit field.
GuiControl, Hide, Gui_Search_title_var
GuiControl, Hide, gui_SearchEdit

/*
	;~ GUI Intellisense Panel
	Gui, Font, s10 cffffff, Consolas
	Gui, Color, 0x1d1f21, 0x1d1f21
	;~ WinGetPos,GIx,GIy,GIw,GIh,ahk_id %hEdtValue2% ;~ Getting value of edit field to figure out the "Y" but having trouble -DMD
	Gui, Add, Edit, xs y100 w%MSC_Width% h%MSC_Height% ReadOnly +0x300000 -E0x200 +VScroll  -HScroll -wrap -WantReturn -Tabstop vGui_Display HWNDGUI_Intel_Edit_Field, BLAGR! ;~ Edit Query Field
	GuiControl,, Gui_Display, ;~ If Query field is blank then show NOTHING
	GuiControl, Hide, Gui_Display
*/

;~ Gui Intellisense Listbox
Gui, Font, s10 cffffff, Consolas
Gui, Color, 0x1d1f21, 0x1d1f21
Gui, Add, ListBox, xs y100 w%MSC_Width% h%MSC_Height% vGui_Display -HScroll +VScroll +0x300000 -E0x200 Choose1 HWNDGUI_Intel_Edit_Field,									;~ Listbox
Gui +Delimiter`n 																															;~ Listbox will search through for line breaks instead of default "|"
GuiControl,, Gui_Display, 																;~ If Query field is blank then show NOTHING
GuiControl, Hide, Gui_Display 																												;~ Hide Intellisense Box until called upon
Gui, Add, Button, Hidden Default, OK

Gui, Show,AutoSize, myGUI
Return

;~ Up & Down Arrows for Listbox Selection
#If WinActive("ahk_id " MSC_GUI) && getFokus() == QueryEditField									;~ If GUI is in focus and Edit box is the main focus of the GUI
^Backspace:: 																			;~ Active Window's Delete Word Shorcut
Send, ^+{Left}{Delete}
Return
~Down::
ControlFocus, , ahk_id %GUI_Intel_Edit_Field%
Gui, Submit, NoHide
ControlFocus, , ahk_id %QueryEditField%
Return
~Up::
ControlFocus, , ahk_id %GUI_Intel_Edit_Field%
Gui, Submit, NoHide
ControlFocus, , ahk_id %QueryEditField%
Return
~Enter:: 																				;~ Press Enter from Editfield to Activate Listbox
ControlFocus, , ahk_id %GUI_Intel_Edit_Field%
Gui, Submit, NoHide
SendInput, {Enter}
ControlFocus, , ahk_id %QueryEditField%
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ //////////////////////////////                                    ///////////////////////////////
;~ ////////////////////////////// ;*[GUI FUNCTIONS AND SUBROUTINES]  ///////////////////////////////
;~ //////////////////////////////                                    ///////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////


;~ Automatically triggered on Escape key:
GuiEscape:
gui_destroy() 																			;~ Includes restoring previously active window
search_urls := 0
Return

;~ The callback function when the text changes in the input field.
Findus:
Gui, Submit, NoHide
;~ Gosub, Tooltip_Intellisense 																;~ Enable for Tooltip Intellisense
Gosub, GUI_Intellisense 																	;~ Enable for GUI Intellisense
#Include Includes\UserCommands.ahk 														;~ Has to be here for Commands to execute
Return

;~ Hidden Button when submitting the Listbox selection
ButtonOK:
Gui, Submit, NoHide
GuiControl,, MasterScriptCommands, % Trim(RegExReplace(StrSplit(Gui_Display, "`t").1, "\h\K\h+")) 		;~ Give the name of our edit and what will go in it. Leave param 2 blank will retrieve it's contents
GuiControl,, Gui_Display, 																;~ Remove Intellisense so GUI Hides & Doesn't Overlap over Search Engine
Gosub, Findus
Return


;~ GUI for Intellisense
Gui_Intellisense:
GuiControl, Show, Gui_Display
;~ GuiControl, +Center, MSC_Title
Gui, Show, AutoSize
Sifted_Text:= Sift_Regex((MasterScriptCommands = "" ? Data = "" : Data:= Data), MasterScriptCommands, Options)
Display:= st_columnize(Sifted_Text, "csv", 1,,A_Tab) 											;~ justify everything correctly. 3 = center, 2= right, 1=left.
;~ WinGetPos,QGx,QGy,QGw,QGh,ahk_id %QueryGUI%
GuiControl,, Gui_Display, `n%Display%
if (MasterScriptCommands = "")
{
	GuiControl,, Gui_Display, 															;~ If Query field is blank then show NOTHING
	GuiControl, Hide, Gui_Display
	Gui, Show, AutoSize
}
Return

;~ gui_destroy: Destroy the GUI after use.

#WinActivateForce
gui_destroy() {
	global gui_state
	global gui_search_title
	
	gui_state = closed
    ;~ Forget search title variable so the next search does not re-use it
    ;~ in case the next search does not set its own:
	gui_search_title =
	
	;~ Reset Intellisense Gui to BLANK
	GuiControl,, Gui_Display, 
	
    ;~ Hide GUI
	Gui, Destroy
	
    ;~ Bring focus back to another window found on the desktop
	WinActivate % Active_Title
}

gui_change_title(Message,Color:= "",Icon:= "C:\AHK Scripts\_Master Script\Resources\Master If Commands Icons\Cogwheel Settings.ico") {
    ;~ If parameter color is omitted, the message is assumed to be an error
    ;~ message, and given the color red.
	/*
		If color =
		{
			global cRed
			color:= cRed
		}	
	*/
	
	global WB
	global MSC_Title 			
	global MSC_Background 		
	global MSC_Color 			
	global MSC_Icon 				
	global MSC_Radius 			
	global MSC_Font 				
	global MSC_FontSize 			
	global MSC_Width 			
	global MSC_Height 			
	global MSC_Margin 			
	global MSC_IconSize
	global IconW
	global IconH
	global Img
	
	;~ MSC_Color := StrReplace(Color, "#", "c") 													;~ Replace # with c to function with GUI
	Img:=MSC_Icon	:= Icon
	MSC_Color 	:= color
	MSC_Title 	:= message
	
	
	HTML=
	(
	<body style='margin:0px; background-color:%MSC_Background%;color:%MSC_Color%;font-size:%MSC_FontSize%; font-family:%MSC_Font%;'>
		<div style='width:%MSC_Width%px;height:%IconH%px;%Gradient%;'>
			<img align='middle' style='width:%IconW%px;height:%IconH%px;'>
				<span style='Margin-Left:8px'>%MSC_Title%</span>
			</img>
		</div>
	</body>
	)
	wb.Navigate("about:" HTML) 																	;~ Travel to the made up page variable "HTML" that we created above
	while(wb.ReadyState!=4)
		Sleep,10
	if (StrLen(Img)>1000)																		;~ Dirty way of comparing B64 string vs simple ICO/PNG Dir Path String Length
	{
		wb.Document.GetElementsByTagName("Img").Item[0].src:="data:image/png;base64," Img					;~ Giving the IMG tag the Base64 IMG
	}
	else
		wb.Document.GetElementsByTagName("Img").Item[0].src:= Img										;~ Giving IMG tag the PNG/ICO
	Width:=wb.Document.GetElementsByTagName("span").Item[0].GetBoundingClientRect().Width 					;~ Getting auto width based on title length
	Width:= wb.Document.GetElementsByTagName("Div").Item[0].Style.Width := Width+StrLen(MSC_Title)+IconW		;~ Grab div > style > width and the width = width set above + 84px
	
	if (Width < 90)
		Width:= wb.Document.GetElementsByTagName("Div").Item[0].Style.Width := Width+StrLen(MSC_Title)+IconW+10	;~ If width is less than 90 add more white space at end otherwise title gets cut off
	GuiControl, Move, %hID%, % "Section " "w" Width "h" MSC_IconSize "x" ((MSC_Width-Width)/2)+(IconW/2)		;~ Moving HTML & Centering it Above Edit Field
	GuiControl, Show, WB 
	
	/*
		GuiControl,, gui_main_title, %message%
		Gui, Font, s11 %color%
		GuiControl, Font, gui_main_title
		Gui, Font, s10 cffffff 																;~ reset text color
	*/
}

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ //////////////////////////////////////// ;*[SEARCH ENGINES] /////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

gui_search_add_elements: 																;~ gui_search_add_elements: Add GUI controls to allow typing of a search query.
;~ Notify Variables has to be here because of the sequence order how the gui search works.
Title		:= ""
Font			:= "Segoe UI"
TitleFont		:= "Segoe UI"
Icon			:= "C:\Program Files\AutoHotkey\AutoHotkey.exe, 2" 								;~  Can be either an Integer to pull an icon from Shell32.dll or a full path to an EXE or full path to a dll.  You can add a comma and an integer to select an icon from within that file eg. {Icon:"C:\Windows\HelpPane.exe,2"}
Animate		:= "Right,Slide" 															;~  Ways that the window will animate in eg. {Animate:""} Can be Bottom, Top, Left, Right, Slide, Center, or Blend (Some work together, and some override others)
ShowDelay		:= 100	
IconSize		:= 64	
TitleSize		:= 14
Size			:= 20
Radius		:= 26
Time			:= 2500
Background	:= "0x1d1f21"
Color		:= "0xFFFFFF"	
TitleColor	:= "0x00FF00"

;~ Hide GUI Intellisense
GuiControl,, Gui_Display, 																;~ If Query field is blank then show NOTHING
GuiControl, Hide, Gui_Display
Gui, Show, AutoSize

;~ MSC Gui Spawn
GuiControl, Show, Gui_Search_title_var,
GuiControl, Text, Gui_Search_title_var, %gui_search_title%
GuiControl, Show, gui_SearchEdit
Gui, Show, AutoSize
;~ Gui, Add, Text, xs w%MSC_Width% -E0x200 %cYellow% +Center vGui_Search_title_var, %gui_search_title%
;~ Gui, Add, Edit, xs w%MSC_Width% -E0x200 %cYellow% vgui_SearchEdit -WantReturn hWndhEdtValue2 
;~ SendMessage 0x1501, 1, "Search",, ahk_id %hEdtValue2% ;~ EM_SETCUEBANNER -- Add "Search" blank to the edit field.
Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ;~ hidden button just to submit data to Subroutine
GuiControl, Disable, MasterScriptCommands
Gui, Show, AutoSize
Return

gui_search(url) {
	global
	if gui_state != search
	{
		gui_state = search
        ;~ if gui_state is "main", then we are coming from the main window and
        ;~ GUI elements for the search field have not yet been added.
		Gosub, gui_search_add_elements
	}
	
    ;~ Assign the url to a variable.
    ;~ The variables will have names search_url1, search_url2, ...
	
	search_urls:= search_urls + 1
	search_url%search_urls% := url
}

gui_SearchEnter:
Gui, Submit
gui_destroy()
query_safe:= uriEncode(gui_SearchEdit)
Loop, %search_urls%
{
	StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
	Run % search_final_url
	Search_Title:= RegExReplace(search_final_url, "s).*?(\d{12}).*?(?=\d{12}|$)", "$1`r`n")
	If (Title = "" ? Title:=Search_Title : Title:= Title)	
		Notify().AddWindow(gui_SearchEdit, {Title:Title, Font:Font, TitleFont:TitleFont, Icon:Icon, Animate:Animate, ShowDelay:ShowDelay, IconSize:IconSize, TitleSize:TitleSize, Size:Size, Radius:Radius, Time:Time, Background:Background, Color:Color, TitleColor:TitleColor})
}
Notify().AddWindow(gui_SearchEdit, {Title:"Searching For:", Font:"Segoe UI", TitleFont:"Segoe UI", Icon:"C:\Program Files\AutoHotkey\AutoHotkey.exe, 2", Animate:"Right, Slide", ShowDelay:100, IconSize:64, TitleSize:14, Size:20, Radius:26, Time:2500, Background:"0x1d1f21", Color:"0xFFFFFF", TitleColor:"0x00FF00"})
search_urls := 0
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ //////////////////////////////////////// ;*[COMMAND ENGINE] /////////////////////////////////////
;~ ////////////////////////////////////////                    /////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////



gui_add_command_input: 																	;~ gui_command_Input: Add GUI controls to allow typing of a search query.
Gui, Add, Text, %gui_control_options% %cYellow%, %gui_CI_title%
Gui, Add, Edit, %gui_control_options% %cYellow% vgui_CI_Edit -WantReturn							;~ "-WantReturn" allows command to execute without the need for RETURN KEY
Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_CI_Enter 										;~ Hidden button
GuiControl, Disable, MasterScriptCommands
Gui, Show, AutoSize
Return

Gui_Command_Input(CI) {
	global
	if gui_state != search
	{
		gui_state = search
		   ;~ if gui_state is "main", then we are coming from the main window and
		   ;~ GUI elements for the search field have not yet been added.
		Gosub, gui_add_command_input
	}
	
    ;~ Assign the command to a variable.
    ;~ The variables will have names command_input1, command_input2, ...
	
	command_inputs:= command_inputs + 1
	command_input%command_inputs% := CI
}

gui_CI_Enter:
Gui, Submit
gui_destroy()
query_safe:= uriEncode(gui_CI_Edit)
Loop, %command_inputs%
{
	StringReplace, command_final_input, command_input%A_Index%, ReplaceMe, %query_safe%	
}
command_inputs:= 0
Return

;~ /////////////////////////////////////////////////////////////////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ ///////////////////////////////////// ;*[RESTART / RELOAD] //////////////////////////////////////
;~ /////////////////////////////////////                      //////////////////////////////////////
;~ /////////////////////////////////////////////////////////////////////////////////////////////////

RunReload:
Gosub, RunFile
Run, %A_AhkPath% "Includes\MSC_Restart.ahk"
ExitApp
Sleep, 1000
Return


RunFile: 																				;~ Create restart file
FileDelete, %TmpDir%\restarttmp.ahk
While FileExist(TmpDir "\restarttmp.ahk")
	Sleep 100
FileAppend, % "Run, *RunAs " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  		;~ reload with command line parameters
/*
	if A_IsAdmin
		FileAppend, % "Run, *RunAs " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ;~ reload with command line parameters
	else
		FileAppend, % "Run, " DllCall( "GetCommandLineW", "Str" ), %TmpDir%\restarttmp.ahk, UTF-8  ;~ reload with command line parameters
*/
Sleep 100
Return

;~ General settings, includes, & Fucntions
;~ #Include %A_ScriptDir%\Includes\Miscellaneous.ahk
#Include Includes\Miscellaneous.ahk

Return