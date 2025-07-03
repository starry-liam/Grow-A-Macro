#Requires AutoHotkey v2.0

#Include ..\main.ahk

seedQuantity := [24, 24, 18, 12, 12, 8, 8, 8, 8, 8, 6, 6, 6, 6, 4, 4, 4, 2]

collectSeeds(amount) {
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
        collectSeeds(seedQuantity[i])
    }
    else {
        if (i <= 17) {
            Send "s"
        }
    }
}