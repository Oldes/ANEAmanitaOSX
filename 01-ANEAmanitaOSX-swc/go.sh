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

# Set FLEX_SDK env var to a flex sdk with a serrano air overlay

FLEX_SDK=/Applications/Adobe\ Flash\ Builder\ 4.7/sdks/4.6.0
if [[ $# = 1 ]] ; then 
    FLEX_SDK="$1"
fi 

rm -f net.amanitadesign.ANEAmanitaOSX.swc

"$FLEX_SDK"/bin/acompc -namespace http://amanita-design.net/extensions src/manifest.xml	\
    -source-path src	\
    -include-namespaces http://amanita-design.net/extensions	\
    -include-classes	\
    net.amanitadesign.ANEAmanitaOSX.Basic	\
    -output=net.amanitadesign.ANEAmanitaOSX.swc

