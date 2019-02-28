@echo off
set PATH=%PATH%%WIX%bin

echo ... wix candle
candle product.wxs
