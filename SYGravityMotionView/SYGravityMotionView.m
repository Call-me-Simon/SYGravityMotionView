//
//  SYGravityMotionView.m
//  SYGravityMotionView
//
//  Created by Simon on 2018/6/29.
//  Copyright © 2018年 JSINFO. All rights reserved.
//

#import "SYGravityMotionView.h"
#import "SYGravityMotionTools.h"
#import <UIImageView+WebCache.h>

@interface SYGravityMotionView ()

@property (nonatomic, assign) UIDynamicItemCollisionBoundsType collisionBoundsType;

@end

@implementation SYGravityMotionView

@synthesize collisionBoundsType;

- (instancetype)initWithFrame:(CGRect)frame ImageUrl:(NSString *)image
{
    if (self = [super initWithFrame:frame]) {
        
        if ([image hasPrefix:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:image]];
        }else {
            self.image = [UIImage imageNamed:image];
        }
        self.layer.cornerRadius = frame.size.width * 0.5;
        self.layer.masksToBounds = YES;
        self.collisionBoundsType = UIDynamicItemCollisionBoundsTypeEllipse;
    }
    
    return self;
}

- (void)starMotion
{
    SYGravityMotionTools * motionTool = [SYGravityMotionTools shareMotionTool];
    
    [motionTool addAnimationView:self referenceView:self.superview];
}

@end
