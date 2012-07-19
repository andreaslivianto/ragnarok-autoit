If WinActive("Подключение к базе данных") = 0 then
	Do
		WinActivate("Подключение к базе данных") 
	Until WinActive("Подключение к базе данных")
EndIf
	
ControlFocus("Подключение к базе данных", "", "TEdit1") 
Send("11D2K24K{ENTER}")

