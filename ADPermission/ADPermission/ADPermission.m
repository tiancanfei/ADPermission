//
//  ADPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/6.
//

#import "ADPermission.h"

ADPermission *_adPermissionShareInstance;

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
    
    /// 媒体库
    ADMediaLibraryPermission *_mediaLibraryPermission;

    /// 通知
    ADNotificationsPermission *_notificationsPermission;
}

+ (instancetype) permissionShare {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _adPermissionShareInstance = [[ADPermission alloc] init];
    });
    return _adPermissionShareInstance;
}

+ (instancetype) requestWithType:(ADPermissionType) type
                          params:(NSDictionary * _Nullable)params {
    ADPermission *permission = [ADPermission permissionShare];
    [permission requestWithType:type params:params];
    return permission;
}

- (void) requestWithType:(ADPermissionType) type
                  params:(NSDictionary * _Nullable)params {
    switch (type) {
        case ADPermissionTypeContact:
        {
#ifdef ADPERMISSION_CONTACT
            [self.contactPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeCamera:
        {
#ifdef ADPERMISSION_CAMERA
            [self.cameraPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypePhotos:
        {
#ifdef ADPERMISSION_PHOTOS
            [self.photosPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMicrophone:
        {
#ifdef ADPERMISSION_MICROPHONE
            [self.microphonePermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeLocationWhenInUse:
        {
#ifdef ADPERMISSION_LOCATION
            [self.locationPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeLocationAlways:
        {
#ifdef ADPERMISSION_LOCATION
            [self.locationPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMotion:
        {
#ifdef ADPERMISSION_MOTION
            [self.motionPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeSiri:
        {
#ifdef ADPERMISSION_SIRI
            [self.siriPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeSpeechRecognizer:
        {
#ifdef ADPERMISSION_SPEECHRECONGNIZER
            [self.speechRecognizerPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeCalendar:
        {
#ifdef ADPERMISSION_CALENDAR
            [self.calendarPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeReminder:
        {
#ifdef ADPERMISSION_REMINDER
            [self.reminderPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMediaLibrary:
        {
#ifdef ADPERMISSION_MEDIALIBRARY
            [self.mediaLibraryPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeBluetooth:
        {
#ifdef ADPERMISSION_BLUETOOTH
            [self.bluetoothPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeNotifications:
        {
#ifdef ADPERMISSION_NOTIFICATIONS
            [self.notificationsPermission requestWithType:type params:params];
#endif
        }
            break;
                
        default:
            break;
    }
}

#pragma mark - setters getters

- (ADContactPermission *)contactPermission {
#ifdef ADPERMISSION_CONTACT
    if (!_contactPermission) {
        _contactPermission = [[ADContactPermission alloc] init];
    }
#else
    _contactPermission = nil;
#endif
    return _contactPermission;
}

- (ADCameraPermission *) cameraPermission {
#ifdef ADPERMISSION_CAMERA
    if (!_cameraPermission) {
        _cameraPermission = [[ADCameraPermission alloc] init];
    }
#else
    _cameraPermission = nil;
#endif
    return _cameraPermission;
}

- (ADPhotosPermission *) photosPermission {
#ifdef ADPERMISSION_PHOTOS
    if (!_photosPermission) {
        _photosPermission = [[ADPhotosPermission alloc] init];
    }
#else
    _photosPermission = nil;
#endif
    return _photosPermission;
}

- (ADMicrophonePermission *) microphonePermission {
#ifdef ADPERMISSION_MICROPHONE
    if (!_microphonePermission) {
        _microphonePermission = [[ADMicrophonePermission alloc] init];
    }
#else
    _microphonePermission = nil;
#endif
    return _microphonePermission;
}

- (ADLocationPermission *) locationPermission {
#ifdef ADPERMISSION_LOCATION
    if (!_locationPermission) {
        _locationPermission = [[ADLocationPermission alloc] init];
    }
#else
    _locationPermission = nil;
#endif
    return _locationPermission;
}

- (ADMotionPermission *) motionPermission {
#ifdef ADPERMISSION_MOTION
    if (!_motionPermission) {
        _motionPermission = [[ADMotionPermission alloc] init];
    }
#else
    _motionPermission = nil;
#endif
    return _motionPermission;
}

- (ADSiriPermission *) siriPermission {
#ifdef ADPERMISSION_SIRI
    if (!_siriPermission) {
        _siriPermission = [[ADSiriPermission alloc] init];
    }
#else
    _siriPermission = nil;
#endif
    return _siriPermission;
}

- (ADSpeechRecognizerPermission *) speechRecognizerPermission {
#ifdef ADPERMISSION_SPEECHRECONGNIZER
    if (!_speechRecognizerPermission) {
        _speechRecognizerPermission = [[ADSpeechRecognizerPermission alloc] init];
    }
#else
    _speechRecognizerPermission = nil;
#endif
    return _speechRecognizerPermission;
}

- (ADCalendarPermission *) calendarPermission {
#ifdef ADPERMISSION_CALENDAR
    if (!_calendarPermission) {
        _calendarPermission = [[ADCalendarPermission alloc] init];
    }
#else
    _calendarPermission = nil;
#endif
    return _calendarPermission;
}

- (ADReminderPermission *) reminderPermission {
#ifdef ADPERMISSION_REMINDER
    if (!_reminderPermission) {
        _reminderPermission = [[ADReminderPermission alloc] init];
    }
#else
    _reminderPermission = nil;
#endif
    return _reminderPermission;
}

- (ADBluetoothPermission *) bluetoothPermission {
#ifdef ADPERMISSION_BLUETOOTH
    if (!_bluetoothPermission) {
        _bluetoothPermission = [[ADBluetoothPermission alloc] init];
    }
#else
    _bluetoothPermission = nil;
#endif
    return _bluetoothPermission;
}

- (ADMediaLibraryPermission *) mediaLibraryPermission {
#ifdef ADPERMISSION_MEDIALIBRARY
    if (!_mediaLibraryPermission) {
        _mediaLibraryPermission = [[ADMediaLibraryPermission alloc] init];
    }
#else
    _mediaLibraryPermission = nil;
#endif
    return _mediaLibraryPermission;
}

- (ADNotificationsPermission *) notificationsPermission {
#ifdef ADPERMISSION_NOTIFICATIONS
    if (!_notificationsPermission) {
        _notificationsPermission = [[ADNotificationsPermission alloc] init];
    }
#else
    _notificationsPermission = nil;
#endif
    return _notificationsPermission;
}


@end
