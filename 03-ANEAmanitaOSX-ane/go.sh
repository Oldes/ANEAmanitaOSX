#!/bin/sh

# ADOBE SYSTEMS INCORPORATED
#  Copyright 2011 Adobe Systems Incorporated
#  All Rights Reserved.
# 
# NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the 
# terms of the Adobe license agreement accompanying it.  If you have received this file from a 
# source other than Adobe, then your use, modification, or distribution of it requires the prior 
# written permission of Adobe.

# Set FLEX_SDK env var to a flex sdk with a serrano air overlay
# Set JAR environment var to point to jar in java jdk install

set -x

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0

if [[ $# = 1 ]] ; then 
    FLEX_SDK="$1"
fi 

JAR="/usr/bin/jar"

PASS=none	# Others used: none, test

rm -rf src/assets
rm -f ANEAmanitaOSX.ane

mkdir -p src/assets
cp "../01-ANEAmanitaOSX-swc/net.amanitadesign.ANEAmanitaOSX.swc" src/assets

mkdir -p src/assets/swc-contents
pushd src/assets/swc-contents
$JAR xf ../net.amanitadesign.ANEAmanitaOSX.swc catalog.xml library.swf
popd

mkdir -p src/assets/platform
mkdir -p src/assets/platform/mac

cp -R "../02-ANEAmanitaOSX/build/Release/ANEAmanitaOSX.framework"	\
    src/assets/platform/mac
cp src/assets/swc-contents/library.swf src/assets/platform/mac

echo
ls -l "$FLEX_SDK"/lib/adt.jar
echo

"$FLEX_SDK"/bin/adt -package	\
    -target ane ANEAmanitaOSX.ane src/extension.xml	\
    -swc src/assets/net.amanitadesign.ANEAmanitaOSX.swc	\
    -platform MacOS-x86-64	\
    -C src/assets/platform/mac .

