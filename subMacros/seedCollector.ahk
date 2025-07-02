#Requires AutoHotkey v2.0

#Include ..\main.ahk

collectSeeds() {
    Send("\")
    Sleep(100)
    Send("{S}")
    Sleep(100)
    Send("{S}")
    Sleep(100)
    Send("{{Enter}}")
    
}