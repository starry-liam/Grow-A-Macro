; AutoHotkey v2.0 version of GrowAMacro GUI
#Requires AutoHotkey v2.0
#SingleInstance Force

#Include subMacros\seedCollector.ahk
#Include subMacros\travel.ahk
; Global state
global toggle := false
global running := false

seedLabels := ["Carrots", "Strawberries", "Blueberries", "Tomatoes", "Califlower", "Watermelon", "Rafflesia", "Green Apple", "Avocado", "Banana", "Pineapple", "Kiwi", "Bellpepper", "Pricly Pear", "Loquats", "Feijoa", "Pitcher Plant", "Sugar Apple"]
seedStates := Map()
Loop seedLabels.Length
    seedStates[A_Index] := true

gearLabels := ["Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Magnifying Glass", "Tanning Mirror", "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool", "Friendship Pot"]
gearStates := Map()
Loop gearLabels.Length
    gearStates[A_Index] := false

btnWidth := 130
btnHeight := 26
padding := 8
cols := 3
gearButtons := [] 
seedButtons := []

options := ["Walk", "Recall Wrench", "Disabled"]
slotOptions := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
currentIndex := 2  ; Start with the first option
slotIndex := 2  ; Start with the first slot

mainGui := Gui()
mainGui.SetFont("s9", "Segoe UI")

tab := mainGui.Add("Tab3", "x10 y10 w450 h275", ["Main", "Seeds", "Gear"])
tab.UseTab(0) ; Important: reset first

; Main tab buttons
tab.UseTab(1)
mainGui.Add("Button", "x95 y240 w80 h20", "[F1] Start").OnEvent("Click", (*) => Start())
mainGui.Add("Button", "x185 y240 w80 h20", "[F2] Toggle").OnEvent("Click", (*) => Toggles())
mainGui.Add("Button", "x275 y240 w80 h20", "[F3] Stop").OnEvent("Click", (*) => Stop())

leftBtn := mainGui.Add("Button", "x145 y170 w30", "<")
leftBtn.OnEvent("Click", (*) => ChangeOption(-1))

leftBtn := mainGui.Add("Button", "x145 y140 w30", "<")
leftBtn.OnEvent("Click", (*) => ChangeSlotOption(-1))

mainGui.Add("Text", "x10 y175 w150 Center", "Gear Travel Method:")

mainGui.Add("Text", "x10 y145 w150 Center", "Recall Wrench Slot:")

optionDisplay := mainGui.Add("Text", "x165 y175 w120 Center vOptionLabel", options[currentIndex])
optionText := mainGui.Add("Text", "x300 y175 w150 Center", "(Recommended)")

SlotOptionDisplay := mainGui.Add("Text", "x165 y145 w120 Center vSlotOptionLabel", slotOptions[slotIndex])

rightBtn := mainGui.Add("Button", "x275 y170 w30", ">")
rightBtn.OnEvent("Click", (*) => ChangeOption(1))

rightBtn := mainGui.Add("Button", "x275 y140 w30", ">")
rightBtn.OnEvent("Click", (*) => ChangeSlotOption(1))

; Seed tab buttons
tab.UseTab(2)
Loop seedLabels.Length {
    idx := A_Index
    label := seedLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 30 + (btnWidth + padding) * col
    y := 55 + (btnHeight + padding) * row
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{}", x, y, btnWidth, btnHeight), "[ON] " label)
    btn.OnEvent("Click", SCallback(idx))
    seedButtons.Push(btn)
    
}
SCallback(i) {
    return (*) => SToggle(i)
}
; Gear tab buttons
tab.UseTab(3)
Loop gearLabels.Length {
    idx := A_Index
    label := gearLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 30 + (btnWidth + padding) * col
    y := 55 + (btnHeight + padding) * row
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{}", x, y, btnWidth, btnHeight), "[OFF] " label)
    btn.OnEvent("Click", GCallback(idx))
    gearButtons.Push(btn)  ; Store control
}
GCallback(i) {
    return (*) => GToggle(i)
}
mainGui.OnEvent("Close", (*) => ExitApp())
mainGui.Show("w475 h300")

; --- Functions ---


SToggle(idx) {
    global seedStates, seedLabels, seedButtons
    seedStates[idx] := !seedStates[idx]
    text := (seedStates[idx] ? "[ON] " : "[OFF] ") . seedLabels[idx]
    seedButtons[idx].Text := text
}

GToggle(idx) {
    global gearStates, gearLabels, gearButtons
    gearStates[idx] := !gearStates[idx]
    text := (gearStates[idx] ? "[ON] " : "[OFF] ") . gearLabels[idx]
    gearButtons[idx].Text := text  ; Arrays are 0-based
}

InitLoop() {
    global running
    if running
        return
    running := true
    SetTimer(LoopTask, 500)
}

ChangeOption(direction) {
    global options, currentIndex, optionDisplay
    currentIndex += direction

    if currentIndex < 1
        currentIndex := options.Length
    else if currentIndex > options.Length
        currentIndex := 1
    if (currentIndex == 1) {
        optionText.Text := "(Not Promised to work)"
    }
    else if (currentIndex == 2) {
        optionText.Text := "(Recommended)"
        if (!gearStates[3])
            GToggle(3)
    }
    else {
        optionText.Text := "(Disabled)"
    }
    optionDisplay.Text := options[currentIndex]
}
ChangeSlotOption(direction) {
    global options, slotIndex, SlotOptionDisplay
    slotIndex += direction

    if slotIndex < 1
        slotIndex := slotOptions.Length
    else if slotIndex > slotOptions.Length
        slotIndex := 1

    SlotOptionDisplay.Text := slotOptions[slotIndex]
}

F1::Start()
F2::Toggles()
F3::Stop()
F4::gearTravel()
F5::align()

Start() {
    global toggle
    toggle := true
    InitLoop()
}

Stop() {
    global toggle
    toggle := false
    SetTimer(LoopTask, 0)
}

Toggles() {
    global toggle
    toggle := !toggle
    InitLoop()
}

LoopTask(*) {
    global toggle, i, g
    if toggle
        align()
        i := 1
        g := 1
        masterCollect()
        i := 1
        g := 1
        masterCollect()

        Stop()
}
