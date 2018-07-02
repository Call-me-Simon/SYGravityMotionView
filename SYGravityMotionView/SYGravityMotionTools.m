//
//  SYGravityMotionTools.m
//  SYGravityMotionView
//
//  Created by Simon on 2018/6/29.
//  Copyright © 2018年 JSINFO. All rights reserved.
//

#import "SYGravityMotionTools.h"
#import <CoreMotion/CoreMotion.h>

@interface SYGravityMotionTools ()

@property (nonatomic, strong) UIDynamicAnimator * animator;
@property (nonatomic, strong) CMMotionManager * manager;
@property (nonatomic, strong) UIGravityBehavior * gravity;
@property (nonatomic, strong) UICollisionBehavior * collision;
@property (nonatomic, strong) UIDynamicItemBehavior * dynamic;

@end

@implementation SYGravityMotionTools

+ (instancetype)shareMotionTool
{
    static SYGravityMotionTools *motionTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        motionTool = [SYGravityMotionTools new];
    });
    return motionTool;
}

- (void)addAnimationView:(UIView *)aniView referenceView:(UIView *)referenceView;
{
    _referenceView = referenceView;
    
    [self.dynamic addItem:aniView];
    [self.collision addItem:aniView];
    [self.gravity addItem:aniView];
    
    [self startMotion];
}

#pragma mark --- 开始
-(void)startMotion
{
    if (!self.manager.isDeviceMotionAvailable) {
        NSLog(@"手机不支持");
        return;
    }
    
    self.manager.deviceMotionUpdateInterval = 0.01;
    
    __weak typeof(self) weakSelf = self;
    
    [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"出错了 %@",error);
            return;
        }
        weakSelf.gravity.gravityDirection = CGVectorMake(motion.gravity.x * 3, -motion.gravity.y * 3);
    }];
    
}

#pragma mark --- 停止运动
- (void)stopMotionUpdates
{
    if (self.manager.isDeviceMotionActive) {
        [self.manager stopDeviceMotionUpdates];
        [self.animator removeAllBehaviors];
    }
}

#pragma mark --- layzinit

#pragma mark --- 运动管理者
- (CMMotionManager *)manager
{
    if (!_manager) {
        _manager = [[CMMotionManager alloc] init];
    }
    return _manager;
}

#pragma mark --- 动态媒介
-(UIDynamicAnimator *)animator
{
    if (!_animator) {// 设置参考边界
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.referenceView];;
    }
    
    return _animator;
}

#pragma mark --- 重力
-(UIGravityBehavior *)gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

#pragma mark --- 碰撞
-  (UICollisionBehavior *)collision
{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
        _collision.collisionMode = UICollisionBehaviorModeEverything;
        [self.animator addBehavior:_collision];
    }
    
    return _collision;
}

#pragma mark --- 动力学属性
-  (UIDynamicItemBehavior *)dynamic
{
    if (!_dynamic) {
        _dynamic = [[UIDynamicItemBehavior alloc] init];
        _dynamic.friction = 0.2;
        _dynamic.elasticity = 0.8;
        _dynamic.density = 0.2;
        _dynamic.allowsRotation = YES;
        _dynamic.resistance = 0;
        [self.animator addBehavior:_dynamic];
    }
    
    return _dynamic;
}
@end
