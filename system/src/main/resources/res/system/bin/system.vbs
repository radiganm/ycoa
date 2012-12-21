' @file     system.vbs
' @author   Mac Radigan
' @version  $Id$
Option Explicit
Set WshShell = WScript.CreateObject("WScript.Shell")
Dim commandLine = "java -jar " & WScript.Path & "\..\" & "system.jar" & Join(Wscript.Arguments, "")
WshShell.Run(commandLine)
WScript.Quit
' *EOF*
