#Include <WinAPI.au3>


Func _WinAPI_SetForegroundWindow($hWnd)
	Local $aResult

	$aResult = DllCall("User32.dll", "int", "SetForegroundWindow", "hwnd", $hWnd)
	If @error Then Return SetError(@error, 0, False)
	Return $aResult[0] <> 0
EndFunc   ;==>_WinAPI_SetForegroundWindow




local $w_Left = 1
local $w_Top = 1

local $w_Right = 403
local $w_Bottom = 223
local $color
Local $hList, $i, $j, $k

Local $tRect


Func Terminate()
    Exit 0
EndFunc


;HotKeySet("{ESC}", "Terminate")
$j = 0
$hList = _WinAPI_EnumWindows()

;MsgBox(0,'����� �����'

$handle = 0x30542
while 1
;For $i = 1 To $hList[0][0]
;	If (StringLeft ($hList[$I][1],6) = 'Eterni') Then 
		_WinAPI_ShowWindow($handle, 4)
		$a = _WinAPI_SetForegroundWindow($handle)
		msgbox(0,"",$a)
		exit
		sleep(1000)
		$tRect = _WinAPI_GetWindowRect($handle)
		;MsgBox(0,'',$hList[$I][0])
		$w_Left = DllStructGetData($tRect, "Left")
		$w_top = DllStructGetData($tRect, "Top")
		$w_Right = DllStructGetData($tRect, "Right")
		;MouseMove($w_Right - 175,$w_top + 169,1) ; ������ ������ ������������� �� ������� � ��������
		;MsgBox(0, '', PixelGetColor($w_Right - 175,$w_top + 169));
		;exit;
		if PixelGetColor($w_Right - 175,$w_top + 169) = 0xFF0000 Then
			MouseMove($w_Right - 50,$w_top + 185,1); ������ ������ ������������� �� ������ ������� �� �� ���������� ������ ���� � ============     1     ===========
			;exit
			$k = 20
			;MouseMove($w_Left + 520,$w_top + 400,1)  ������ ������ ������������� �� ����� ��� ���� ������������� ���������
			;exit
			While (PixelGetColor($w_Left + 520,$w_top + 400) <> 0xffffff) and ($k > 0)
				MouseClick("left",$w_Right - 50,$w_top + 185,1) ; ============     1     ===========
				$k = $k - 1;
				sleep(1000)
			wend


		
			MouseMove($w_Left + 580,$w_top + 445,1) ;������ ������ ������������� �� ������ ��. �� �� � � ============     2     ===========
			;exit
			$k = 20;
			While (PixelGetColor($w_Left + 520,$w_top + 400) = 0xffffff) and ($k > 0)
				MouseClick("left",$w_Left + 580,$w_top + 445,1)	;������ �� ; ============     2     ===========
			;MouseClick("left",$w_Left + 520,$w_top + 370,1) ;������ ������
				$k = $k - 1
				sleep(1000)
			WEnd
		EndIf
;	EndIf	
		
;Next

	Sleep(60*1000);
WEnd	