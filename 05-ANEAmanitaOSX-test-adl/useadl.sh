#!/bin/sh

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.6/sdks/4.6.0
ADL="$FLEX_SDK"/bin/adl
AIRRT="$FLEX_SDK"/runtimes/runtime_sdk_withdrm

APP_DESC=NativeExtensionTest-app.xml		# App descriptor
APP_DIR=.

EXT_DIR=./META-INF/AIR/extensions/com.airrt.extensions.ane

echo "==========================================================="
echo
ls -l "$ADL"
ls -l "$AIRRT/Adobe AIR.framework/Versions/1.0/Adobe AIR"
echo
ls -l $APP_DIR/$EXT_DIR/META-INF/ANE/extension.xml
grep -e applicationDeployment -e MacOS-x86 $APP_DIR/$EXT_DIR/META-INF/ANE/extension.xml
echo
echo "==========================================================="

cd $APP_DIR

set -x

"$ADL"		\
	-profile extendedDesktop	\
	-extdir $EXT_DIR/..			\
	$APP_DESC
	
