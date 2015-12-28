#!/bin/bash
app_name="$1"
nw_path="/Users/a2014-280/hetweb/nw"
# 创建app.nw文件
rm -rf output
mkdir output
cp -r $nw_path/$app_name/* output
cd output/
find . -type d -name ".svn" | xargs rm -rf
find . -type d -name ".git" | xargs rm -rf
zip -r ../app.nw *
rm -rf * && cd ../ && mv app.nw output/
echo "create nw file success!"

#下载基础包
cd output
unzip ../../nwjs-v0.12.3-osx-x64.zip
basepath=$(cd `dirname $0`; pwd)
echo "$basepath"
mv nwjs-v0.12.3-osx-x64/* ./
rm -r nwjs-v0.12.3-osx-x64/
mv nwjs.app/ nw.app

#创建mac版本app
if [ -f ../Info.plist ];then
    cp ../Info.plist nw.app/Contents/
fi
rm -rf nw.app/Contents/Resources/*
mv app.nw nw.app/Contents/Resources/app.nw
if [ -f ../$app_name.icns ];then
    cp ../$app_name.icns nw.app/Contents/Resources/app.icns
fi
mv nw.app $app_name.app
echo "create mac os app success!"

#创建windows版本app
#cat nw.exe app.nw > $app_name.exe
#rm -rf nw.exe nwsnapshot.exe
