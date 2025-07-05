; AutoHotkey v2.0 version of GrowAMacro GUI
#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir A_ScriptDir

#Include subMacros\seedCollector.ahk
#Include subMacros\travel.ahk
; Global state
global toggle := false
global running := false

seedLabels := ["Carrots", "Strawberries", "Blueberries","Orange Tulip", "Tomatoes", "Daffodil", "Watermelon", "Pumpkin", "Apples", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud"]
seedStates := Map()
Loop seedLabels.Length
    seedStates[A_Index] := true

gearLabels := ["Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler", "Godly Sprinkler", "Magnifying Glass", "Tanning Mirror", "Master Sprinkler", "Cleaning Spray", "Favorite Tool", "Harvest Tool", "Friendship Pot"]
gearStates := Map()
Loop gearLabels.Length
    gearStates[A_Index] := false

settings := ["exitMenu", "align", "recallSLot", "travelMethod"]
settingsStates := Map()

btnWidth := 130
btnHeight := 26
padding := 8
cols := 3

gearButtons := [] 
seedButtons := []

centerX := 0
centerY := 0

options := ["Walk", "Recall Wrench", "Disabled"]
slotOptions := ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
exitOptions := ["Mouse", "Keyboard"]
settingsStates[4] := 2  ; Start with the first option
settingsStates[3] := 2  ; Start with the first slot
settingsStates[1] := 1  ; Start with the first exit option


mainGui := Gui()
mainGui.SetFont("s9", "Sergoe UI")

tab := mainGui.Add("Tab3", "x10 y10 w450 h325", ["Main", "Seeds", "Gear"])
tab.UseTab(0) ; Important: reset first

LoadStates()
; Main tab buttons
tab.UseTab(1)
mainGui.Add("Button", "x95 y240 w80 h20", "[F1] Start").OnEvent("Click", (*) => Start())
mainGui.Add("Button", "x185 y240 w80 h20", "[F2] Toggle").OnEvent("Click", (*) => Toggles())
mainGui.Add("Button", "x275 y240 w80 h20", "[F3] Stop").OnEvent("Click", (*) => Stop())

leftmethodBtn := mainGui.Add("Button", "x145 y170 w30", "<")
leftmethodBtn.OnEvent("Click", (*) => ChangeOption(-1))

leftslotBtn := mainGui.Add("Button", "x145 y140 w30", "<")
leftslotBtn.OnEvent("Click", (*) => ChangeSlotOption(-1))

leftexitBtn := mainGui.Add("Button", "x145 y110 w30", "<")
leftexitBtn.OnEvent("Click", (*) => ChangeExitOption(-1))

mainGui.Add("Text", "x10 y175 w150 Center", "Gear Travel Method:")

mainGui.Add("Text", "x10 y145 w150 Center", "Recall Wrench Slot:")

mainGui.Add("Text", "x10 y115 w150 Center", "Menu Exit Method:")

optionDisplay := mainGui.Add("Text", "x165 y175 w120 Center vOptionLabel", options[settingsStates[4]])
optionText := mainGui.Add("Text", "x300 y175 w150 Center", "(Recommended)")
exitText := mainGui.Add("Text", "x300 y115 w150 Center", "(Recommended)")


SlotOptionDisplay := mainGui.Add("Text", "x165 y145 w120 Center vSlotOptionLabel", slotOptions[settingsStates[3]])

ExitOptionDisplay := mainGui.Add("Text", "x165 y115 w120 Center vExitOptionLabel", exitOptions[settingsStates[1]])

rightmethodBtn := mainGui.Add("Button", "x275 y170 w30", ">")
rightmethodBtn.OnEvent("Click", (*) => ChangeOption(1))

rightslotBtn := mainGui.Add("Button", "x275 y140 w30", ">")
rightslotBtn.OnEvent("Click", (*) => ChangeSlotOption(1))

rightexitBtn := mainGui.Add("Button", "x275 y110 w30", ">")
rightexitBtn.OnEvent("Click", (*) => ChangeExitOption(1))

; Seed tab buttons
tab.UseTab(2)
Loop seedLabels.Length {
    idx := A_Index
    label := seedLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 30 + (btnWidth + padding) * col
    y := 55 + (btnHeight + padding) * row
    initialText := (seedStates[idx] ? "[ON] " : "[OFF] ") . label
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{}", x, y, btnWidth, btnHeight), initialText)
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
    initialText := (gearStates[idx] ? "[ON] " : "[OFF] ") . label
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{}", x, y, btnWidth, btnHeight), initialText)
    btn.OnEvent("Click", GCallback(idx))
    gearButtons.Push(btn)  ; Store control
}
GCallback(i) {
    return (*) => GToggle(i)
}
mainGui.OnEvent("Close", (*) => (SaveStates(), ExitApp()))
mainGui.Show("w475 h350")

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
    global options, settingsStates, optionDisplay
    settingsStates[4] += direction

    if settingsStates[4] < 1
        settingsStates[4] := options.Length
    else if settingsStates[4] > options.Length
        settingsStates[4] := 1
    if (settingsStates[4] == 1) {
        optionText.Text := "(Not Promised to work)"
    }
    else if (settingsStates[4] == 2) {
        optionText.Text := "(Recommended)"
        if (!gearStates[3])
            GToggle(3)
    }
    else {
        optionText.Text := "(Disabled)"
    }
    optionDisplay.Text := options[settingsStates[4]]
}
ChangeSlotOption(direction) {
    global options, settingsStates, SlotOptionDisplay
    settingsStates[3] += direction

    if settingsStates[3] < 1
        settingsStates[3] := slotOptions.Length
    else if settingsStates[3] > slotOptions.Length
        settingsStates[3] := 1

    SlotOptionDisplay.Text := slotOptions[settingsStates[3]]
}

