//
//  ADPermission.h
//  ADPermission
//
//  Created by ade on 2021/2/6.
//

#import <UIKit/UIKit.h>
#import "ADPermissionConst.h"
#import "ADContactPermission.h"
#import "ADCameraPermission.h"
#import "ADPhotosPermission.h"
#import "ADMicrophonePermission.h"
#import "ADLocationPermission.h"
#import "ADSiriPermission.h"
#import "ADSpeechRecognizerPermission.h"
#import "ADCalendarPermission.h"
#import "ADReminderPermission.h"
#import "ADMediaLibraryPermission.h"
#import "ADMotionPermission.h"
#import "ADBluetoothPermission.h"
#import "ADNotificationsPermission.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADPermission : NSObject

/// 通讯录
@property (nonatomic, strong, readonly) ADContactPermission *contactPermission;

/// 相机
@property (nonatomic, strong, readonly) ADCameraPermission *cameraPermission;

/// 麦克风
@property (nonatomic, strong, readonly) ADMicrophonePermission *microphonePermission;

/// Siri
@property (nonatomic, strong, readonly) ADSiriPermission *siriPermission;

/// 相册
@property (nonatomic, strong, readonly) ADPhotosPermission *photosPermission;

/// 定位
@property (nonatomic, strong, readonly) ADLocationPermission *locationPermission;

/// 运动与健康
@property (nonatomic, strong, readonly) ADMotionPermission *motionPermission;

/// 语音识别
@property (nonatomic, strong, readonly) ADSpeechRecognizerPermission *speechRecognizerPermission;

/// 日历事件
@property (nonatomic, strong, readonly) ADCalendarPermission *calendarPermission;

/// 提醒事件
@property (nonatomic, strong, readonly) ADReminderPermission *reminderPermission;

/// 蓝牙
@property (nonatomic, strong, readonly) ADBluetoothPermission *bluetoothPermission;

/// 通知
@property (nonatomic, strong, readonly) ADNotificationsPermission *notificationsPermission;

- (void) requestWithType:(ADPermissionType) type
                  params:(NSDictionary * _Nullable)params;

@end

NS_ASSUME_NONNULL_END
