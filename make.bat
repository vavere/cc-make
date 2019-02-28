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
light -nologo -b .\ -cultures:lv-LV -dWixUILicenseRtf=licence.rtf -sice:ICE03 -sw1105 -sw1076 -spdb -ext WixUIExtension %PROJECT%.wixobj %MODULES%.wixobj -o %PROJECT%.msi


