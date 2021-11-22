; Allow normal CapsLock functionality to be toggled by Alt+CapsLock:
!CapsLock::
    GetKeyState, capsstate, CapsLock, T ;(T indicates a Toggle. capsstate is an arbitrary varible name)
    if capsstate = U
        SetCapsLockState, AlwaysOn
    else
        SetCapsLockState, AlwaysOff
    return


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
		IniRead, Img, Resources\Icons.ini, Icons,% Info.Icon,0
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