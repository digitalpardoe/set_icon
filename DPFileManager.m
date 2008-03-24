//
//  DPFileManager.m
//  Set Icon
//
//  Created by Alex on 24/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPFileManager.h"

AuthorizationRef authorizationRef;

@implementation NSFileManager(DPFileManager)

- (void)authenticate
{
	AuthorizationItem right = { "co.uk.digitalpardoe.Authenticate", 0, NULL, 0 };
	AuthorizationRights rightSet = { 1, &right };
	AuthorizationFlags myFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights;
	OSStatus myStatus;
	
	myStatus = AuthorizationCreate(&rightSet, kAuthorizationEmptyEnvironment, myFlags, &authorizationRef);
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
	
	char *buf = NULL;
	asprintf(&buf, "SetFile -a C \"$DST_PATH\"");
			 
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

@end
