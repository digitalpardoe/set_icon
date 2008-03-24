//
//  DPFileManager.h
//  Set Icon
//
//  Created by Alex on 24/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Security/Security.h>

@interface NSFileManager(DPFileManager)

- (BOOL)copyPathWithAuthentication:(NSString *)src toPath:(NSString *)dst;
- (BOOL)setDriveIconWithAuthentication:(NSString *)dst;
- (BOOL)deletePathWithAuthentication:(NSString *)dst;

@end
