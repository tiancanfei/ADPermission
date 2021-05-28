//
//  ADMotionPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADMotionPermission.h"

@interface ADMotionPermission()

@property (nonatomic, strong) CMMotionActivityManager *motionManager;

@property (nonatomic, assign) BOOL requestedMotion;

@property (nonatomic, assign) ADPermissionStatus synchronousStatusMotion;

@end

@implementation ADMotionPermission

#ifdef ADPERMISSION_MOTION

#pragma mark - 自定义方法

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

- (void) requestWithType:(ADPermissionType)type
                  params:(NSDictionary *)params {
    NSString *motionUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADMotionUsageDescription];
    if (!motionUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请运动与健康事件使用权限", ADMotionUsageDescription);
#endif
    }

    self.requestedMotion = YES;
    NSDate *now = [[NSDate alloc] init];
    __weak typeof(self) weakSelf = self;
    [self.motionManager queryActivityStartingFromDate:now toDate:now toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
        ADPermissionStatus status = ADPermissionStatusUnkown;
        if (error) {
            if (error.code == CMErrorMotionActivityNotAuthorized) {
                status = ADPermissionStatusDenied;
            }
        } else {
            status = ADPermissionStatusAuthorized;
        }
        
        [weakSelf.motionManager stopActivityUpdates];
        
        weakSelf.status = status;
        [weakSelf completeWithResult:nil];
    }];
}

- (ADPermissionStatus)status {
    return self.requestedMotion ? self.synchronousStatusMotion : ADPermissionStatusNotDetermined;
}

#pragma mark - setters getters

- (CMMotionActivityManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionActivityManager alloc] init];
    }
    return _motionManager;
}

- (ADPermissionStatus)synchronousStatusMotion {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block ADPermissionStatus status = ADPermissionStatusNotDetermined;
    
    NSDate *now = [[NSDate alloc] init];
    
    [self.motionManager queryActivityStartingFromDate:now toDate:now toQueue:[NSOperationQueue mainQueue] withHandler:^(NSArray<CMMotionActivity *> * _Nullable activities, NSError * _Nullable error) {
        if (error) {
            if (error.code == CMErrorMotionActivityNotAuthorized) {
                status = ADPermissionStatusDenied;
            }
        } else {
            status = ADPermissionStatusAuthorized;
        }
        
        [self.motionManager stopActivityUpdates];
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return status;
}

- (BOOL)isAuthorized {
    return ADPermissionStatusAuthorized == self.status;
}

- (BOOL)isDenied {
    return ADPermissionStatusDenied == self.status;
}

#endif

@end
