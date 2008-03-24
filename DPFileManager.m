//
//  DPFileManager.m
//  Set Icon
//
//  Created by Alex on 24/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import "DPFileManager.h"

@implementation NSFileManager(DPFileManager)

- (BOOL)copyPathWithAuthentication:(NSString *)src toPath:(NSString *)dst
{
	AuthorizationItem right = { "co.uk.digitalpardoe.Authenticate", 0, NULL, 0 };
	AuthorizationRights rightSet = { 1, &right };
	AuthorizationFlags myFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights;
	AuthorizationRef authorizationRef;
	OSStatus myStatus;
	
	myStatus = AuthorizationCreate(&rightSet, kAuthorizationEmptyEnvironment, myFlags, &authorizationRef);
	
	if (myStatus != errAuthorizationSuccess)
	{
		return false;
	}
	
	FILE *pipe = NULL;
	
	char *buf = NULL;
	asprintf(&buf, "cp -f \"$SRC_PATH\" \"$DST_PATH\"");
			 
	setenv("SRC_PATH", [src UTF8String], 1);
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
	return true;
}

- (BOOL)setDriveIconWithAuthentication:(NSString *)dst
{
	AuthorizationItem right = { "co.uk.digitalpardoe.Authenticate", 0, NULL, 0 };
	AuthorizationRights rightSet = { 1, &right };
	AuthorizationFlags myFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights;
	AuthorizationRef authorizationRef;
	OSStatus myStatus;
	
	myStatus = AuthorizationCreate(&rightSet, kAuthorizationEmptyEnvironment, myFlags, &authorizationRef);
	
	if (myStatus != errAuthorizationSuccess)
	{
		return false;
	}
	
	FILE *pipe = NULL;
	
	char *buf = NULL;
	asprintf(&buf, "SetFile -a C \"$DST_PATH\"");
			 
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
	return true;
}

- (BOOL)deletePathWithAuthentication:(NSString *)dst
{
	AuthorizationItem right = { "co.uk.digitalpardoe.Authenticate", 0, NULL, 0 };
	AuthorizationRights rightSet = { 1, &right };
	AuthorizationFlags myFlags = kAuthorizationFlagDefaults | kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights;
	AuthorizationRef authorizationRef;
	OSStatus myStatus;
	
	myStatus = AuthorizationCreate(&rightSet, kAuthorizationEmptyEnvironment, myFlags, &authorizationRef);
	
	if (myStatus != errAuthorizationSuccess)
	{
		return false;
	}
	
	FILE *pipe = NULL;
	
	char *buf = NULL;
	asprintf(&buf, "rm -f \"$DST_PATH\"");
			 
	setenv("DST_PATH", [dst UTF8String], 1);
	
	char const *arguments[] = { "-c", buf, NULL };
	
	AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh", kAuthorizationFlagDefaults, (char**)arguments, &pipe);
	return true;
}

@end
