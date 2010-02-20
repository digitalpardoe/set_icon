//
//  DPFileManager.h
//  Set Icon
//
//	See 'LICENSE' for copyright and licensing.
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
