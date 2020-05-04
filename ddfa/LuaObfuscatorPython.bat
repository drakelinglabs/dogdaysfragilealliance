@echo off
cd LuaObfuscator-master
py __main__.py --input %1 --output %1.lua --level 2 --debug
rem [--dontcopy] [--debug]
@pause