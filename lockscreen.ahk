#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.


SysGet,PosVar,Monitor, ;get area to place toaster

atts = 0
draws = 0
dispnote = 0
lPos := PosVarLeft-1
rPos := PosVarRight+1
rPos2 := rPos * (1 - 60/100)
bPos := PosVarBottom+1
bPos1 := PosVarBottom-209
bPos2 := PosVarBottom-189
bPos3 := PosVarBottom-159
tPos := PosVarTop-1

; display the time

Gui,Add,Text,c0xa0a0a0 x20 y%bPos1%,%A_DD% %A_MM% %A_YYYY%
gui,font,s20
Gui,Add,Text,cffffff x20 y%bPos2%,%A_DDDD%, %A_DD% %A_MMMM%
Gui,Add,Text,cffffff x20 y%bPos3%,%A_Hour%:%A_Min%:%A_Sec%
gui,font,s8

; password area

Gui,Add,Text, c0xa0a0a0 x%rPos2% y%bPos2%,Locked
Gui, Add, Edit, vPass w135 r1 -theme +password
Gui, Add, Button, gguiclose w80 -theme +default, OK

; leave note

Gui,Add,radio, gdispnote vdispnote c0xa0a0a0 x20 y20,Leave a note for the current user

Gui, -0x400000 -MinimizeBox -SysMenu -ToolWindow -theme ;makes with black boarder
Gui, color, 0x060606
WinSetTitle, lockScreen
Gui,Show,x%lPos% y%tPos% w%rPos% h%bPos%,Toaster
winset, Alwaysontop, on, Toaster
settimer,time,1000 ; Update the displayed time
settimer,reactivate,200 ; Prevent the user from escaping the window
RWin::
LWin::
Ctrl::
Alt::
Tab::
return
guiclose:
     {
     GuiControlGet, Pass
     if Pass = pwd 
     {
     gui,destroy
	ExitApp
	}
	if Pass != pwd 
     {
     atts ++1
     Gui,Add,Text, cff0000 x1 y1,Wrong password (%atts% attempts)
     GuiControl,,Pass,
     return
     }
     }
time:
{
Gui,Add,Text,c0xa0a0a0 x20 y%bPos1%,%A_DD% %A_MM% %A_YYYY%
gui,font,s20
Gui,Add,Text,cffffff x20 y%bPos2%,%A_DDDD%, %A_DD% %A_MMMM%
Gui,Add,Text,cffffff x20 y%bPos3%,%A_Hour%:%A_Min%:%A_Sec%
gui,font,s8
}
reactivate:
{
	winactivate, Toaster
}
dispnote:
{
	guicontrolget, dispnote
if dispnote = 1
draws ++1
if draws = 1
{
	{
		gui,font,s14
		Gui, Add, Edit, vNote w400 r5 x20 y40 -theme
		gui,font,s8
	}
}
}