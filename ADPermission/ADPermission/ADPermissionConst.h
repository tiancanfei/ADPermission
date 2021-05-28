//
//  ADPermissionConst.h
//  ADPermission
//
//  Created by ade on 2021/2/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ADPermissionStatusUnkown,
    ADPermissionStatusAuthorized = 1,
    ADPermissionStatusDenied,
    ADPermissionStatusDisabled,
    ADPermissionStatusNotDetermined,
} ADPermissionStatus;

typedef enum : NSUInteger {
    ADPermissionTypeContact = 1,
    ADPermissionTypeCamera,
    ADPermissionTypePhotos,
    ADPermissionTypeMicrophone,
    ADPermissionTypeLocationWhenInUse,
    ADPermissionTypeLocationAlways,
    ADPermissionTypeMotion,
    ADPermissionTypeSiri,
    ADPermissionTypeSpeechRecognizer,
    ADPermissionTypeCalendar,
    ADPermissionTypeReminder,
    ADPermissionTypeBluetooth,
    ADPermissionTypeMediaLibrary,
    ADPermissionTypeNotifications
} ADPermissionType;

typedef void(^ADPermissionRequestResult)(ADPermissionStatus status, NSDictionary * _Nullable results);

#pragma mark - info.plist中权限申请描述文案key
/// 通讯录权限申请描述
UIKIT_EXTERN NSString *const ADContactUsageDescription;
/// 相机权限申请描述
UIKIT_EXTERN NSString *const ADCameraUsageDescription;
/// 位置权限申请描述（用时候才申请描述）
UIKIT_EXTERN NSString *const ADLocationWhenInUseUsageDescription;
/// 位置权限申请描述
UIKIT_EXTERN NSString *const ADLocationAlwaysUsageDescription;
/// 麦克风权限申请描述
UIKIT_EXTERN NSString *const ADMicrophoneUsageDescription;
/// 语音识别权限申请描述
UIKIT_EXTERN NSString *const ADSpeechRecognitionUsageDescription;
/// 相册权限申请描述
UIKIT_EXTERN NSString *const ADPhotoLibraryUsageDescription;
/// Siri权限申请描述
UIKIT_EXTERN NSString *const ADSiriUsageDescription;
/// 媒体资料库权限申请描述
UIKIT_EXTERN NSString *const ADMediaLibraryUsageDescription;
/// 日历事件权限申请描述
UIKIT_EXTERN NSString *const ADCalendarsUsageDescription;
/// 提醒事件权限申请描述
UIKIT_EXTERN NSString *const ADRemindersUsageDescription;
/// 运动与健康事件权限申请描述
UIKIT_EXTERN NSString *const ADMotionUsageDescription;

#pragma mark - 其他key
/// 通知相关key UNAuthorizationOptions
UIKIT_EXTERN NSString *const ADNotificationsOptionsKey;

NS_ASSUME_NONNULL_END
