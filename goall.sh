#!/bin/sh

# ADOBE SYSTEMS INCORPORATED
#  Copyright 2011 Adobe Systems Incorporated
#  All Rights Reserved.
# 
# NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the 
# terms of the Adobe license agreement accompanying it.  If you have received this file from a 
# source other than Adobe, then your use, modification, or distribution of it requires the prior 
# written permission of Adobe.

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0

echo
find "$FLEX_SDK" -type f \( -name "Adobe AIR" -o -name "adt.jar" \) -exec ls -l \{\} \;
echo

echo "Correct AIR SDK?  <cr> : Continue.  <cntl-c> : Exit"
read $resp


echo "===== Step 01 =========================================================="
cd 01*
./go.sh "$FLEX_SDK"
cd -
echo

echo "===== Step 02 =========================================================="
cd 02*
./go.sh
cd -
echo

echo "===== Step 03 =========================================================="
cd 03*
./go.sh "$FLEX_SDK"
cd -
echo

echo "===== Step 04 =========================================================="
cd 04*
./go.sh "$FLEX_SDK"
cd -
echo

echo "===== Step 05 =========================================================="
cd 05*
./go.sh "$FLEX_SDK"
cd -
echo

