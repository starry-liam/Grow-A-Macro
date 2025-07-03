#Requires AutoHotkey v2.0
#Include ..\main.ahk




seedTravel() {
    MouseMove 700, 100, 10
    Sleep 100
    MouseMove 710, 100, 10
    Sleep 100
    Click "Left"
    Sleep 100
    MouseMove 700, 400, 10
    Sleep 100
    MouseMove 710, 400, 10
    Sleep 100
    Send "e"
    Sleep 3000
    Send "{\}"
    Sleep 500
    Send "s"
    Sleep 500
    Send "s"
}
gearTravel() {
    if currentIndex == 2 {
        Send "2"
        Sleep 1000
        Click "Left"
        Sleep 1000
        Send "e"
    }
}