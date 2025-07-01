looping := false  ; Global flag to control the loop

Gui, Add, Button, gStartLoop, Start Loop
Gui, Show,, Loop GUI
return

StartLoop:
Gui, Hide
looping := true
SetTimer, LoopClick, 100
return
F1::
Gui, Hide
looping := true
SetTimer, LoopClick, 100
return
LoopClick:
if (looping)
{
    Send, {s, Down}
    Sleep, 6000
    Send, {s, Up}
    Send, {d, Down}
    Sleep, 3000
    Send, {d, Up}
    
}
return

F3:: ; Press F to stop loop and show GUI again
looping := false
SetTimer, LoopClick, Off
Gui, Show
return

GuiClose:
ExitApp