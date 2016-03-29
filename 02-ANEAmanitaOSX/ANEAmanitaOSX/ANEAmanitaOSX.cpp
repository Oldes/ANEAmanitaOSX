//
//  ANEAmanitaOSX.cpp
//  ANEAmanitaOSX
//
//  Created by Oldes on 29/03/16.
//  Copyright (c) 2016 Amanita Design. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <AssertMacros.h>
#include <Adobe AIR/Adobe AIR.h>


// Symbols tagged with EXPORT are externally visible.
// Must use the -fvisibility=hidden gcc option.
#define EXPORT __attribute__((visibility("default")))



extern "C"
{
    // Function to print "Hello World!".
    FREObject _Basic_helloWorld(FREContext ctx, void* functionData, uint32_t argc, FREObject argv[])
    {
        FREObject strResult;
        const char* msg = "[Native Code]: Hello MAC from Amanita!";
        FRENewObjectFromUTF8( strlen(msg)+1, (const uint8_t *) msg, &strResult );
        return strResult;
    }
    
    
    FRENamedFunction _Basic_methods[] = {
        { (const uint8_t*) "helloWorld", 0, _Basic_helloWorld }
    };
    
    void _ctxInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
                         uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet)
    {
        if ( 0 == strcmp( (const char*) ctxType, "Basic" ) )
        {
            *numFunctionsToSet = 1;
            *functionsToSet = _Basic_methods;
        }
    }
    
    void _ctxFinalizer(FREContext ctx)
    {
    }
    
    // Framework entry point
    EXPORT
    void NativeExtensionsInitializer(void** extDataToSet, 
                                     FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
    {
        *ctxInitializerToSet = _ctxInitializer;
        *ctxFinalizerToSet = _ctxFinalizer;
    }
    
    // Framework entry point
    EXPORT
    void NativeExtensionsFinalizer(void* extData)
    {
    }
}