ChangeExitOption(direction) {
    global options, settingsStates, ExitOptionDisplay
    settingsStates[1] += direction

    if settingsStates[1] < 1
        settingsStates[1] := exitOptions.Length
    else if settingsStates[1] > exitOptions.Length
        settingsStates[1] := 1
    if (settingsStates[1] == 1) {
        exitText.Text := "(Recommended)"
    }
    else if (settingsStates[4] == 2) {
        exitText.Text := "(Works, but not recommended)"
    }


    ExitOptionDisplay.Text := exitOptions[settingsStates[1]]
}

F1::Start()
F2::Toggles()
F3::ExitApp()

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
    loop {
    if toggle {
        align()
        i := 1
        g := 1
        masterCollect()
    } else {
        break
    }
    }
}
SaveStates() {
    global seedStates, gearStates, seedLabels, gearLabels, settingsStates, settings
    Loop seedLabels.Length
        IniWrite seedStates[A_Index], "config.ini", "Seeds", seedLabels[A_Index]
    Loop gearLabels.Length
        IniWrite gearStates[A_Index], "config.ini", "Gear", gearLabels[A_Index]
    for key, name in settings {
        if settingsStates.Has(key)
            IniWrite(settingsStates[key], "config.ini", "Settings", name)
    }
}
LoadStates() {
    global seedStates, gearStates, seedLabels, gearLabels
    Loop seedLabels.Length {
        val := IniRead("config.ini", "Seeds", seedLabels[A_Index], "1") ; default: ON
        seedStates[A_Index] := val
    }
    Loop gearLabels.Length {
        val := IniRead("config.ini", "Gear", gearLabels[A_Index], "0") ; default: OFF
        gearStates[A_Index] := val
    }
    settingsStates[1] := IniRead("config.ini", "Settings", "exitMenu", 1)  
    settingsStates[3] := IniRead("config.ini", "Settings", "recallSlot", 2)
    settingsStates[4] := IniRead("config.ini", "Settings", "travelMethod", 2)
    
     
}