#!/bin/sh

# ADOBE SYSTEMS INCORPORATED
#  Copyright 2011 Adobe Systems Incorporated
#  All Rights Reserved.
# 
# NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the 
# terms of the Adobe license agreement accompanying it.  If you have received this file from a 
# source other than Adobe, then your use, modification, or distribution of it requires the prior 
# written permission of Adobe.

set -x

#--------------------------------------------------------------------------
# Set FLEX_SDK to a Flex SDK with an AIR SDK overlay

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0
if [[ $# = 1 ]] ; then
    FLEX_SDK="$1"
fi

ADL="$FLEX_SDK"/bin/adl

#--------------------------------------------------------------------------
# Clean up

rm -rf 	\
	NativeExtensionTest.dmg	\
	NativeExtensionTest.swf	\
	NativeExtensionTest-app.xml	\
	META-INF		\
	mimetype

idisk=$(mount | grep "Install NativeExtensionTest" | cut -d" " -f1)
hdiutil detach $idisk -force

#--------------------------------------------------------------------------
# Copy expanded Native Extension app

cp ../04-ANEAmanitaOSX-test/NativeExtensionTest.dmg .
hdid NativeExtensionTest.dmg

cp -Rp /Volumes/Install\ NativeExtensionTest/Install\ NativeExtensionTest.app/Contents/Resources/NativeExtensionTest/Contents/Resources/ .
idisk=$(mount | grep "Install NativeExtensionTest" | cut -d" " -f1)
hdiutil detach $idisk -force

cd META-INF/AIR
cp -p application.xml		../../NativeExtensionTest-app.xml

cd extensions
mv net.amanitadesign.ANEAmanitaOSX	net.amanitadesign.ANEAmanitaOSX.ane

cd ../../..

#--------------------------------------------------------------------------
# Run Native Extension app using ADL
# This assumes that the NE is build on Xcode with a runtime path priority that doesn't 
# conflict with the runtime specified here in the ADL command line.

"$ADL"  \
        -profile extendedDesktop        \
        -extdir ./META-INF/AIR/extensions       \
        NativeExtensionTest-app.xml

