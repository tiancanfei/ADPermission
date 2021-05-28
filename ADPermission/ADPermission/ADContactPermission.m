//
//  ADContactPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADContactPermission.h"

@implementation ADContactPermission

#ifdef ADPERMISSION_CONTACT

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
    NSString *cameraUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADContactUsageDescription];
    if (!cameraUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请通讯录使用权限", ADContactUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            ADPermissionStatus status = granted ? weakSelf.status : ADPermissionStatusDenied;
            NSMutableDictionary *results = [NSMutableDictionary dictionary];
            [results setValue:@(granted) forKey:@"granted"];
            [results setValue:error forKey:@"error"];
            weakSelf.status = status;
            [weakSelf completeWithResult:results];
        }];
        return;
    }
    
    [self completeWithResult:nil];
}

- (ADPermissionStatus)status {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case CNAuthorizationStatusAuthorized:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusRestricted:
            statusOfPermission = ADPermissionStatusDenied;
            break;
        case CNAuthorizationStatusNotDetermined:
            statusOfPermission = ADPermissionStatusNotDetermined;
            break;
            
        default:
            break;
    }
    
    return statusOfPermission;
}

- (BOOL)isAuthorized {
    return ADPermissionStatusAuthorized == self.status;
}

- (BOOL)isDenied {
    return ADPermissionStatusDenied == self.status;
}


#endif

@end
