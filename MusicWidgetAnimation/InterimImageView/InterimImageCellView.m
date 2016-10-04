//
//  InterimImageCellView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/10/2.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "InterimImageCellView.h"

static NSString *__kAnimationKeyOpacityShow     = @"__kAnimationKeyOpacityShow";
static NSString *__kAnimationKeyOpacityHide     = @"__kAnimationKeyOpacityHide";

@interface InterimImageCellView () <CAAnimationDelegate>

@property (strong, nonatomic) CABasicAnimation  *opacityShowAnimation;
@property (strong, nonatomic) CABasicAnimation  *opacityHideAnimation;

@end

@implementation InterimImageCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        
        _animationDuration_EX   = 0.3;
        self.animationFinished  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        _opacityShowAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityShowAnimation.fillMode = kCAFillModeForwards;
        _opacityShowAnimation.removedOnCompletion = NO;
        _opacityShowAnimation.delegate = weakSelf;
        
        _opacityHideAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityHideAnimation.fillMode = kCAFillModeForwards;
        _opacityHideAnimation.removedOnCompletion = NO;
        _opacityHideAnimation.delegate = weakSelf;
        
    }
    
    return self;
}

- (void)opacityAnimationShowWithImage:(UIImage *)image
{
    if (image) {
        self.image = image;
    }
    
    [self opacityAnimationShow];
}

- (void)opacityAnimationHideWithImage:(UIImage *)image
{
    if (image) {
        self.image = image;
    }
    
    [self opacityAnimationHide];
}


- (void)opacityAnimationShow
{
    [self.layer removeAnimationForKey:__kAnimationKeyOpacityShow];
    
    _opacityShowAnimation.fromValue     = [NSNumber numberWithFloat:0];
    _opacityShowAnimation.toValue       = [NSNumber numberWithFloat:1];
    _opacityShowAnimation.duration      = _animationDuration_EX;
    [self.layer addAnimation:_opacityShowAnimation forKey:__kAnimationKeyOpacityShow];
}

- (void)opacityAnimationHide
{
    [self.layer removeAnimationForKey:__kAnimationKeyOpacityHide];
    
    _opacityHideAnimation.fromValue     = [NSNumber numberWithFloat:1];
    _opacityHideAnimation.toValue       = [NSNumber numberWithFloat:0];
    _opacityHideAnimation.duration      = _animationDuration_EX;
    [self.layer addAnimation:_opacityHideAnimation forKey:__kAnimationKeyOpacityHide];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.layer animationForKey:__kAnimationKeyOpacityHide] == anim) {
        
        [self removeFromSuperview];
        
    }else if ([self.layer animationForKey:__kAnimationKeyOpacityShow] == anim){
    
        nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
