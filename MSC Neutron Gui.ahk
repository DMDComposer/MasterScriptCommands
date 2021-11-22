#Include <Default_Settings>
#Include <Neutron>
#Include <cJson>
;
; NOTE: Must run on admin to enable MSC toggle on all windows
if (! A_IsAdmin){ ;http://ahkscript.org/docs/Variables.htm#IsAdmin
	Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
	ExitApp
}

; NOTE: If/Else > 5, than Switch statement has greater performnace. 
; TODO: Add Quick AHK Commands Engine
; TODO: ResetMSC needs to recenter GUI Spawn if user moved it
; TODO: Highlight Arrow Keys, Scrollbar Needs to Follow to bottom of list

; Create a new NeutronWindow and navigate to our HTML page
oFinalCommandsList := getListOfCommands()
; NOTE: Create neutron window & attributes
neutron := new NeutronWindow()
neutron.Load("index.html")
neutron.wnd.onReady(event)             ; Sending the Swal Msg Params for the Popup Msg
neutron.Gui("+LabelMSCNeutronGui")
global wndToggle     := 0
	 , wndPos        := getSearchWndPos(neutron)
	 , wndUID        := "ahk_id " neutron.UID()
	 , int           := int
	 , MSC_Search    := []
	 , vIni_Dir_Path := A_Dropbox "\AHK Scripts\_DMD Scripts\Hotstring Directory Paths\Directory Paths.ini"
	 , oDir_Paths    := DMD_Ini2Obj(vIni_Dir_Path)
	 , oDirs         := oDir_Paths.Directory_Paths
	 , oIcons        := oDir_Paths.Icon_Paths
setMSCIcons(wndUID)
Gui +LastFound +OwnDialogs +AlwaysOnTop ; keep MSC AlwaysOnTop
; neutron.Show(wndPos)
wndToggle := 1
enableMSCHotkeys()
t("Master Script Commands")
return

; NOTE: Summon / Dismiss MSC Neutron Window
RAlt::
toggleMSC(neutron)
return

mscSearch() {
	global neutron
	toggleMSC(neutron)
}

