//
//  ADMicrophonePermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADMicrophonePermission.h"

@implementation ADMicrophonePermission

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
    NSString *microphoneUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADMicrophoneUsageDescription];
    if (!microphoneUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请麦克风使用权限", ADMicrophoneUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
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
    AVAudioSessionRecordPermission status = [AVAudioSession sharedInstance].recordPermission;
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case AVAudioSessionRecordPermissionGranted:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case AVAudioSessionRecordPermissionDenied:
            statusOfPermission = ADPermissionStatusDenied;
            break;
            
        default:
            break;
    }
    
    return statusOfPermission;
}


@end
