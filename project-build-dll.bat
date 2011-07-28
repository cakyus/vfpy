@echo off
pskill -t vfp7
pskill -t oovfp
cscript /H:CScript /Nologo script\build.vbs dll
