//
//  ADBluetoothPermission.m
//  ADPermission
//
//  Created by ade on 2021/2/7.
//

#import "ADBluetoothPermission.h"

@interface ADBluetoothPermission()<CBPeripheralManagerDelegate>

@property (nonatomic, strong) CBPeripheralManager *bluetoothManager;

@property (nonatomic, assign) BOOL stateBluetoothManagerDetermined;

@property (nonatomic, assign) BOOL requestedBluetooth;

@property (nonatomic, assign) ADPermissionStatus statusBluetooth;

@end

@implementation ADBluetoothPermission

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

- (void)requestWithType:(ADPermissionType)type
                 params:(NSDictionary *)params {
    
    if (CBManagerStatePoweredOn != self.bluetoothManager.state) {
        return;
    }
    
    [self.bluetoothManager startAdvertising:nil];
    [self.bluetoothManager stopAdvertising];
}

- (ADPermissionStatus)status {
    CBPeripheralManagerAuthorizationStatus status = [CBPeripheralManager authorizationStatus];
        
    switch (status) {
        case CBPeripheralManagerAuthorizationStatusRestricted:
            return ADPermissionStatusDisabled;
            break;
        case CBPeripheralManagerAuthorizationStatusDenied:
            return ADPermissionStatusDenied;
            break;
        case CBPeripheralManagerAuthorizationStatusAuthorized:
        case CBPeripheralManagerAuthorizationStatusNotDetermined:
            
            break;
        default:
            return ADPermissionStatusNotDetermined;
            break;
    }
    
    if (!self.stateBluetoothManagerDetermined) {
        return ADPermissionStatusNotDetermined;
    }
    
    switch (self.bluetoothManager.state) {
        case CBManagerStateUnsupported:
        case CBManagerStatePoweredOff:
            return ADPermissionStatusDisabled;
            break;
        case CBManagerStateUnauthorized:
            return ADPermissionStatusDenied;
            break;
        case CBManagerStatePoweredOn:
            return ADPermissionStatusAuthorized;
            break;
        case CBManagerStateUnknown:
        case CBManagerStateResetting:
            return self.statusBluetooth ? self.statusBluetooth : ADPermissionStatusNotDetermined;
            break;
            
        default:
            return ADPermissionStatusNotDetermined;
            break;
    }
}

#pragma mark - CBPeripheralManagerDelegate

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    self.stateBluetoothManagerDetermined = YES;
    self.statusBluetooth = self.status;
    if (!self.requestedBluetooth) {
        return;
    }
    
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    [results setValue:peripheral forKey:@"peripheral"];
    [self completeWithResult:results];
    
    self.requestedBluetooth = NO;
}

#pragma mark - setters getters

- (CBPeripheralManager *)bluetoothManager {
    if (!_bluetoothManager) {
        _bluetoothManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:@{CBPeripheralManagerOptionShowPowerAlertKey:@(NO)}];
    }
    return _bluetoothManager;
}

@end
