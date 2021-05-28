//
//  ADLocationPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADLocationPermission.h"

@interface ADLocationPermission()<CLLocationManagerDelegate>

@property (nonatomic, assign) ADPermissionType type;

/// 是否请求了定位权限
@property (nonatomic, assign) BOOL requestedLocation;

/// 是否请求了Always定位权限
@property (nonatomic, assign) BOOL requestedLocationAlwaysWithWhenInUse;

/// 是否要触发回调（用户在请求弹框上明确选择了权限）
@property (nonatomic, assign) BOOL triggerCallbacks;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ADLocationPermission

#ifdef ADPERMISSION_LOCATION

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

- (ADPermissionStatus) permissionStatusWithStatus:(CLAuthorizationStatus)status {
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    if (ADPermissionTypeLocationAlways == self.type) {
        switch (status) {
            case kCLAuthorizationStatusAuthorizedAlways:
                statusOfPermission = ADPermissionStatusAuthorized;
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                statusOfPermission = self.requestedLocationAlwaysWithWhenInUse ? ADPermissionStatusDenied : ADPermissionStatusNotDetermined;
                break;
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
                statusOfPermission = ADPermissionStatusAuthorized;
                break;
            case kCLAuthorizationStatusNotDetermined:
                statusOfPermission = ADPermissionStatusNotDetermined;
                break;
                
            default:
                break;
        }
    }
    
    if (ADPermissionTypeLocationWhenInUse == self.type) {
        switch (status) {
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                statusOfPermission = ADPermissionStatusAuthorized;
                break;
            case kCLAuthorizationStatusDenied:
            case kCLAuthorizationStatusRestricted:
                statusOfPermission = ADPermissionStatusAuthorized;
                break;
            case kCLAuthorizationStatusNotDetermined:
                statusOfPermission = ADPermissionStatusNotDetermined;
                break;
                
            default:
                break;
        }
    }
    
    return statusOfPermission;
}

- (void) requestLocationAlways {
    NSString *locationAlwaysUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADLocationAlwaysUsageDescription];
    if (!locationAlwaysUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请位置权限使用权限", ADLocationAlwaysUsageDescription);
#endif
    }
    
    NSString *locationWhenInUseUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADLocationWhenInUseUsageDescription];
    if (!locationWhenInUseUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请位置权限使用权限", ADLocationWhenInUseUsageDescription);
#endif
    }
    
    if (kCLAuthorizationStatusAuthorizedWhenInUse == [CLLocationManager authorizationStatus]) {
        self.requestedLocationAlwaysWithWhenInUse = YES;
    }
    
    [self.locationManager requestAlwaysAuthorization];
}

- (void) requestLocationWhenInUse {
    NSString *locationWhenInUseUsageDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:ADLocationWhenInUseUsageDescription];
    if (!locationWhenInUseUsageDescription) {
#ifdef DEBUG
        NSLog(@"没有设置在Info.plist中设置%@，用以申请位置权限使用权限", ADLocationWhenInUseUsageDescription);
#endif
    }
    
    [self.locationManager requestWhenInUseAuthorization];
    return;
}

#pragma mark - ADPermissionProtocol
- (void) requestWithType:(ADPermissionType)type
                  params:(NSDictionary *)params {
    self.requestedLocation = YES;
    self.type = type;
    if (ADPermissionTypeLocationAlways == self.type) {
        [self requestLocationAlways];
        return;
    }
    
    if (ADPermissionTypeLocationWhenInUse == self.type) {
        [self requestLocationWhenInUse];
        return;
    }
}

- (ADPermissionStatus)status {
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    if (![CLLocationManager locationServicesEnabled]) {
        statusOfPermission = ADPermissionStatusDisabled;
        return statusOfPermission;
    }
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    statusOfPermission = [self permissionStatusWithStatus:status];
    
    return statusOfPermission;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    ADPermissionStatus statusOfPermission = ADPermissionStatusNotDetermined;
    statusOfPermission = [self permissionStatusWithStatus:status];
    if (self.requestedLocation) {
        if (self.triggerCallbacks) {
            self.triggerCallbacks = NO;
            self.requestedLocation = NO;
            self.status = statusOfPermission;
            [self completeWithResult:nil];
            return;
        }
        
        self.triggerCallbacks = YES;
    }
}

#pragma mark - setters getters

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#endif

@end
