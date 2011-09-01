@ECHO OFF
ECHO LightTPD Test mode (without log)
ECHO Press 'CTRL + C' to exit.
ECHO.
ECHO LightTPD Output:
ECHO ----------------
START /B C:\Progra~1\LightTPD\LightTPD.exe -f development.conf -m C:\Progra~1\LightTPD\lib -D
PAUSE >NUL && EXIT