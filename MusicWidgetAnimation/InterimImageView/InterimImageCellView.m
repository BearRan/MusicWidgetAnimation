//
//  InterimImageCellView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/10/2.
//  Copyright © 2016年 Bear. All rights reserved.
//

static NSString *__kAnimationKeyOpacityShow     = @"__kAnimationKeyOpacityShow";
static NSString *__kAnimationKeyOpacityHide     = @"__kAnimationKeyOpacityHide";

#import "InterimImageCellView.h"

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

- (void)opacityAnimationShowWithImage:(UIImage *)image animation:(BOOL)aniamtion
{
    if (image) {
        self.image = image;
    }
    
    [self opacityAnimationShow:aniamtion];
}

- (void)opacityAnimationHideWithImage:(UIImage *)image animation:(BOOL)aniamtion
{
    if (image) {
        self.image = image;
    }
    
    [self opacityAnimationHide:aniamtion];
}


- (void)opacityAnimationShow:(BOOL)aniamtion
{
    [self.layer removeAnimationForKey:__kAnimationKeyOpacityShow];
    
    if (aniamtion) {
        _opacityShowAnimation.fromValue     = [NSNumber numberWithFloat:0];
        _opacityShowAnimation.toValue       = [NSNumber numberWithFloat:1];
        _opacityShowAnimation.duration      = _animationDuration_EX;
        [self.layer addAnimation:_opacityShowAnimation forKey:__kAnimationKeyOpacityShow];
    }
}

- (void)opacityAnimationHide:(BOOL)aniamtion
{
    [self.layer removeAnimationForKey:__kAnimationKeyOpacityHide];
    
    if (aniamtion) {
        _opacityHideAnimation.fromValue     = [NSNumber numberWithFloat:1];
        _opacityHideAnimation.toValue       = [NSNumber numberWithFloat:0];
        _opacityHideAnimation.duration      = _animationDuration_EX;
        [self.layer addAnimation:_opacityHideAnimation forKey:__kAnimationKeyOpacityHide];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.layer animationForKey:__kAnimationKeyOpacityHide] == anim) {
        
        if (self.opacityHideFinish_Block) {
            self.opacityHideFinish_Block();
        }
        
    }else if ([self.layer animationForKey:__kAnimationKeyOpacityShow] == anim){
    
        if (self.opacityShowFinish_Block) {
            self.opacityShowFinish_Block();
        }
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
