//
//  ADPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/6.
//

#import "ADPermission.h"

@implementation ADPermission
{
    /// 通讯录
    ADContactPermission *_contactPermission;

    /// 相机
    ADCameraPermission *_cameraPermission;

    /// 麦克风
    ADMicrophonePermission *_microphonePermission;

    /// Siri
    ADSiriPermission *_siriPermission;

    /// 相册
    ADPhotosPermission *_photosPermission;

    /// 定位
    ADLocationPermission *_locationPermission;

    /// 运动与健康
    ADMotionPermission *_motionPermission;

    /// 语音识别
    ADSpeechRecognizerPermission *_speechRecognizerPermission;

    /// 日历事件
    ADCalendarPermission *_calendarPermission;

    /// 提醒事件
    ADReminderPermission *_reminderPermission;

    /// 蓝牙
    ADBluetoothPermission *_bluetoothPermission;

    /// 通知
    ADNotificationsPermission *_notificationsPermission;
}

- (void) requestWithType:(ADPermissionType) type
                  params:(NSDictionary * _Nullable)params {
    switch (type) {
        case ADPermissionTypeContact:
        {
            [self.contactPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeCamera:
        {
            [self.cameraPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypePhotos:
        {
            [self.photosPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeMicrophone:
        {
            [self.microphonePermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeLocationWhenInUse:
        {
            [self.locationPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeLocationAlways:
        {
            [self.locationPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeMotion:
        {
            [self.motionPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeSiri:
        {
            [self.siriPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeSpeechRecognizer:
        {
            [self.speechRecognizerPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeCalendar:
        {
            [self.calendarPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeReminder:
        {
            [self.reminderPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeBluetooth:
        {
            [self.bluetoothPermission requestWithType:type params:params];
        }
            break;
        case ADPermissionTypeNotifications:
        {
            [self.notificationsPermission requestWithType:type params:params];
        }
            break;
                
        default:
            break;
    }
}

#pragma mark - setters getters

- (ADContactPermission *)contactPermission {
    if (!_contactPermission) {
        _contactPermission = [[ADContactPermission alloc] init];
    }
    return _contactPermission;
}

- (ADCameraPermission *)cameraPermission {
    if (!_cameraPermission) {
        _cameraPermission = [[ADCameraPermission alloc] init];
    }
    return _cameraPermission;
}

- (ADMicrophonePermission *)microphonePermission {
    if (!_microphonePermission) {
        _microphonePermission = [[ADMicrophonePermission alloc] init];
    }
    return _microphonePermission;
}

- (ADPhotosPermission *)photosPermission {
    if (!_photosPermission) {
        _photosPermission = [[ADPhotosPermission alloc] init];
    }
    return _photosPermission;
}

- (ADLocationPermission *)locationPermission {
    if (!_locationPermission) {
        _locationPermission = [[ADLocationPermission alloc] init];
    }
    return _locationPermission;
}

- (ADMotionPermission *)motionPermission {
    if (!_motionPermission) {
        _motionPermission = [[ADMotionPermission alloc] init];
    }
    return _motionPermission;
}

- (ADSiriPermission *)siriPermission {
    if (!_siriPermission) {
        _siriPermission = [[ADSiriPermission alloc] init];
    }
    return _siriPermission;
}

- (ADSpeechRecognizerPermission *)speechRecognizerPermission {
    if (!_speechRecognizerPermission) {
        _speechRecognizerPermission = [[ADSpeechRecognizerPermission alloc] init];
    }
    return _speechRecognizerPermission;
}

- (ADCalendarPermission *)calendarPermission {
    if (!_calendarPermission) {
        _calendarPermission = [[ADCalendarPermission alloc] init];
    }
    return _calendarPermission;
}

- (ADReminderPermission *)reminderPermission {
    if (!_reminderPermission) {
        _reminderPermission = [[ADReminderPermission alloc] init];
    }
    return _reminderPermission;
}

- (ADBluetoothPermission *)bluetoothPermission {
    if (!_bluetoothPermission) {
        _bluetoothPermission = [[ADBluetoothPermission alloc] init];
    }
    return _bluetoothPermission;
}

- (ADNotificationsPermission *)notificationsPermission {
    if (!_notificationsPermission) {
        _notificationsPermission = [[ADNotificationsPermission alloc] init];
    }
    return _notificationsPermission;
}

@end
