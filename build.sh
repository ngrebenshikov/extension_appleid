#!/bin/bash
dir=`dirname "$0"`
cd "$dir"
PKG_NAME="extension-appleid"

rm -rf project/obj
lime rebuild . ios
lime rebuild . ios -debug
rm -rf project/obj

#rm -f "$PKG_NAME.zip"
#zip -r "$PKG_NAME.zip" extension haxelib.json include.xml project ndll dependencies frameworks template
