//
//  ADSpeechRecognizerPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADSpeechRecognizerPermission.h"

@implementation ADSpeechRecognizerPermission

#ifdef ADPERMISSION_SPEECHRECONGNIZER

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
    
    NSString *speechRecognitionUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADSpeechRecognitionUsageDescription];
    if (!speechRecognitionUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请语音识别使用权限", ADSpeechRecognitionUsageDescription);
#endif
    }
    
    if (ADPermissionStatusDenied == self.status) {
        [self completeWithResult:nil];
        return;
    }
    
    if (ADPermissionStatusNotDetermined == self.status) {
        __weak typeof(self) weakSelf = self;
        [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
            [weakSelf completeWithResult:nil];
        }];
        return;
    };
    
    [self completeWithResult:nil];
}

- (ADPermissionStatus)status {
    SFSpeechRecognizerAuthorizationStatus status = [SFSpeechRecognizer authorizationStatus];
    
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    
    switch (status) {
        case SFSpeechRecognizerAuthorizationStatusAuthorized:
            statusOfPermission = ADPermissionStatusAuthorized;
            break;
        case SFSpeechRecognizerAuthorizationStatusDenied:
        case SFSpeechRecognizerAuthorizationStatusRestricted:
            statusOfPermission = ADPermissionStatusDenied;
            break;
        case SFSpeechRecognizerAuthorizationStatusNotDetermined:
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
