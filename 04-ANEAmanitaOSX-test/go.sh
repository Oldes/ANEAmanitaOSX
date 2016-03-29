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

set -x

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0

if [[ $# = 1 ]] ; then 
    FLEX_SDK="$1"
fi 

PASS=none		# Others used: none, test

rm -f NativeExtensionTest.dmg

rm -rf src/assets
mkdir -p src/assets

cp "../cert/test.pfx" src/assets
cp "../01-ANEAmanitaOSX-swc/net.amanitadesign.ANEAmanitaOSX.swc" src/assets

mkdir -p src/assets/ane

cp "../03-ANEAmanitaOSX-ane/ANEAmanitaOSX.ane" src/assets/ane

"$FLEX_SDK"/bin/amxmlc	\
    -output src/assets/NativeExtensionTest.swf	\
    -library-path+="src/assets/net.amanitadesign.ANEAmanitaOSX.swc"	\
    src/NativeExtensionTest.mxml

cp src/NativeExtensionTest-app.xml src/assets

"$FLEX_SDK"/bin/adt	\
    -package	\
    -storetype PKCS12 -keystore src/assets/test.pfx -storepass $PASS	\
    -target native 	\
    NativeExtensionTest ./src/assets/NativeExtensionTest-app.xml	\
    -C src/assets NativeExtensionTest.swf	\
    -extdir src/assets/ane

echo "\nMount NativeExtensionTest.dmg and install the 'NativeExtensionTest' application\n"

