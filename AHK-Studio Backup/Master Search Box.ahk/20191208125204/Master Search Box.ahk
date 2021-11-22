; Created by Asger Juul Brunshøj

#Include <Default_Settings>

SetCapsLockState, AlwaysOff

; #InstallKeybdHook

;-------------------------------------------------------
; AUTO EXECUTE SECTION FOR INCLUDED SCRIPTS
; Scripts being included need to have their auto execute
; section in a function or subroutine which is then
; executed below.
;-------------------------------------------------------
Gosub, gui_autoexecute
;-------------------------------------------------------
; END AUTO EXECUTE SECTION
return
;-------------------------------------------------------

; Load the GUI code
#Include %A_ScriptDir%\Includes\GUI.ahk

; General settings
#Include %A_ScriptDir%\Includes\Miscellaneous.ahk

;~ User Commands
#Include %A_ScriptDir%\Includes\UserCommands.ahk
