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

