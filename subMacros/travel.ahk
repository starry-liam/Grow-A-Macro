#Requires AutoHotkey v2.0
#Include ..\main.ahk
centerX := A_ScreenWidth / 2
centerY := A_ScreenHeight / 2
; mouse pre gear click
xRMPG := (800-960)/960
xMPG := centerX + (xRMPG * centerX)
yRMPG := (150-540)/540
yMPG := centerY + (yRMPG * centerY)

yRMPGO := (160-540)/540
yMPGO := centerY + (yRMPGO * centerY)

; mouse into gear click
xRMIG := (1100-960)/960
xMIG := centerX + (xRMIG * centerX)
yRMIG := (525-540)/540
yMIG := centerY + (yRMIG * centerY)

xRMIGO := (1200-960)/960
xMIGO := centerX + (xRMIGO * centerX)

; mouse into settings
xRMIS := (800-960)/960
xMIS := centerX + (xRMIS * centerX)
yRMIS := (150-540)/540
yMIS := centerY + (yRMIS * centerY)

yRMISO := (160-540)/540
yMISO := centerY + (yRMISO * centerY)
; mouse toggling camera
xRMTC := (1000-960)/960
xMTC := centerX + (xRMTC * centerX)
yRMTC := (300-540)/540
yMTC := centerY + (yRMTC * centerY)

xRMTCO := (1010-960)/960
xMTCO := centerX + (xRMTCO * centerX)


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
    if currentIndex == 3 {
        return
    }
    else if currentIndex == 2 {
        MouseMove(xMPG, yMPG)
        Sleep 100
        MouseMove(xMPG, yMPGO)
        Sleep 500
        Send (slotOptions[slotIndex])
        Sleep 1000
        Click "Left"
        Sleep 1000
        Send "e"
        Sleep 3000
        MouseMove(xMIG, yMIG)
        Sleep 100
        MouseMove(xMIGO, yMIG)
        Sleep 100
        Click "Left"
        Sleep 3000
        Send "\"
        Sleep 100
        Send "s"
        Sleep 100
        Send "s"
    }
    else {
        gardenTravel()
        Sleep 100
        Send "{s down}"
        Sleep 750
        Send "{s up}"
        Sleep 100
        Send "{a down}"
        Sleep 15750
        Send "{a up}"
        Sleep 100
        Send "{s down}"
        Sleep 1900
        Send "{s up}"
        Sleep 100
        Send "e"
        Sleep 3000
        MouseMove(xMIG, yMIG)
        Sleep 100
        MouseMove(xMIGO, yMIG)
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
    MouseMove(xMIS, yMIS)
    Sleep 100
    MouseMove(xMIS, yMISO)
    Sleep 500
    Click "Left"
    Sleep 100
    MouseMove(xMTC, yMTC)
    Sleep 100
    MouseMove(xMTCO, yMTC)
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