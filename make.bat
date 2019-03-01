set PATH=%PATH%%WIX%bin

set NodeModules=./node_modules
heat dir ./node_modules -v -nologo -ag -cg modules -dr INSTALLLOCATION -var env.NodeModules -o modules.wxs

candle -v -nologo -dbuild="%BUILD%" -dPID="%PID%" -arch x86 %PNAME%.wxs modules.wxs

light -v -nologo -b .\ -cultures:lv-LV -spdb -ext WixUIExtension %PNAME%.wixobj modules.wixobj -o %OUTPUT%\%PNAME%.msi

echo msiexec /x {%PID%} /qb >%OUTPUT%\%PNAME%_repair.cmd	
echo msiexec /i %%~dp0\%PNAME%.msi /l*vx %%~dp0\%PNAME%.log /qb >>%OUTPUT%\%PNAME%_repair.cmd
