1.	Nasm x86 (рекомендованная версия: 3.01rc09)
2.	GoLink (рекомендованная версия: 1.0.4.6)
3.	Наличие стандартных библиотек Windows: user32.dll и kernel32.dll
Команды сборки:
1.	nasm -f win32 lab2.asm -o lab2.obj
2.	golink /entry:Start /console kernel32.dll user32.dll lab2.obj
