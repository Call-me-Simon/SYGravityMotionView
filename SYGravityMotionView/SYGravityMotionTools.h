//
//  SYGravityMotionTools.h
//  SYGravityMotionView
//
//  Created by Simon on 2018/6/29.
//  Copyright © 2018年 JSINFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SYGravityMotionTools : NSObject

@property (nonatomic, weak) UIView * referenceView;

+ (instancetype)shareMotionTool;

- (void)addAnimationView:(UIView *)aniView referenceView:(UIView *)referenceView;

- (void)stopMotionUpdates;

@end
