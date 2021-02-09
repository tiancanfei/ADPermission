//
//  ADSiriPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADSiriPermission.h"

@implementation ADSiriPermission

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
    NSString *siriUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADSiriUsageDescription];
    if (!siriUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请Siri使用权限", ADSiriUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        [INPreferences requestSiriAuthorization:^(INSiriAuthorizationStatus status) {
            [weakSelf completeWithResult:nil];
        }];
        return;
    };
    
    [self completeWithResult:nil];
}

- (ADPermissionStatus)status {
    INSiriAuthorizationStatus status = [INPreferences siriAuthorizationStatus];
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case INSiriAuthorizationStatusAuthorized:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case INSiriAuthorizationStatusDenied:
        case INSiriAuthorizationStatusRestricted:
            statusOfPermission = ADPermissionStatusDenied;
            break;
        case INSiriAuthorizationStatusNotDetermined:
            statusOfPermission = ADPermissionStatusNotDetermined;
            break;
            
        default:
            break;
    }
    
    return statusOfPermission;
}

@end
