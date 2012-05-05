#Include <WinAPI.au3>
#include <Constants.au3>
HotKeySet("{ESC}", "stop")

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

const $Color = 0x1863DE
;const $Color = 0x1863DE

func stop()
    Exit
EndFunc

Local $hList, $i, $j, $k, $Handle
local $Top, $Left, $Right, $Bottom, $WinCenterX, $WinCenterY
Local $TRect
Local $RectCS

func RestoreSP()
	_WinAPI_PostMessage($Handle, 0x0100, $Ins,0) ;Нажимаем Ins, чтоб сесть
	Sleep(100)
; Сидим, пока не восстановится СП
	
	while (PixelGetColor($WinCenterX+25, $WinCenterY+28) <> $Color)
		sleep(1000)
	wend
	

EndFunc

func TaekwonMission()
	_WinAPI_PostMessage($Handle, 0x0100, $Ins,0) ;Нажимаем Ins, чтоб встать
	Sleep(100)

    while (PixelGetColor($WinCenterX-25, $WinCenterY+28) = $Color)
		_WinAPI_PostMessage($Handle, 0x0100, $F9, 0)
		sleep(1000)
	wend
	
EndFunc


$Handle = 0x5040C



;Получаем размеры окна
$TRect = _WinAPI_GetWindowRect($Handle)

$Top = DllStructGetData($tRect, "Top")
$Left = DllStructGetData($tRect, "Left")
$Right = DllStructGetData($tRect, "Right")
$Bottom = DllStructGetData($tRect, "Bottom")

;_WinAPI_SetWindowPos($Handle, $HWND_TOPMOST, $Left, $Left, $Right-$Left + 1, $Bottom-$Top + 1, $SWP_SHOWWINDOW);



$WinCenterX = $Left + ($Right - $Left)/2
$WinCenterY = $Top + ($Bottom - $Top)/2

;mousemove($WinCenterX-30, $WinCenterY+28);

;exit;

while 1
sleep(2000)		
	RestoreSP();Сидим, пока не восстановится СП
	
	TaekwonMission(); вызываем скил пока не поменяется моб
	
wend