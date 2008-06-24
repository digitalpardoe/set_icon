//
//  DPFileManager.h
//  Set Icon
//
//  Created by Alex on 24/03/2008.
//  Copyright 2008 digital:pardoe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSFileManager(DPAuthFileManager)

- (void)authenticate;
- (BOOL)authorized;
- (void)copyPathWithAuthentication:(NSString *)src toPath:(NSString *)dst;
- (void)setDriveIconWithAuthentication:(NSString *)dst;
- (void)deletePathWithAuthentication:(NSString *)dst;
- (BOOL)isDrive:(NSString *)path;

@end
