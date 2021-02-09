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
//    NSLog(@"%zd", self.permission.locationPermission.status);
    [self.permission.locationPermission requestWithType:ADPermissionTypeLocationAlways params:nil];
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
