#Requires AutoHotkey v2.0
#Include ..\main.ahk




seedTravel() {
    gardenTravel()
    Send "\"
    Sleep 100
    Send "s"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "\"
    Send "e"
    Sleep 3000
    Send "\"
    Sleep 100
    Send "s"
    Sleep 100
    Send "s"
}
gearTravel() {
    if currentIndex == 2 {
        MouseMove 800, 150, 10
        Sleep 100
        MouseMove 800, 160, 10
        Sleep 500
        Send "2"
        Sleep 1000
        Click "Left"
        Sleep 1000
        Send "e"
        MouseMove 1100, 525, 10
        Sleep 100
        Click "Left"
        Sleep 3000
        Send "\"
        Sleep 100
        Send "s"
        Sleep 100
        Send "s"
    }
}
gardenTravel() {
    Send "\"
    Sleep 100
    Send "s"
    Sleep 100
    Send "d"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "\"
}

camAlign(){
    gardenTravel()
    Sleep 100
    Send "{s down}"
    Sleep 750
    Send "{s up}"
    Sleep 100
    Send "{d down}"
    Sleep 1500
    Send "{d up}"
    Sleep 100
    Send "{w down}"
    Sleep 950
    Send "{w up}"
    Sleep 100
    toggleCamera()
    Sleep 1000
    toggleCamera()
    Sleep 1000
    gardenTravel()

}
toggleCamera() {
    Send "{Escape}"
    Sleep 100
    MouseMove 800, 150, 10
    Sleep 100
    MouseMove 800, 160, 10
    Sleep 500
    Click "Left"
    Sleep 100
    MouseMove 1000, 300, 10
    Sleep 100
    MouseMove 1010, 300, 10
    Sleep 100
    Click "Left"
    Sleep 100
    Click "Left"
    Sleep 100
    Send "{Escape}"
}
zoomAlign() {
    zoom(1, 25)
    Sleep 500
    zoom(-1, 10)
}
zoom(dir, steps){
    if (dir == 1){
        loop steps {
            Send "{WheelUp}"
            Sleep 100
        }
    } else if (dir == -1) {
        loop steps {
            Send "{WheelDown}"
            Sleep 100
        }
    }
}
align(){
    camAlign()
    Sleep 1000
    zoomAlign()
}