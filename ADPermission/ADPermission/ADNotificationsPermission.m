//
//  ADNotificationsPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADNotificationsPermission.h"

@interface ADNotificationsPermission()

@property (nonatomic, strong, nullable) NSDictionary *params;

@property (nonatomic, assign) BOOL requestedNotifications;

@property (nonatomic, assign) ADPermissionStatus synchronousStatusNotifications;

@property (nonatomic, assign) UNAuthorizationOptions options;

@end

@implementation ADNotificationsPermission

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
    __weak typeof(self) weakSelf = self;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:self.options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        weakSelf.requestedNotifications = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableDictionary *results = [NSMutableDictionary dictionary];
            [results setValue:@(granted) forKey:@"granted"];
            [results setValue:error forKey:@"error"];
            [weakSelf completeWithResult:results];
        });
    }];
}

- (ADPermissionStatus)status {
    if (self.requestedNotifications) {
        return self.synchronousStatusNotifications;
    }
    return ADPermissionStatusNotDetermined;
}

- (ADPermissionStatus)synchronousStatusNotifications {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block ADPermissionStatus status = ADPermissionStatusNotDetermined;
    
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        switch (settings.authorizationStatus) {
            case UNAuthorizationStatusAuthorized:
                status = ADPermissionStatusAuthorized;
                break;
            case UNAuthorizationStatusDenied:
                status = ADPermissionStatusDenied;
                break;
            case UNAuthorizationStatusNotDetermined:
                status = ADPermissionStatusNotDetermined;
                break;
            case UNAuthorizationStatusProvisional:
                status = ADPermissionStatusAuthorized;
                break;
                
            default:
                status = ADPermissionStatusNotDetermined;
                break;
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return status;
}

- (UNAuthorizationOptions)options {
    UNAuthorizationOptions options = (UNAuthorizationOptions)[self.params[ADNotificationsOptionsKey] integerValue];
    return options;
}

@end
