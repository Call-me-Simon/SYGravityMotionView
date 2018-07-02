//
//  SYGravityMotionView.h
//  SYGravityMotionView
//
//  Created by Simon on 2018/6/29.
//  Copyright © 2018年 JSINFO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYGravityMotionView : UIImageView


/**
 初始化小球

 @param frame 小球frame
 @param image 可传图片url也可直接传图片
 */
- (instancetype)initWithFrame:(CGRect)frame ImageUrl:(NSString *)image;

- (void)starMotion;

@end
