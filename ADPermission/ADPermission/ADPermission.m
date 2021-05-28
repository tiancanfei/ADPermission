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
            _contactPermission = [[ADContactPermission alloc] init];
            [self.contactPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeCamera:
        {
#ifdef ADPERMISSION_CAMERA
            _cameraPermission = [[ADCameraPermission alloc] init];
            [self.cameraPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypePhotos:
        {
#ifdef ADPERMISSION_PHOTOS
            _photosPermission = [[ADPhotosPermission alloc] init];
            [self.photosPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMicrophone:
        {
#ifdef ADPERMISSION_MICROPHONE
            _microphonePermission = [[ADMicrophonePermission alloc] init];
            [self.microphonePermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeLocationWhenInUse:
        {
#ifdef ADPERMISSION_LOCATION
            _locationPermission = [[ADLocationPermission alloc] init];
            [self.locationPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeLocationAlways:
        {
#ifdef ADPERMISSION_LOCATION
            _locationPermission = [[ADLocationPermission alloc] init];
            [self.locationPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMotion:
        {
#ifdef ADPERMISSION_MOTION
            _motionPermission = [[ADMotionPermission alloc] init];
            [self.motionPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeSiri:
        {
#ifdef ADPERMISSION_SIRI
            _siriPermission = [[ADSiriPermission alloc] init];
            [self.siriPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeSpeechRecognizer:
        {
#ifdef ADPERMISSION_SPEECHRECONGNIZER
            _speechRecognizerPermission = [[ADSpeechRecognizerPermission alloc] init];
            [self.speechRecognizerPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeCalendar:
        {
#ifdef ADPERMISSION_CALENDAR
            _calendarPermission = [[ADCalendarPermission alloc] init];
            [self.calendarPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeReminder:
        {
#ifdef ADPERMISSION_REMINDER
            _reminderPermission = [[ADReminderPermission alloc] init];
            [self.reminderPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeMediaLibrary:
        {
#ifdef ADPERMISSION_MEDIALIBRARY
            _mediaLibraryPermission = [[ADMediaLibraryPermission alloc] init];
            [self.mediaLibraryPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeBluetooth:
        {
#ifdef ADPERMISSION_BLUETOOTH
            _bluetoothPermission = [[ADBluetoothPermission alloc] init];
            [self.bluetoothPermission requestWithType:type params:params];
#endif
        }
            break;
        case ADPermissionTypeNotifications:
        {
#ifdef ADPERMISSION_NOTIFICATIONS
            _notificationsPermission = [[ADNotificationsPermission alloc] init];
            [self.notificationsPermission requestWithType:type params:params];
#endif
        }
            break;
                
        default:
            break;
    }
}

@end
