//
//  InterimImageView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/6/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "InterimImageView.h"
#import "InterimImageCellView.h"

static NSString *__kAnimationKeyNow     = @"__kAnimationKeyNow";
static NSString *__kAnimationKeyNext    = @"__kAnimationKeyNext";

@interface InterimImageView () <UIApplicationDelegate, CAAnimationDelegate>

@property (strong, nonatomic) CABasicAnimation  *nowImage_OpacityAnimation;
@property (strong, nonatomic) CABasicAnimation  *nextImage_OpacityAnimation;
@property (strong, nonatomic) NSString          *nowImageName;
@property (strong, nonatomic) UIImageView       *nowImageView;
@property (strong, nonatomic) UIImageView       *nextImageView;
@property (strong, nonatomic) NSMutableArray    *imageViewsArray;

@end

@implementation InterimImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        __weak typeof(self) weakSelf = self;
        _animationDuration_EX = 0.3;
        
        _imageViewsArray = [NSMutableArray new];
        
        _nowImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _nowImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_nowImageView];
        _nowImageView.alpha = 1;
        
        _nextImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _nextImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_nextImageView];
        _nextImageView.alpha = 1;
        
        _nowImage_OpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _nowImage_OpacityAnimation.fillMode = kCAFillModeForwards;
        _nowImage_OpacityAnimation.removedOnCompletion = NO;
        _nowImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:0];
        _nowImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:1];
        _nowImage_OpacityAnimation.delegate = weakSelf;
        
        _nextImage_OpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _nextImage_OpacityAnimation.fillMode = kCAFillModeForwards;
        _nextImage_OpacityAnimation.removedOnCompletion = NO;
        _nextImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:0];
        _nextImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:0];
        _nextImage_OpacityAnimation.delegate = weakSelf;
        
        
        //  虚化背景
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.alpha = 0.8;
        visualEffectView.frame = self.frame;
        visualEffectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        [self addSubview:visualEffectView];

    }
    
    return self;
}

- (void)exchangeToNextImage:(NSString *)imageName animation:(BOOL)animation
{
    _nextImageView.image = [UIImage imageNamed:imageName];
    
    _nowImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    _nowImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:0];
    _nowImage_OpacityAnimation.duration = _animationDuration_EX;
    [_nowImageView.layer addAnimation:_nowImage_OpacityAnimation forKey:__kAnimationKeyNow];
    
    _nextImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    _nextImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:1];
    _nextImage_OpacityAnimation.duration = _animationDuration_EX;
    [_nextImageView.layer addAnimation:_nextImage_OpacityAnimation forKey:__kAnimationKeyNext];
}

@synthesize nextImageName = _nextImageName;
- (void)setNextImageName:(NSString *)nextImageName
{
    _nextImageName = nextImageName;
    
    //  第一次加载，无动效
    if ([_nowImageName length] == 0) {
        
        _nowImageName = _nextImageName;
        _nowImageView.image = [UIImage imageNamed:_nowImageName];
        _nowImageView.alpha = 1;
    }else{
        
        [self exchangeToNextImage:_nextImageName animation:YES];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _nowImageView.image = [UIImage imageNamed:_nextImageName];
//    [_nowImageView.layer removeAnimationForKey:_nowImage_OpacityAnimation.keyPath];
//
//    [_nextImageView.layer removeAnimationForKey:_nextImage_OpacityAnimation.keyPath];
    
    if ([_nowImageView.layer animationForKey:__kAnimationKeyNow] == anim) {
        NSLog(@"now");
    }
    else if ([_nextImageView.layer animationForKey:__kAnimationKeyNext] == anim){
        NSLog(@"next");
    }
    
}

@end
