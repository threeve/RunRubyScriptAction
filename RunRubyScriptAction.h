//
//  RubyScriptAction.h
//  RubyScriptAction
//
//  Created by Jason Foreman on 12/16/07.
//  Copyright 2008 Jason Foreman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RubyScriptActionLoader : NSObject
{
}
@end

@interface LSWrapper : NSObject
{}
+ (NSString*)bundleIdentifierForApplicationWithName:(NSString*)name;
@end

