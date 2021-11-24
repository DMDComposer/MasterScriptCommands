DetectHiddenWindows, Off ; Ensure Window is off unless specificed by command. Important for certain AHK scripts for this to be off
; A note on how this works:
; The function name "mscSearchUrls()"
; What you actually specify as the parameter value is a command to Run. It does not have to be a URL.
; Before the command is Run, the word REPLACEME is replaced by your input.
; It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
; So what this does is that it Runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.	

Switch MasterScriptCommands
{
	Case "test A": { ; Testing area
		Notify().AddWindow(getMSCTitle(MasterScriptCommands, DIR), {Title:"Title"})
	}
}