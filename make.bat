@echo off
set PATH=%PATH%%WIX%bin

set PROJECT=product
set MODULES=modules
set BUILD=1

cd repo

echo ... wix heat
set NodeModules=./node_modules
heat dir ./node_modules -nologo -ag -cg modules -dr INSTALLLOCATION -var env.NodeModules -o %MODULES%.wxs

echo ... wix candle
candle  -nologo -dbuild="%BUILD%" -arch x86 %PROJECT%.wxs %MODULES%.wxs

echo ... wix light
light -nologo -b .\ -cultures:lv-LV -sice:ICE03 -sw1105 -sw1076 -spdb -ext WixUIExtension %PROJECT%.wixobj %MODULES%.wixobj -o %PROJECT%.msi

echo ... copy to server
copy %PROJECT%.msi \\s1.ma-1.lv\install\servers\MA-1 /y

echo ... create repair
echo msiexec /x {product-guid} /qb >\\s1.ma-1.lv\install\servers\MA-1\%PROJECT%_repair.cmd
echo msiexec /i %%~dp0\%PROJECT%.msi /l*vx %%~dp0\%PROJECT%.log /qb >>\\s1.ma-1.lv\install\servers\MA-1\%PROJECT%_repair.cmd

