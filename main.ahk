#SingleInstance Force
SetBatchLines, -1

Gui, Add, Tab, x10 y10 w400 h250, Main|Seeds|Gear|Settings


toggle := false
running := false

btnLabels := Object()
btnLabels[1] := "Carrots"
btnLabels[2] := "Strawberries"
btnLabels[3] := "Blueberries"
btnLabels[4] := "Tomatoes"
btnLabels[5] := "Califlower"
btnLabels[6] := "Watermelon"
btnLabels[7] := "Rafflesia"
btnLabels[8] := "Green Apple"
btnLabels[9] := "Avocado"
btnLabels[10] := "Banana"
btnLabels[11] := "Pineapple"
btnLabels[12] := "Kiwi"
btnLabels[13] := "Bellpepper"
btnLabels[14] := "Pricly Pear"
btnLabels[15] := "Loquats"
btnLabels[16] := "Feijoa"
btnLabels[17] := "Pitcher Plant"
btnLabels[18] := "Sugar Apple"

Loop, 18
    state%A_Index% := True

btnWidth := 130
btnHeight := 26
padding := 8
cols := 3

Gui, Font, s9, Segoe UI

Loop, 18
{
    idx := A_Index
    label := btnLabels[idx]
    col := Mod(idx - 1, cols)
    row := Floor((idx - 1) / cols)
    x := 10 + (btnWidth + padding) * col
    y := 40 + (btnHeight + padding) * row
    Gui, Tab, 2
    Gui, Add, Button, x%x% y%y% w%btnWidth% h%btnHeight% gToggle vBtn%idx%, %label%
}

Gui, Show,, GrowAMacro
return

Toggle:
GuiControlGet, ctrlName, FocusV
StringTrimLeft, idx, ctrlName, 3
state%idx% := !state%idx%
label := btnLabels[idx]

if (state%idx%) {
    GuiControl,, Btn%idx%, [ON] %label%
} else {
    GuiControl,, Btn%idx%, [OFF] %label%
}
return

F1:: {  ; Start loop
    if running
        return  ; Already running, do nothing
    toggle := true
    running := true
    Loop {
        if !toggle
            break
        Sleep, 500
    }
    running := false


F3::   ; Stop loop
    toggle := false
Return

F2::  ; Toggle loop on/off
    if running {
        toggle := !toggle
    } else {
        toggle := true
        running := true
        Loop {
            if !toggle
                break
            Sleep, 500
        }
        running := false
    }
Return

GuiClose:
ExitApp
