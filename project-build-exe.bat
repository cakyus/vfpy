@echo off
if not exist temp mkdir temp
if not exist library mkdir library
cscript /H:CScript /Nologo script\build.vbs exe