gui_Change_Title(Title,Subtitle := "What would you like to search?",Color := "",Icon := "") {
	global neutron
	; Set theme / colors for mscSearch
 	vIcon            := "./Icons/AHK.ico" ; only relative paths
 	vTextColor       := "#00FF00"
 	vBackgroundColor := "#00FF00"
 	vTitle           := "AHK Search"
 	vSubTitle        := Subtitle
	neutron.wnd.Eval("$('.mscIcon').css('background','url(""" vIcon """) no-repeat center center')")
	neutron.wnd.Eval("$('.mscTitle').text('" vTitle "')")
	neutron.wnd.Eval("$('.mscTitle').css('color', '" vTextColor "')")
	neutron.wnd.Eval("$('#search:focus').css({'border-color': '" vTextColor "', 'box-shadow': 'inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px " vTextColor "'})")
	
	; change ID of search to enable search functions
	neutron.wnd.Eval("$('#search').attr('id','mscSearchInput')")
	; Show Newly Changed Window
	toggleMSC(neutron)
	; Focus new Search Edit Field
	neutron.wnd.Eval("$('#mscSearchInput').focus()")
	return
}

getMSCCommand(neutron, event) {
	; s(event)
	global gui_SearchEdit := event
	toggleMSC(neutron)
	Gosub, gui_search_add_elements
}

enableMSCHotkeys() {
	Hotkey, IfWinActive, % wndUID
	Hotkey, Down, highlightNextDiv
	Hotkey, Up, highlightPrevDiv
}
getCommand(neutron, ByRef event) {
	; need to create list from MSC
	global oFinalCommandsList
		 , MasterScriptCommands
	oCommandsList := []
	for key,value in oFinalCommandsList {
		oCommandsList.push(value.command)
	}
	for key,value in oCommandsList {
		if (event = value || oDir_PathsTrue(event)) {
			MasterScriptCommands := event
			resetMSCWnd(neutron)
			Gosub, setCommands

			; need to reset event otherwise infinite loop with oDirs_PathsTrue()
			event := ""
		}
	}
}
getCommandTotal(neutron) {
	global oFinalCommandsList
	return oFinalCommandsList.Length()
}
getDB(neutron, event) {
	/*
	; create object like below from MSC commands
	global oObj := [{"command":"command1","comment":"comment1"}
		    ,{"command":"command2","comment":"comment2"}
		    ,{"command":"command3","comment":"comment3"}
		    ,{"command":"command4","comment":"comment4"}
		    ,{"command":"command5","comment":"comment5"}]
	*/
	global oFinalCommandsList
	return cJson.Dumps(oFinalCommandsList)
}
getListOfCommands() {
	oCommands := {}
	Loop, Read, % A_Dropbox "\AHK Scripts\_DMD Scripts\Master Search Box\Includes\testCommands.ahk"
	{
		StringCaseSense, Off 
		If SubStr(A_LoopReadLine, 1, 1) != ";" Continue ; Do not display commented commands
	    If A_LoopReadLine contains % "Case "
	    {
	        Command := RegExMatch(A_LoopReadLine,"iO)(?<=\x22).*(?=\x22)", oCommand)
	        Command := oCommand.Value
	        ; mCommand  := RegExReplace(SubStr(Command,1,InStr(Command,"|")-2), "O)\x22", "$1") ; If multiple commands, just grab first one and remove extra "
	        mPos    := RegExMatch(Command, "O)\s?,\s?", "$1") ; If multiple commands, just grab first one and remove extra "
	        Comment := RegExMatch(A_LoopReadLine,"iO);(\s?).*", oComment) ; Grab the comment inside ""
	        Comment := RegExReplace(oComment.Value, ";~?\s?", "")
	        if (!Command)
	            Continue
	        if (mPos) {
	            mCommand1 := SubStr(Command,1,mPos-2)
	            mCommand1 := RegExReplace(mCommand1, "\x22?\s?,?\s?\x22?", "")
	            mCommand2 := SubStr(Command,mPos,StrLen(Command))
	            mCommand2 := RegExReplace(mCommand2, "\x22?\s?,?\s?\x22?", "")
	            oCommands[mCommand1] := Comment
	            oCommands[mCommand2] := Comment
	        }
	        if (!mPos)
	            oCommands[Command] := Comment
	    }
	}
	oFinalCommandsList := {}
	for key,value in oCommands {
	    oObj := {"command":"","comment":""}
	    oObj["command"] := key
	    oObj["comment"] := value
		oFinalCommandsList.push(oObj)
	}
	return oFinalCommandsList
}
getSearchWndPos(neutron){
	vW := neutron.wnd.eval("$('.search').width()")
	vH := neutron.wnd.eval("$('.search').height()")
	; vPos := "w" vW " h" vH " x" vX " y" vY
	vPos := "w" vW " h" vH
	return vPos
}
highlightNextDiv() {
	global int, neutron 
	(int < 0 ? 0 : int)
	int++
	; Notify().AddWindow(A_ThisHotkey, {Title: int-1 })
	neutron.wnd.Eval("highlightNextDiv(" int-1 ")")
}
highlightPrevDiv() {
	global int, neutron
	(int < 0 ? 0 : int)
	int--
	; Notify().AddWindow(A_ThisHotkey, {Title: int })
	neutron.wnd.Eval("highlightPrevDiv(" int ")")
}
mscEscapeKey(neutron) {
	neutron.Destroy()
	ExitApp
}
oDir_PathsTrue(event) {
	global oDirs
	return (oDirs.HasKey(event) || oDirs.HasKey("dir " MasterScriptCommands) ? true : false)
}
resetMSCWnd(neutron) {
	global int
	if (int >= 0)
		neutron.wnd.Eval("resetHighlightedDiv(" int ")")
	neutron.wnd.Eval("resetSearchAttributes()")
	neutron.wnd.Eval("$('#search').val('')")
	neutron.wnd.Eval("$('.mscIcon').css({'animation':'none'})")
	neutron.Hide()
	int := 0 
} 
runIEChooser(neutron) { ; with F12 open debug options for neutron
	Run % A_ComSpec "\..\F12\IEChooser.exe",
	WinWaitActive, ahk_exe IEChooser.exe
	WinSet, AlwaysOnTop, On, ahk_exe IEChooser.exe
}
setMSCIcons(wndUID) { ; Set Icon of Script in Taskbar & Tray Icon if Swal exists
	If WinExist(wndUID) {
		Ico   := A_LineFile "\..\Icon.ico"
		Menu, Tray, Icon, % Ico, 1 ; Set Icon of Script in Taskbar
		hIcon := DllCall( "LoadImage", UInt,0, Str,Ico, UInt,1, UInt,0, UInt,0, UInt,0x10 )
		SendMessage, 0x80, 0, hIcon ,, % wndUID  ; Small Icon
		SendMessage, 0x80, 1, hIcon ,, % wndUID  ; Big Icon
	}
}
toggleMSC(neutron) {
	global wndToggle
		 , wndPos
		 , wndUID
	DetectHiddenWindows, Off
	If WinExist(wndUID)
		wndToggle := 1
	else
		wndToggle := 0
	Switch wndToggle
	{
		Case 0:
		{
			neutron.Show(wndPos)
			neutron.wnd.Eval("$('#search').focus()")
			; neutron.wnd.Eval("$('.mscIcon').playKeyframe('12s linear infinite')") ; not supported with Legacy JS
			neutron.wnd.Eval("$('.mscIcon').css({'animation-delay': '4s;','animation':'mscIconSpin 12s linear infinite;'})")
			wndToggle := 1
		}
		Case 1:
		{
			resetMSCWnd(neutron)
			; neutron.wnd.Eval("$('.mscIcon').pauseKeyframe()") ; not supported with Legacy JS
			wndToggle := 0
		}
	}
}
updateWndSize(neutron, ByRef wndW, ByRef wndH, ByRef mscInput) {
	mscInput != "" ? wndH := 290+137 : wndH := 137
	; Notify().AddWindow(wndH, {Title:mscInput})
	; Swal.toast(wndH,{title:mscInput})
	neutron.Show("h" wndH+10)
}

; NOTE: Have to use a goSub because their are functions within the Case statements. Otherwise errors out with nested functions
setCommands:
#Include Includes\testCommands.ahk
; #Include Includes\UserCommands.ahk
return

; NOTE: Original MSC Functions

RunReload:
return


MSC_Title(MasterScriptCommands, Dir){
	Static oArray := []
	Loop, read, % Dir
	{
		StringCaseSense, Off 
		If SubStr(A_LoopReadLine, 1, 1) != ";" 								;~ Do not display commented commands
		{
			If A_LoopReadLine contains MasterScriptCommands =		
			{
				
				Trimmed 	:= StrSplit(A_LoopReadLine,"MasterScriptCommands = ") 	;~ Find each line with a "command =" in it
				Comment 	:= StrSplit(A_LoopReadLine, "`;~ ")	
				;~ oData 	.= SubStr(Trimmed.2,1,3) A_Space SubStr(Trimmed.2,7) 		;~ Trim line down to just command + comment
				;~ oData 	.= "`n" 										;~ Breaking each command into a new line
				oArray.Push(StrSplit(Trimmed.2,Chr(34)).2)					;~ Show Command 3 Digit Number				
				oArray.Push(Comment.2)									;~ Only show Title no ";~"
			}
			
		}
	}
	for a, b in oArray { 												;~ For Next Loop
		if (b = MasterScriptCommands)
		{
			Return oArray[A_Index+1]
		}
	}
}

gui_search(url) {
	global MSC_Search
	MSC_Search.Push(url)
}

gui_search_add_elements:
for Key, Value in MSC_Search {
	DMD_Run(StrReplace(Value, "REPLACEME", uriEncode(gui_SearchEdit)))
	Search_Title := RegExReplace(Value, "s).*?(\d{12}).*?(?=\d{12}|$)", "$1`r`n")
	If (Title = "" ? Title := Search_Title : Title := Title)	
		t(gui_SearchEdit, {time:3000,stack:1}) 
}
MSC_Search := [] ; reset for adding search urls into MSC_Search
return
/*
	; Allow normal CapsLock functionality to be toggled by Alt+CapsLock:
	!CapsLock::
	GetKeyState, capsstate, CapsLock, T ;(T indicates a Toggle. capsstate is an arbitrary varible name)
	if capsstate = U
		SetCapsLockState, AlwaysOn
	else
		SetCapsLockState, AlwaysOff
	return
*/

levenshtein_distance( s, t )
{
  n := strlen(s)
  m := strlen(t)

  if( n != 0 and m != 0 )
  {

    m++
    n++
    d0 = 0 ; Because A_index starts at 1, we emulate a for loop by hardcoding the first repetition

    Loop, %n%
      d%A_Index% := A_Index

    ; I would emulate the first repetition here, but it just sets d0 = 0
    Loop, %m%
    {
      temp1 := A_Index * n
      d%temp1% := A_Index
    }
    B_Index := 0
    Loop, %n%
    {
      B_Index++
      Loop, %m%
      {
        temp1 := B_Index
        temp2 := A_Index
        StringMid, tempA, s, temp1, 1
        StringMid, tempB, t, temp2, 1
        ;MsgBox, Comparing %tempA% and %tempB%
        if( tempA == tempB )
          cost := 0
        else
          cost := 1
        temp1 := A_Index * n + B_Index
        temp2 := (A_Index - 1) * n + B_Index
        temp3 := A_Index * n + B_Index - 1
        temp4 := (A_Index - 1) * n + B_Index - 1
        d%temp1% := minimum( d%temp2%+1 , d%temp3%+1 , d%temp4%+cost )
      } ;Loop, m
    } ;Loop, n
    temp1 := n*m - 1
    distance := d%temp1%
    return distance
  } ;if
  else
    return -1
}

minimum( a, b, c )
{
	min := a
	if(b<min)
		min := b
	if(c<min)
		min := c
	return min
}


; A function to escape characters like & for use in URLs.
uriEncode(str) {
	f = %A_FormatInteger%
	SetFormat, Integer, Hex
	If RegExMatch(str, "^\w+:/{0,2}", pr)
		StringTrimLeft, str, str, StrLen(pr)
	StringReplace, str, str, `%, `%25, All
	Loop
		If RegExMatch(str, "i)[^\w\.~%/:]", char)
			StringReplace, str, str, %char%, % "%" . SubStr(Asc(char),3), All
	Else Break
		SetFormat, Integer, %f%
	Return, pr . str
}

MoveWindowtoCenter(Window:="A"){
	WinGet, winState, MinMax, %Window%
	If (winState = -1) {
		WinRestore % Window
		WinActivate
		WinExist(Window)
		WinGetPos,,, sizeX, sizeY
		WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
	}
	
	else if (winState = 1) {
		WinRestore % Window
		WinExist(Window)
		WinGetPos,,, sizeX, sizeY
		WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
		WinMaximize
	}
	
	else if (winState = 0) {
		WinExist(Window)
		WinActivate
		WinGetPos,,, sizeX, sizeY
		WinMove, (A_ScreenWidth/2)-(sizeX/2), (A_ScreenHeight/2)-(sizeY/2)
	}
	Return
}

Command_Gui(Info){
	Static VectorImage:= ComObjCreate("WIA.Vector"),wb,Images:=[]
	for a,b in {Title:"",Background:"#666666",Color:"#FFFFFF",SleepTimer:"-1500",Icon:"",Gradient:""}
		if(!Info[a])
			Info[a]:=b
	if((!Img:=Images[Info.Icon])&&Info.Icon){
		IniRead, Img, C:\AHK Scripts\_Master Script\Resources\Icons.ini, Icons,% Info.Icon,0
		Images[Info.Icon]:=Img
	}
	Gui,Destroy
	Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow hwndCGUI			;~ avoids a taskbar button and an alt-tab menu item.
	Gui,Margin,0,0
	IE:=FixIE(11)
	Gui,Add,ActiveX,vwb w400 h64 hwndID,mshtml
	FixIE(IE)
	Background:=Info.Background,Color:=Info.Color,Gradient:=(Info.Gradient?"background: linear-gradient" Info.Gradient:""),Title:=Info.Title
	HTML=
	(
	<body style='margin:0px; background-color:%Background%;color:%Color%;font-size: 42.66px; font-family:MS Shell Dlg'>
		<div style='width:%A_ScreenWidth%px;%Gradient%;'>
			<img align='middle'>
				<span style='Margin-Left:8px'>%Title%</span>
			</img>
		</div>
	</body>
	)
	wb.Navigate("about:" HTML)
	while(wb.ReadyState!=4)
		Sleep,10
	;~ m(wb.Document.GetElementsByTagName("div").item[0].OuterHTML)
	/*
		Gui, Color, % Trim(GUIColor,"#") 							;~ Change Color of Gui
		Gui, Font, s32 										;~ Set a large font size (32-point).
		Gui,Add,Text,% "x+15 yp+7 c" Trim(GUITextColor,"#"),%GUITitle%   ;~ Change color of Text | GUITitle "x+m creates new position based off previous control plus the margin"
	*/
	;~ m(wb.Document.Body.OuterHTML)
	wb.Document.GetElementsByTagName("Img").Item[0].src:="data:image/png;base64," Img
	Width:=wb.Document.GetElementsByTagName("span").Item[0].GetBoundingClientRect().Width
	wb.Document.GetElementsByTagName("Div").Item[0].Style.Width:=Width+84
	GuiControl, Move, %ID%, % "w" Width+84
	SysGet,Monitor,MonitorWorkArea
	Y:=MonitorBottom-104,X:=MonitorLeft
	Gui, Show, % "x" X " y882 y" Y " w" Width+84 " NoActivate"  		;~ NoActivate avoids deactivating the currently active window.
	SetTimer, Gui_Close, % Info.Sleeptimer 							;~ Sets timer until GUI disappears
	Return
}

Gui_Close(){
	Gui, Destroy
	Return
}

Base64ToComByteArray(B64){  									; By SKAN / Created: 21-Aug-2017 / Topic: goo.gl/dyDxBN 
	static CRYPT_STRING_BASE64:=0x1
	local Rqd:=0,BLen:=StrLen(B64),ByteArray:=""
	if(DllCall("Crypt32.dll\CryptStringToBinary","Str",B64,"UInt",BLen,"UInt",CRYPT_STRING_BASE64,"UInt",0,"UIntP",Rqd,"Int",0,"Int",0))
		ByteArray:=ComObjArray(0x11,Rqd),DllCall( "Crypt32.dll\CryptStringToBinary", "Str",B64, "UInt",BLen, "UInt",CRYPT_STRING_BASE64, "Ptr",NumGet( ComObjValue( ByteArray ) + 8 + A_PtrSize ), "UIntP",Rqd, "Int",0, "Int",0 )
	return ByteArray
}

FixIE(Version=0){
	static Key:="Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_BROWSER_EMULATION",Versions:={7:7000,8:8888,9:9999,10:10001,11:11001}
	Version:=Versions[Version]?Versions[Version]:Version
	if(A_IsCompiled)
		ExeName:=A_ScriptName
	else
		SplitPath,A_AhkPath,ExeName
	RegRead,PreviousValue,HKCU,%Key%,%ExeName%
	if(!Version)
		RegDelete,HKCU,%Key%,%ExeName%
	else
		RegWrite,REG_DWORD,HKCU,%Key%,%ExeName%,%Version%
	return PreviousValue
}

Focus_Send(Info){
	for a,b in {Window:"",Keys:"",Title:"",Background:"#666666",Color:"White",TitleMatchMode:"Fast",Focus:"0",Icon:"",Gradient:"",Sleep:"-1500"}
		if(!Info[a])
			Info[a]:=b
	Static Mode:=A_TitleMatchMode
	if(Info.Focus){
		WinGetActiveTitle, FocusWindow
	}
	if(Info.TitleMatchMode){
		SetTitleMatchMode, % Info.TitleMatchMode
	}	
	if(WinExist(Info.Window)){
		WinActivate,% Info.Window
		WinWaitActive,% Info.Window
		if(Info.Title){
			Command_Gui({Title:Info.Title,Background:Info.Background,Color:Info.Color,SleepTimer:Info.Sleep,Icon:Info.Icon,Gradient:Info.Gradient})
		}		
		if(Info.Keys){
			Send,% Info.Keys
		}
	}
	SetTitleMatchMode,%Mode% ;~ Resets TitleMatchMode	
	if(Info.Focus)
		WinActivate,%FocusWindow%
	Return
}

AHKPastebin(Content,Name:="",Notify:=1,Run:=0){
	HTTP:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
	HTTP.Open("POST","https://p.ahkscript.org/", False)
	HTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	HTTP.Send("code=" UriEncode(Content) "&name=" UriEncode(Name) "&channel=#ahkscript")
	if HTTP.Status()!=200{ ;~ If not okay
		MsgBox Something went wrong
		Return
	}
	If (Notify)
		Notify().AddWindow(Content,{Time:3000,Icon:300,Background:"0x1100AA",Icon:14,Title:"Added to pastebin at: " HTTP.Option(1),TitleSize:18,size:14,TitleColor:"0xFF0000"})
	If (Run)
		Run % HTTP.Option(1) ;~ URL
	Return HTTP.Option(1) ;~ Return URL
}

Toggle_App(app, location) 
{
	if WinExist(app)   
	{
		if !WinActive(app)
			WinActivate
		else
			WinMinimize
	}
	else if location != ""
		Run, % location
}

st_columnize(data, delim="csv", justify=1, pad=" ", colsep=" | ")
{		
	widths:=[]
	dataArr:=[]
	
	if (instr(justify, "|"))
		colMode:=strsplit(justify, "|")
	else
		colMode:=justify
	; make the arrays and get the total rows and columns
	loop, parse, data, `n, `r
	{
		if (A_LoopField="")
			continue
		row:=a_index
		
		if (delim="csv")
		{
			loop, parse, A_LoopField, csv
			{
				dataArr[row, a_index]:=A_LoopField
				if (dataArr.maxindex()>maxr)
					maxr:=dataArr.maxindex()
				if (dataArr[a_index].maxindex()>maxc)
					maxc:=dataArr[a_index].maxindex()
			}
		}
		else
		{
			dataArr[a_index]:=strsplit(A_LoopField, delim)
			if (dataArr.maxindex()>maxr)
				maxr:=dataArr.maxindex()
			if (dataArr[a_index].maxindex()>maxc)
				maxc:=dataArr[a_index].maxindex()
		}
	}
	; get the longest item in each column and store its length
	loop, %maxc%
	{
		col:=a_index
		loop, %maxr%
			if (strLen(dataArr[a_index, col])>widths[col])
				widths[col]:=strLen(dataArr[a_index, col])
	}
	; the main goodies.
	loop, %maxr%
	{
		row:=a_index
		loop, %maxc%
		{
			col:=a_index
			stuff:=dataArr[row,col]
			len:=strlen(stuff)
			difference:=abs(strlen(stuff)-widths[col])
			
			; generate a repeating string about the length of the longest item
			; in the column.
			loop, % ceil(widths[col]/((strlen(pad)<1) ? 1 : strlen(pad)))
				padSymbol.=pad
			
			if (isObject(colMode))
				jmustify:=colMode[col]
			; justify everything correctly.
			; 3 = center, 2= right, 1=left.
			if (strlen(stuff)<widths[col])
			{
				if (justify=3)
					stuff:=SubStr(padSymbol, 1, floor(difference/2)) . stuff
					. SubStr(padSymbol, 1, ceil(difference/2))
				else
				{
					if (justify=2)
						stuff:=SubStr(padSymbol, 1, difference) stuff
					else ; left justify by default.
						stuff:= stuff SubStr(padSymbol, 1, difference) 
				}
			}
			out.=stuff ((col!=maxc) ? colsep : "")
		}
		out.="`r`n"
	}
	stringTrimRight, out, out, 2 ; remove the last blank newline
	return out
}

RemoveExtraSpaces(string) {
	Return Trim(RegExReplace(string, "\h\K\h+"))
}

/*
	DMD_RunShortcut(Program, Icon:="C:\Program Files\AutoHotkey\AutoHotkey.exe", IconNumber:=2){
		SplitPath, Program, Name, Dir, EXT, NNE, Drive 												; for each item in array, split the path to corresponding variables
		ShortcutDir := "C:\AHK Scripts\_DMD Scripts\Run Shortcuts"
		Shortcut    := ShortcutDir . "\" . NNE . ".lnk"
		UI_Path     := (A_PtrSize != 4 ? "C:\Program Files\AutoHotkey\AutoHotkeyU64_UIA.exe" : "C:\Program Files\AutoHotkey\AutoHotkeyA32_UIA.exe") ;~ If AHK in 64 than run 64, else run 32 bit
		If FileExist(Shortcut){
			FileGetShortcut, % Shortcut, vTarget, vDir, vArgs, vDesc, vIcon, vIconNum, vRunState
			if StrReplace(vArgs, chr(34), "") != Program ;~ Does the path = the destintation of the shortcut (removing the double quotes from command)
			{
				FileDelete, % Shortcut
				While FileExist(Shortcut) ;~ Wait for file to be removed before creating
					Sleep, 100			
				FileCreateShortcut, % UI_Path, % Shortcut, % Dir, % Chr(34) Program Chr(34),, % Icon,, % IconNumber		; Shortcut UI has to go first to tell it to launch UI on to target Shortcut
				While !FileExist(Shortcut) 																;~ Wait til file exists to Run
					Sleep, 100
			}
			Run, % Shortcut
			Return 																			;~ Makes it so if the file exist the script ends here, otherwise it'll continue below
		}
		FileCreateShortcut, % UI_Path, % Shortcut, % Dir, % Chr(34) Program Chr(34),, % Icon,, % IconNumber		; Shortcut UI has to go first to tell it to launch UI on to target Shortcut
		While !FileExist(Shortcut) 																;~ Wait til file exists to Run
			Sleep, 100
		Run, % Shortcut
	}
	
*/
MSC_GetGuiSize(){
	WinGetPos, x, y, w, h, MasterScriptCommands
	Return {x:x,y:y,w:w,h:h}
}

MSC_KeybindFocus(Enter := 0){
	Global GUI_Intel_Edit_Field, QueryEditField
	ControlFocus, , ahk_id %GUI_Intel_Edit_Field%
	Gui, Submit, NoHide
	if(Enter == 1)
		SendInput, {Enter}
	ControlFocus, , ahk_id %QueryEditField%
}

getFokus(){
	GuiControlGet, hmm, Focus
	GuiControlGet, out, Hwnd , % hmm
	return out
}

HttpQuery(url) {
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", url, true)
	whr.Send()
	whr.WaitForResponse()
	status := whr.status
	if (status != 200)
		throw "HttpQuery error, status: " . status
	Return whr.ResponseText
}

EncodeDecodeURI(str, encode := true, component := true) {
	static Doc, JS
	if !Doc {
		Doc := ComObjCreate("htmlfile")
		Doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
		JS := Doc.parentWindow
	}
	Return JS[ (encode ? "en" : "de") . "codeURI" . (component ? "Component" : "") ](str)
}