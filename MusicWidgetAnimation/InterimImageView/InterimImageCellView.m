//
//  InterimImageCellView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/10/2.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "InterimImageCellView.h"

@interface InterimImageCellView () <CAAnimationDelegate>

@property (strong, nonatomic) CABasicAnimation  *opacityAnimation;

@end

@implementation InterimImageCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        
        self.animationFinished = YES;
        
        _opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnimation.fillMode = kCAFillModeForwards;
        _opacityAnimation.removedOnCompletion = NO;
        _opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
        _opacityAnimation.toValue = [NSNumber numberWithFloat:1];
        _opacityAnimation.delegate = weakSelf;
        
    }
    
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
