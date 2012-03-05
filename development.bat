@ECHO OFF
ECHO LightTPD Test mode (without log)
ECHO Press 'CTRL + C' to exit.
ECHO.
ECHO LightTPD Output:
ECHO ----------------
START /B %LIGHTTPD_HOME%\LightTPD.exe -f development.conf -m %LIGHTTPD_HOME%\lib -D
PAUSE >NUL && EXIT
