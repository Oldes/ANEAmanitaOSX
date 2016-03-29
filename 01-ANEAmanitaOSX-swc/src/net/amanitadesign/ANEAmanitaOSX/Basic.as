// ADOBE SYSTEMS INCORPORATED
//  Copyright 2011 Adobe Systems Incorporated
//  All Rights Reserved.
//
// NOTICE: Adobe permits you to use, modify, and distribute this file in accordance with the
// terms of the Adobe license agreement accompanying it.  If you have received this file from a
// source other than Adobe, then your use, modification, or distribution of it requires the prior
// written permission of Adobe.

package net.amanitadesign.ANEAmanitaOSX
{
	import flash.external.ExtensionContext;
	
	// This class prints "Hello World!" on either ActionScript or native code using
	// native extensions, depending on the value of 'mode'.
	
	public class Basic
	{
		public function helloWorld(mode:uint = 0) : String
		{
			if ( mode == 0 ) {
				return "[Basic.as]: Hello World!";
			} else {
				var ctx:ExtensionContext = ExtensionContext.createExtensionContext( "net.amanitadesign.ANEAmanitaOSX", "Basic" );
          		        return String( ctx.call( "helloWorld" ) );
			}
		}
	}
}
