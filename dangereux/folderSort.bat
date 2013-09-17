@echo off

set startdir=%cd%
call :treeProcess
goto :eof

:treeProcess
move /y "%cd%\*.*" "%startdir%"
for /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)
exit /b

pause