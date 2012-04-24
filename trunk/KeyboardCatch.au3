#include <Misc.au3>
#include <IsPressedConst.au3>

$dll = DllOpen("user32.dll")

$Action = "EstunEsma"
$Loop = 1

Func CartTermination()
	send("{F3}")
	sleep(20)
	MouseClick("left");
	sleep(150)
EndFunc

func Estin()
	send("{F2}")
	sleep(20)
	MouseClick("left");
	sleep(150)
EndFunc

func Estun()
	send("{F3}")
	sleep(20)
	MouseClick("left");
	sleep(150)
EndFunc

func EstinEstun()
	send("{F2}")
	sleep(20)
	MouseClick("left");
	sleep(10)
	send("{F3}")
	sleep(170)
	MouseClick("left");
	;sleep(150)
EndFunc

func EstinEsma()
	send("{F3}")
	sleep(10)
	MouseClick("left");  
	sleep(150)
	send("{F4}")
	sleep(10)
	MouseClick("left");
	sleep(1500)
	;$Loop = 2
EndFunc

func EstunEsma()
	send("{F3}")
	sleep(50)
	MouseClick("left");
	sleep(150)
	send("{F4}")
	sleep(50)
	MouseClick("left");
	sleep(450)
EndFunc

While $Loop = 1
    If _IsPressed($VK_M_MOUSE, $dll) Then
        if $Action = "CT" then
			CartTermination()
		ElseIf $Action = "Estin" then
			Estin()
		ElseIf $Action = "Estun" then
			Estun()
		ElseIf $Action = "EstinEsma" then
			EstinEsma()
		ElseIf $Action = "EstunEsma" then
			EstunEsma()	
		ElseIf $Action = "EstinEstun" then
			EstinEstun()
		EndIf
    EndIf
WEnd
DllClose($dll)
