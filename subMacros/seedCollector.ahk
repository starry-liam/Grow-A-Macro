#Requires AutoHotkey v2.0

#Include ..\main.ahk

seedQuantity := [24, 24, 18, 12, 8, 8, 8, 8, 8, 6, 6, 6, 6, 4, 4, 4, 2]

collectSeeds(amount) {
    loop amount {
        Send "{Enter}"
        Sleep 1000
    }
}
seedCollector(i) {
    global seedStates, seedQuantity

    if seedStates[i] {
        Send "{Enter}"
        Sleep 1000
        Send "s"
        Sleep 1000
        collectSeeds(seedQuantity[i])
        Send "w"
        Sleep 1000
        Send "{Enter}"
        Sleep 1000
    }
    else {
        Send "s"
        Sleep 1000
    }
}