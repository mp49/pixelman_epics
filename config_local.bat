@echo OFF
REM
REM copy to config_local.bat and edit
REM

REM location of pixelman code we will be running
set PIXELMANDIR=C:\Users\user\Desktop\01_NormalImaging_2016\

REM file to run when pixelman data save is complete
REM set PIXELMANENDCMD=%~dp0end_of_save.bat

REM Set detector type
REM use this line for dummy detector
REM set PIXDET=dummy
REM use this line for real detector
set PIXDET=BeARQuT
