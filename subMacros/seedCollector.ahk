#Requires AutoHotkey v2.0

#Include ..\main.ahk

seedQuantity := [24, 24, 18, 12, 12, 8, 8, 8, 8, 8, 6, 6, 6, 6, 4, 4, 4, 2]
gearQuantity := 10
i := 1
g := 1

collect(amount) {
    Send "{Enter}" 
    Sleep 100
    Send "s"
    Sleep 100
    loop amount {
        Send "{Enter}"
        Sleep 100
    }
    Send "w"
    Sleep 100
    Send "{Enter}"
    Sleep 100
    Send "s"
    Sleep 100
}

seedCollector(i) {
    global seedStates, seedQuantity

    if (i >= 19) {
            
            loop 19 {
                send "w"
                Sleep 100
            }
            Send "{Enter}"
            Send "\"
            
        }
    else if seedStates[i] {
        collect(seedQuantity[i])
    }
    else {
        if (i <= 17) {
            Send "s"
        }
    }
}

gearCollector(g) {
    global gearStates, gearQuantity
    if (g >= 13) {
        loop 13 {
            Send "w"
            Sleep 100
        }
        Send "{Enter}"
        Send "\"
    }
    else if (gearStates[g]) {
        collect(gearQuantity)
    }
    else if g <= 12{
        Send "s"
        Sleep 100
    }
}

masterCollect() {
    global i, g
    seedTravel()
        loop 19 {
            if (i > 18) {
                i := 19
            }
            seedCollector(i)
            i++

        } 
        gearTravel()
        loop 13 {
            if (g > 13) {
                g := 14
            }
            else {
                gearCollector(g)
                g++
            }
        }
}