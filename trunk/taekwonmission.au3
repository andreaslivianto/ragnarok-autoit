#Include <WinAPI.au3>

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
	
	while (PixelGetColor($WinCenterX+25, $WinCenterY+25) <> $Color)
		sleep(1000)
	wend
	

EndFunc

func TaekwonMission()
	_WinAPI_PostMessage($Handle, 0x0100, $Ins,0) ;Нажимаем Ins, чтоб встать
	Sleep(100)
	_WinAPI_PostMessage($Handle, 0x0100, $F5, 0);пускаем скил чтоб сверять мобов
	sleep(1500)
	$RectCS = PixelChecksum($WinCenterX+80, $Top+75, $WinCenterX+160, $Top+85)
	
	while 1=1
		_WinAPI_PostMessage($Handle, 0x0100, $F5, 0)
		sleep(1000)
		if ((PixelGetColor($WinCenterX-28, $WinCenterY+25) <> $Color) or (PixelChecksum($WinCenterX+80, $Top+75, $WinCenterX+160, $Top+85) <> $RectCS)) Then
			ExitLoop
		endif	
		
		
	wend 
	
	if PixelChecksum($WinCenterX+80, $Top+75, $WinCenterX+160, $Top+85) <> $RectCS then
		Stop()
	EndIf
	
EndFunc

$hList = _WinAPI_EnumWindows()
; Получаем хэндл окна рагны
For $i = 1 To $hList[0][0]
	If (StringLeft ($hList[$I][1],6) = 'Eterni') Then 
		$Handle = $hList[$I][0]
		ExitLoop
	EndIf	
Next

MsgBox(0,'',$Handle)

;Получаем размеры окна
$TRect = _WinAPI_GetWindowRect($Handle)

$Top = DllStructGetData($tRect, "Top")
$Left = DllStructGetData($tRect, "Left")
$Right = DllStructGetData($tRect, "Right")
$Bottom = DllStructGetData($tRect, "Bottom")

$WinCenterX = $Left + ($Right - $Left)/2
$WinCenterY = $Top + ($Bottom - $Top)/2

_WinAPI_PostMessage($Handle, 0x0100, $F5, 0);пускаем скил чтоб сверять мобов
sleep(1500)
$RectCS = PixelChecksum($WinCenterX+80, $Top+75, $WinCenterX+160, $Top+85)
	
_WinAPI_PostMessage($Handle, 0x0100, $F5, 0)
sleep(1500)

msgbox(0,'', PixelChecksum($WinCenterX+80, $Top+75, $WinCenterX+160, $Top+85) <> $RectCS)
		

;msgbox(0,'',0x1863DE);
;MouseMove($WinCenterX-28, $WinCenterY+25, 1)
;sleep(2000)
;MouseMove($WinCenterX+80, $Top+75, 1)
;sleep(1000)
;MouseMove($WinCenterX+160, $Top+85, 1)

;while 1
;sleep(2000)		
;	RestoreSP();Сидим, пока не восстановится СП
	
;	TaekwonMission(); вызываем скил пока не поменяется моб
	
;wend