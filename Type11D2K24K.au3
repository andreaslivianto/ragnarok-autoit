If WinActive("����������� � ���� ������") = 0 then
	Do
		WinActivate("����������� � ���� ������") 
	Until WinActive("����������� � ���� ������")
EndIf
	
ControlFocus("����������� � ���� ������", "", "TEdit1") 
Send("11D2K24K{ENTER}")

