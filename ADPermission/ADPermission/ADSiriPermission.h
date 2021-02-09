//
//  ADSiriPermission.h
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import <UIKit/UIKit.h>
#import <Intents/Intents.h>
#import "ADPermissionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ADSiriPermission : NSObject<ADPermissionProtocol>

@property (nonatomic, assign) ADPermissionStatus status;

@property (nonatomic, copy, nullable) ADPermissionRequestResult complete;

@property (nonatomic, copy, nullable) ADPermissionRequestResult authorized;

@property (nonatomic, copy, nullable) ADPermissionRequestResult denied;

@property (nonatomic, copy, nullable) ADPermissionRequestResult notDetermined;

@end

NS_ASSUME_NONNULL_END
