//
//  ADCameraPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADCameraPermission.h"

@implementation ADCameraPermission

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
    NSString *cameraUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADCameraUsageDescription];
    if (!cameraUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请相机使用权限", ADCameraUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            ADPermissionStatus status = granted ? weakSelf.status : ADPermissionStatusDenied;
            NSMutableDictionary *results = [NSMutableDictionary dictionary];
            [results setValue:@(granted) forKey:@"granted"];
            weakSelf.status = status;
            [weakSelf completeWithResult:results];
        }];
        return;
    };
    
    [self completeWithResult:nil];
}

- (ADPermissionStatus)status {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case AVAuthorizationStatusAuthorized:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            statusOfPermission = ADPermissionStatusDenied;
            break;
        case AVAuthorizationStatusNotDetermined:
            statusOfPermission = ADPermissionStatusNotDetermined;
            break;
            
        default:
            break;
    }
    
    return statusOfPermission;
}

@end
