//
//  ADMediaLibraryPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADMediaLibraryPermission.h"

@implementation ADMediaLibraryPermission

#ifdef ADPERMISSION_MEDIALIBRARY

#pragma mark - 自定义方法

#pragma mark 结果处理
/// 结果处理
- (void) completeWithResult:(NSDictionary *)result {
    
    if (self.complete) {
        self.complete(self.status, result);
    }
    
    if (ADPermissionStatusAuthorized == self.status) {
        if (self.authorized) {
            self.authorized(self.status, result);
        }
        return;
    }
    
    if (ADPermissionStatusDenied == self.status) {
        if (self.denied) {
            self.denied(self.status, result);
        }
        return;
    }
    
    if (ADPermissionStatusDisabled == self.status) {
        if (self.disabled) {
            self.disabled(self.status, result);
        }
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        if (self.notDetermined) {
            self.notDetermined(self.status, result);
        }
        return;
    }
}

#pragma mark - ADPermissionProtocol

- (void)requestWithType:(ADPermissionType)type
                 params:(NSDictionary *)params {
    NSString *mediaLibraryUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADMediaLibraryUsageDescription];
    if (!mediaLibraryUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请媒体库使用权限", ADMediaLibraryUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
            [weakSelf completeWithResult:nil];
        }];
        return;
    };
    
    [self completeWithResult:nil];
}

- (ADPermissionStatus)status {
    MPMediaLibraryAuthorizationStatus status = [MPMediaLibrary authorizationStatus];
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case MPMediaLibraryAuthorizationStatusAuthorized:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case MPMediaLibraryAuthorizationStatusDenied:
        case MPMediaLibraryAuthorizationStatusRestricted:
            statusOfPermission = ADPermissionStatusDenied;
            break;
        case MPMediaLibraryAuthorizationStatusNotDetermined:
            statusOfPermission = ADPermissionStatusNotDetermined;
            break;
            
        default:
            break;
    }
    
    return statusOfPermission;
}

#endif

@end
