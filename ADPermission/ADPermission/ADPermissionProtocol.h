//
//  ADPermissionProtocol.h
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import <UIKit/UIKit.h>
#import "ADPermissionConst.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ADPermissionProtocol <NSObject>

@property (nonatomic, assign) ADPermissionStatus status;

@optional

@property (nonatomic, copy, nullable) ADPermissionRequestResult complete;

@property (nonatomic, copy, nullable) ADPermissionRequestResult authorized;

@property (nonatomic, copy, nullable) ADPermissionRequestResult denied;

@property (nonatomic, copy, nullable) ADPermissionRequestResult disabled;

@property (nonatomic, copy, nullable) ADPermissionRequestResult notDetermined;

- (void) requestWithType:(ADPermissionType) type
                  params:(NSDictionary * _Nullable)params;

@end

NS_ASSUME_NONNULL_END