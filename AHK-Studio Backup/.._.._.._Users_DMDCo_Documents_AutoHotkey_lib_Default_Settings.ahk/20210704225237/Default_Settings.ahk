;~ #Warn                    ;Lets you know if you have any variables or functions mispelled or not in use
#SingleInstance, Force      ;Limit one running version of this script
#NoEnv                      ;Avoids checking empty variables to see if they are environment variables
#KeyHistory 10              ;Sets the maximum number of keyboard and mouse events displayed
#MaxThreads 5               ;Sets the maximum number of simultaneous threads.
#MaxMem 4095                ;#MaxMem Megabytes
SetBatchlines -1            ;run at maximum CPU utilization
SetWorkingDir %A_ScriptDir% ;Ensures a consistent starting directory.
SendMode Input              ;Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode 2         ;Sets the matching behavior of the WinTitle parameter in commands such as WinWait- 2 is match anywhere
SetTitleMatchMode Fast      ;This is the default behavior. Performance may be substantially better than Slow, but certain types of controls are not detected. For instance, text is typically detected within Static and Button controls, but not Edit controls, unless they are owned by the script.
SetKeyDelay, -1, -1, -1     ;Sets the delay that will occur after each keystroke sent by Send and ControlSend.
SetMouseDelay, -1           ;Sets the delay that will occur after each mouse movement or click.
SetWinDelay, 0              ;Default 100 -- Sets the delay that will occur after each windowing command, such as WinActivate: this can cause some Sendinputs / controlsends to be buggy, try disabled -DMD
SetControlDelay, 0          ;Sets the delay that will occur after each control -modifying command.
SetDefaultMouseSpeed, 0     ;Sets the mouse speed that will be used if unspecified in Click and MouseMove/ClLick/Drag.
;~ DetectHiddenWindows, On  ;ensure can find hidden windows -- Disable by default as some scripts won't open and utilize winmove -DMD
;~ ListLines On ;on helps debug a script-this is already on by default
;~ #Warn ; Enable warnings to assist with detecting common errors.
;~ SetFormat, IntegerFast, d
;~ SetFormat, FloatFast , .2
RegRead,A_Dropbox,HKEY_CLASSES_ROOT,CLSID\{E31EA727-12ED-4702-820C-4B6445F28E1A}\Instance\InitPropertyBag,TargetFolderPath ;~ Getting Dropbox Location
EnvGet, A_UserProfile, UserProfile
EnvGet, A_ProgramFiles64, PROGRAMFILES
if (A_PtrSize == 4)
	A_ProgramFiles64 := StrReplace(A_ProgramFiles64, " (x86)", "") ;~ Replace (x86) in string
;~ Global variables
Global A_UserProfile, A_ProgramFiles64, A_Dropbox, SN:=50, A_Return:=A_Enter:="r'n"    ;Create my variables
