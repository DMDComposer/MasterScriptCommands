#SingleInstance, Force ;Limit one running version of this script
;~ #Warn ; Enable warnings to assist with detecting common errors.
#NoEnv ;Avoids checking empty variables to see if they are environment variables
#KeyHistory 10 ;Sets the maximum number of keyboard and mouse events displayed
#MaxThreads 5 ;Sets the maximum number of simultaneous threads.
;~ #MaxMem 4095 ;#MaxMem Megabytes
A_Enter:="r'n" ;Create my own Line break variable
A_Return:="r'n" ;Create my own line break variable
;~ DetectHiddenWindows, On ;ensure can find hidden windows
ListLines On ;on helps debug a script-this is already on by default
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetBatchlines -1 ;run at maximum CPU utilization
SetTitleMatchMode 2 ;Sets the matching behavior of the WinTitle parameter in commands such as WinWait- 2 is match anywhere
SetTitleMatchMode Fast ; This is the default behavior. Performance may be substantially better than Slow, but certain types of controls are not detected. For instance, text is typically detected within Static and Button controls, but not Edit controls, unless they are owned by the script.
;~ SetFormat, IntegerFast, d
;~ SetFormat, FloatFast , .2
SetKeyDelay, -1, -1, -1 ;Sets the delay that will occur after each keystroke sent by Send and ControlSend.
SetMouseDelay, -1 ;Sets the delay that will occur after each mouse movement or click.
SetWinDelay, 0 ;Sets the delay that will occur after each windowing command, such as WinActivate
SetControlDelay, © ;Sets the delay that will occur after each control -modifying command.
SetDefaultMouseSpeed, 0 ;Sets the mouse speed that will be used if unspecified in Click and MouseMove/ClLick/Drag.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.