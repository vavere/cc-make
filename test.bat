@echo off
set PATH=%PATH%%WIX%bin

echo ... wix candle
candle repo\product.wxs
