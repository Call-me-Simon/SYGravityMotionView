//
//  ViewController.m
//  SYGravityMotionView
//
//  Created by Simon on 2018/6/29.
//  Copyright © 2018年 JSINFO. All rights reserved.
//

#import "ViewController.h"
#import "SYGravityMotionView.h"
#import "SYGravityMotionTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSArray *array = @[@"大师球",@"高级球",@"超级球",@"精灵球"];
    SYGravityMotionView * motionView = [[SYGravityMotionView alloc] initWithFrame:CGRectMake(0, 80, 50, 50) ImageUrl:array[arc4random_uniform(4)]];
    [self.view addSubview:motionView];
    [motionView starMotion];}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [[SYGravityMotionTools shareMotionTool] stopMotionUpdates];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
