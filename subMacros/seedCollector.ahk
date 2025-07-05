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

    if (i >= seedLabels.Length+1) {
            
        exitMenu(exitIndex, seedLabels.Length+1)
            
        }
    else if seedStates[i] {
        collect(seedQuantity[i])
    }
    else {
        if (i <= seedLabels.Length-1) {
            Send "s"
        }
    }
}

gearCollector(g) {
    global gearStates, gearQuantity
    if (g >= gearLabels.Length) {
        exitMenu(exitIndex, gearLabels.Length)
    }
    else if (gearStates[g]) {
        Sleep 100
        collect(gearQuantity)
    }
    else if (!gearStates[g]) {
        if (g <= gearLabels.Length-1) {
            Send "s"
            Sleep 100
        }
    }
}

masterCollect() {
    global i, g
        seedTravel()
        loop seedLabels.Length + 1 {
            if (i > seedLabels.Length) {
                i := seedLabels.Length + 1
            }
            seedCollector(i)
            i++

        } 
        gearTravel()
        Sleep 1000
        loop gearLabels.Length {
            if (g > gearLabels.Length) {
                g := gearLabels.Length + 1
            }
            else {
                gearCollector(g)
                g++
            }
        }
        gardenTravel()
}