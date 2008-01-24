//
//  RubyScriptAction.m
//  RubyScriptAction
//
//  Created by Jason Foreman on 12/16/07.
//  Copyright 2007 Jason Foreman. All rights reserved.
//

#import "RunRubyScriptAction.h"


void __attribute__((constructor)) loadRubyScriptAction(void)
{
	NSAutoreleasePool *thePool = [[NSAutoreleasePool alloc] init];
	[[[RubyScriptActionLoader alloc] init] autorelease];
	[thePool release];	
}

@implementation RubyScriptActionLoader

+ (void) load;
{
    RBBundleInit("RunRubyScriptAction.rb", self, nil);
	
	// http://www.cocoabuilder.com/archive/message/cocoa/2004/8/5/113725
	NSString *fontsFolder = [[NSBundle bundleForClass:[RubyScriptActionLoader class]] resourcePath];
	if (fontsFolder) {
		NSURL *fontsURL = [NSURL fileURLWithPath:fontsFolder];
		if (fontsURL) {
			FSRef fsRef;
			FSSpec fsSpec;
			(void)CFURLGetFSRef((CFURLRef)fontsURL, &fsRef);
			OSStatus status = FSGetCatalogInfo(&fsRef, kFSCatInfoNone, NULL, 
											   NULL, &fsSpec, NULL);
			if (noErr == status) {
				FMGeneration generationCount = FMGetGeneration();
				status = FMActivateFonts(&fsSpec, NULL, NULL, 
										 kFMLocalActivationContext);
				generationCount = FMGetGeneration() - generationCount;
				if (generationCount) {
					NSLog(@"app - added %u font file%s", generationCount, 
						  (generationCount == 1 ? "" : "s"));
				}
			}
		}
	}
}

@end


@implementation LSWrapper

+ (NSString*)bundleIdentifierForApplicationWithName:(NSString*)name;
{
	NSString *fullname = [name stringByAppendingPathExtension:@"app"];
	CFURLRef appURL;

	OSErr err = LSFindApplicationForInfo(kLSUnknownCreator, nil, (CFStringRef)fullname, NULL, &appURL);
	
	NSString *path = (NSString*)CFURLCopyFileSystemPath(appURL, kCFURLPOSIXPathStyle);
	[(NSURL*)appURL release];
	[path autorelease];
	
	NSBundle *bundle = [NSBundle bundleWithPath:path];
	return [bundle bundleIdentifier];
}

@end

