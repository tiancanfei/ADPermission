//
//  ViewController.m
//  ADPermission
//
//  Created by ade on 2021/2/8.
//

#import "ViewController.h"
#import "ADPermission.h"

@interface ViewController ()

@property (nonatomic, strong) ADPermission *permission;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self objectTest];
}

#pragma mark 类方法测试
/// 类方法测试
- (void) objectTest {
    [self.permission.locationPermission requestWithType:ADPermissionTypeLocationAlways params:nil];
    NSLog(@"%zd", self.permission.locationPermission.status);
}

#pragma mark 对象方法测试
/// 对象方法测试
- (void) classTest {
    ADPermission *locationPermission = [ADPermission requestWithType:ADPermissionTypeLocationAlways params:nil];
    locationPermission.locationPermission.complete = ^(ADPermissionStatus status, NSDictionary * _Nullable results) {
        NSLog(@"%@, %zd", results, status);
    };
    NSLog(@"%zd", locationPermission.locationPermission.status);
}

#pragma mark - setters getters

- (ADPermission *)permission {
    if (!_permission) {
        _permission = [[ADPermission alloc] init];
        _permission.locationPermission.complete = ^(ADPermissionStatus status, NSDictionary * _Nullable results) {
            NSLog(@"======");
        };
    }
    return _permission;
}


@end
