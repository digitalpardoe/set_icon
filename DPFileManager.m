//
//  DPFileManager.m
//  Set Icon
//
//  Created by Alex on 24/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPFileManager.h"

AuthorizationRef authorizationRef;
BOOL authorized;

@implementation NSFileManager(DPFileManager)

- (void)authenticate
{
	AuthorizationItem right = { kAuthorizationRightExecute, 0, NULL, 0 };
	AuthorizationRights rightSet = { 1, &right };
	AuthorizationFlags myFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights | kAuthorizationFlagPreAuthorize;
	OSStatus myStatus;
	
	myStatus = AuthorizationCreate(&rightSet, kAuthorizationEmptyEnvironment, myFlags, &authorizationRef);
	
	authorized = (errAuthorizationSuccess == myStatus);
}

- (BOOL)authorized
{
	return authorized;
}

- (void)copyPathWithAuthentication:(NSString *)src toPath:(NSString *)dst
{
	FILE *pipe = NULL;
	
	char *buf = NULL;
	asprintf(&buf, "cp -f \"$SRC_PATH\" \"$DST_PATH\"");
			 
	setenv("SRC_PATH", [src UTF8String], 1);
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
}

- (void)setDriveIconWithAuthentication:(NSString *)dst
{
	FILE *pipe = NULL;
	
	NSString *toolPath = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"SetHasCustomIcon"];
	
	char *buf = NULL;
	asprintf(&buf, "\"$TOOL_PATH\" -C \"$DST_PATH\"");
			 
	setenv("TOOL_PATH", [toolPath UTF8String], 1);
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
}

- (void)deletePathWithAuthentication:(NSString *)dst
{
	FILE *pipe = NULL;
	
	char *buf = NULL;
	asprintf(&buf, "rm -f \"$DST_PATH\"");
			 
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
}

- (BOOL)isDrive:(NSString *)path
{
	BOOL isDir;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	[fileManager fileExistsAtPath:path isDirectory:&isDir];

	if([[path pathComponents] count] == 1)
	{
		isDir = YES;
	} else if(![[path substringToIndex:8] isEqualToString:@"/Volumes"])
	{
		isDir = NO;
	} else if ([[path substringToIndex:8] isEqualToString:@"/Volumes"] && [[path pathComponents] count] != 3)
	{
		isDir = NO;
	}
	
	return isDir;
}

@end
