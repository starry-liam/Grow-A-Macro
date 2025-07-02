#SingleInstance Force
SetBatchLines, -1

Gui, Add, Tab, x10 y10 w400 h250, Main|Seeds|Gear|Settings


toggle := false
running := false

seedLabels := Object()
seedStates := Object()
seedLabels[1] := "Carrots"
seedLabels[2] := "Strawberries"
seedLabels[3] := "Blueberries"
seedLabels[4] := "Tomatoes"
seedLabels[5] := "Califlower"
seedLabels[6] := "Watermelon"
seedLabels[7] := "Rafflesia"
seedLabels[8] := "Green Apple"
seedLabels[9] := "Avocado"
seedLabels[10] := "Banana"
seedLabels[11] := "Pineapple"
seedLabels[12] := "Kiwi"
seedLabels[13] := "Bellpepper"
seedLabels[14] := "Pricly Pear"
seedLabels[15] := "Loquats"
seedLabels[16] := "Feijoa"
seedLabels[17] := "Pitcher Plant"
seedLabels[18] := "Sugar Apple"

gearLabels := Object()
gearStates := Object()
gearLabels[1] := "Watering Can"
gearLabels[2] := "Trowel"
gearLabels[3] := "Recall Wrench"
gearLabels[4] := "Basic Sprinkler"
gearLabels[5] := "Advanced Sprinkler"
gearLabels[6] := "Godly Sprinkler"
gearLabels[7] := "Magnifying Glass"
gearLabels[8] := "Tanning Mirror"
gearLabels[9] := "Master Sprinkler"
gearLabels[10] := "Cleaning Spray"
gearLabels[11] := "Favorite Tool"
gearLabels[12] := "Harvest Tool"
gearLabels[13] := "Friendship Pot"

Loop, 18
    seedStates[A_Index] := True

btnWidth := 130
btnHeight := 26
padding := 8
cols := 3

Loop, 13
    gearStates[A_Index] := False

btnWidth := 130
btnHeight := 26
padding := 8
cols := 3


Gui, Font, s9, Segoe UI

Gui Tab, 1
Gui, Add, Button, x70 y220 w80 h20 gStart, [F1] Start
Gui Tab, 1
Gui, Add, Button, x160 y220 w80 h20 gToggles, [F2] Toggle
Gui Tab, 1
Gui, Add, Button, x250 y220 w80 h20 gStop, [F3] Stop

Loop, 18
{
    idx := A_Index
    slabel := seedLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 10 + (btnWidth + padding) * col
    y := 40 + (btnHeight + padding) * row
    Gui, Tab, 2
    Gui, Add, Button, x%x% y%y% w%btnWidth% h%btnHeight% gSToggle vSBtn%idx%, [ON] %slabel%
}
Loop, 13
{
    idx := A_Index
    glabel := gearLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 10 + (btnWidth + padding) * col
    y := 40 + (btnHeight + padding) * row
    Gui, Tab, 3
Gui, Add, Button, x%x% y%y% w%btnWidth% h%btnHeight% gGToggle vGBtn%idx%, [OFF] %glabel%
}
Gui, Show,, GrowAMacro
return

SToggle:
GuiControlGet, ctrlName, FocusV
StringTrimLeft, idx, ctrlName, 4  ; remove "SBtn"
slabel := seedLabels[idx]
seedStates[idx] := !seedStates[idx]

if (seedStates[idx]) {
    GuiControl,, SBtn%idx%, [ON] %slabel%
} else {
    GuiControl,, SBtn%idx%, [OFF] %slabel%
}
return

GToggle:
GuiControlGet, ctrlName, FocusV
StringTrimLeft, idx, ctrlName, 4  ; remove "SBtn"
glabel := gearLabels[idx]
gearStates[idx] := !gearStates[idx]

if (gearStates[idx]) {
    GuiControl,, GBtn%idx%, [ON] %glabel%
} else {
    GuiControl,, GBtn%idx%, [OFF] %glabel%
}
return

F1::Start()
F2::Toggles()  
F3::Stop()    
F4::seedTravel()  ; F4 to seed travel

; Global flags
toggle := false
running := false

; Start the loop (doesn't run anything unless toggle := true)
InitLoop() {
    global running
    if running
        return
    running := true
    SetTimer, LoopTask, 500
}

Start() {
    global toggle
    toggle := true
    InitLoop()
}

Stop() {
    global toggle
    toggle := false
}

Toggles() {
    global toggle
    toggle := !toggle
    InitLoop()
}

LoopTask:
if (toggle) {
    seedTravel()
}
return


seedTravel()
{
    MouseMove, 700, 150, 10
    Sleep, 1000
    Click, Left
}

Return

GuiClose:
ExitApp
