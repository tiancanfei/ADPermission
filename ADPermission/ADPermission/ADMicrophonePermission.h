//
//  ADMicrophonePermission.h
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ADPermissionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADMicrophonePermission : NSObject<ADPermissionProtocol>

/// 是否已经明确授权
@property (nonatomic, assign) BOOL isAuthorized;

/// 是否已经明确拒绝授权
@property (nonatomic, assign) BOOL isDenied;

@property (nonatomic, assign) ADPermissionStatus status;

@property (nonatomic, copy, nullable) ADPermissionRequestResult complete;

@property (nonatomic, copy, nullable) ADPermissionRequestResult authorized;

@property (nonatomic, copy, nullable) ADPermissionRequestResult denied;

@property (nonatomic, copy, nullable) ADPermissionRequestResult notDetermined;

@end

NS_ASSUME_NONNULL_END
