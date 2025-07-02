#Requires AutoHotkey v2.0

#Include ..\main.ahk

collectSeeds() {
    Send("\")
    Sleep(100)
    Send("{D}")
    Sleep(100)
    Send("{D}")
    Sleep(100)
    Send("{{Enter}}")
    
}