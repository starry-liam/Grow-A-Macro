; AutoHotkey v2.0 version of GrowAMacro GUI
#Requires AutoHotkey v2.0
#SingleInstance Force


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

mainGui := Gui()
mainGui.SetFont("s9", "Segoe UI")
mainGui.Add("Tab3", "x10 y10 w400 h250 vTab", ["Main", "Seeds", "Gear", "Settings"])

; Main tab buttons
mainGui.Tab := 1
mainGui.Add("Button", "x70 y220 w80 h20", "[F1] Start").OnEvent("Click", (*) => Start())
mainGui.Add("Button", "x160 y220 w80 h20", "[F2] Toggle").OnEvent("Click", (*) => Toggles())
mainGui.Add("Button", "x250 y220 w80 h20", "[F3] Stop").OnEvent("Click", (*) => Stop())

; Seed tab buttons
Loop seedLabels.Length {
    idx := A_Index
    label := seedLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 10 + (btnWidth + padding) * col
    y := 40 + (btnHeight + padding) * row
    mainGui.Tab := 2
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{} vSBtn{}", x, y, btnWidth, btnHeight, idx), "[ON] " label)
    btn.OnEvent("Click", (*) => SToggle(idx))
}

; Gear tab buttons
Loop gearLabels.Length {
    idx := A_Index
    label := gearLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 10 + (btnWidth + padding) * col
    y := 40 + (btnHeight + padding) * row
    mainGui.Tab := 3
    btn := mainGui.Add("Button", Format("x{} y{} w{} h{} vGBtn{}", x, y, btnWidth, btnHeight, idx), "[OFF] " label)
    btn.OnEvent("Click", (*) => GToggle(idx))
}

mainGui.OnEvent("Close", (*) => ExitApp())
mainGui.Show("w420 h280")

; --- Functions ---

SToggle(idx) {
    global seedStates, seedLabels, mainGui
    seedStates[idx] := !seedStates[idx]
    text := (seedStates[idx] ? "[ON] " : "[OFF] ") . seedLabels[idx]
    mainGui.GetControl("SBtn" idx).Text := text 

}

GToggle(idx) {
    global gearStates, gearLabels, Gui
    gearStates[idx] := !gearStates[idx]
    text := (gearStates[idx] ? "[ON] " : "[OFF] ") . gearLabels[idx]
    mainGui.GetControl("GBtn" idx).Text := text 

}

InitLoop() {
    global running
    if running
        return
    running := true
    SetTimer(LoopTask, 500)
}

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
    global toggle
    if toggle
        seedTravel()
}

seedTravel() {
    MouseMove 700, 150, 10
    Sleep 1000
    Click "Left"
    Sleep 100
    Send "e"
}
