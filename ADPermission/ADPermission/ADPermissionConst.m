//
//  ADPermissionConst.m
//  ADPermission
//
//  Created by ade on 2021/2/6.
//

#import "ADPermissionConst.h"

#pragma mark - info.plist中权限申请描述文案key
/// 通讯录权限申请描述
NSString *const ADContactUsageDescription = @"NSContactsUsageDescription";
/// 相机权限申请描述
NSString *const ADCameraUsageDescription = @"NSCameraUsageDescription";
/// 位置权限申请描述（用时候才申请描述）
NSString *const ADLocationWhenInUseUsageDescription = @"NSLocationWhenInUseUsageDescription";
/// 位置权限申请描述
NSString *const ADLocationAlwaysUsageDescription = @"NSLocationAlwaysAndWhenInUseUsageDescription";
/// 麦克风权限申请描述
NSString *const ADMicrophoneUsageDescription = @"NSMicrophoneUsageDescription";
/// 语音识别权限申请描述
NSString *const ADSpeechRecognitionUsageDescription = @"NSSpeechRecognitionUsageDescription";
/// 相册权限申请描述
NSString *const ADPhotoLibraryUsageDescription = @"NSPhotoLibraryUsageDescription";
/// Siri权限申请描述
NSString *const ADSiriUsageDescription = @"NSSiriUsageDescription";
/// 媒体资料库权限申请描述
NSString *const ADMediaLibraryUsageDescription = @"NSAppleMusicUsageDescription";
/// 日历事件权限申请描述
NSString *const ADCalendarsUsageDescription = @"NSCalendarsUsageDescription";
/// 提醒事件权限申请描述
NSString *const ADRemindersUsageDescription = @"NSRemindersUsageDescription";
/// 运动与健康事件权限申请描述
NSString *const ADMotionUsageDescription = @"NSMotionUsageDescription";

#pragma mark - 其他key
/// 通知相关key UNAuthorizationOptions
NSString *const ADNotificationsOptionsKey = @"ADNotificationsOptionsKey";
