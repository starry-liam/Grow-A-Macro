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
    Sleep, 3000
    MouseClickDrag, Right, 300, 300, 800, 300
}
return

F3:: ; Press F to stop loop and show GUI again
looping := false
SetTimer, LoopClick, Off
Gui, Show
return

GuiClose:
ExitApp