@echo off
set PATH=%PATH%%WIX%bin

echo ... wix heat
set NodeModules=./node_modules
heat dir ./node_modules -nologo -ag -cg modules -dr INSTALLLOCATION -var env.NodeModules -o modules.wxs

echo ... wix candle
candle -nologo -dbuild="%BUILD%" -dPID="%PID%"  -arch x86 %PNAME%.wxs modules.wxs

echo ... wix light
light -nologo -b .\ -cultures:lv-LV -sice:ICE03 -sw1105 -sw1076 -spdb -ext WixUIExtension %PNAME%.wixobj modules.wixobj -o %PNAME%.msi

echo ... copy to server	
copy %PNAME%.msi %DEPLOY% /y	

echo ... create repair	
echo msiexec /x {%PID%} /qb >%DEPLOY%\%PNAME%_repair.cmd	
echo msiexec /i %%~dp0\%PNAME%.msi /l*vx %%~dp0\%PNAME%.log /qb >>%DEPLOY%\%PNAME%_repair.cmd
