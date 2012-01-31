#Include <WinAPI.au3>

;HotKeySet("{ESC}", "stop")

const $F1 = 112
const $F2 = 113
const $F3 = 114
const $F4 = 115
const $F5 = 116
const $F6 = 117
const $F7 = 118
const $F8 = 119
const $F9 = 120
const $Ins= 45

func stop()
    Exit
EndFunc

Local $hList, $i, $j, $k, $HWindow, $s

;$s = InputBox('Enter Handle','Handle');
;$HWindow = ($s)

;MsgBox(0,'1111',$HWindow)
$HWindow = 0x306B4

func Type_DoriDori()
	_WinAPI_PostMessage($HWindow, 0x0100, 111,0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('D'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('O'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('R'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('I'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('D'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('O'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('R'), 0)
	_WinAPI_PostMessage($HWindow, 0x0100, asc('I'), 0)
	Sleep(200)
	_WinAPI_PostMessage($HWindow, 0x0100, 13, 0)
	Sleep(200)
EndFunc



func BurnSP()
	_WinAPI_PostMessage($HWindow, 0x0100, $Ins,0) ;Нажимаем Ins, чтоб встать
	Sleep(300)
; Палим СП			
	for $j = 1 to 9
		_WinAPI_PostMessage($HWindow, 0x0100, $F8, 0)
		sleep(1000)
	next

	Sleep(300)
	_WinAPI_PostMessage($HWindow, 0x0100, 45,0) ;Нажимаем Ins, чтоб сесть
    Sleep(300)
EndFunc


while 1
;sleep(2000)		
	BurnSP()
	
	for $j = 1 to 300
		Type_DoriDori()	
		Sleep(100)
	next
wend