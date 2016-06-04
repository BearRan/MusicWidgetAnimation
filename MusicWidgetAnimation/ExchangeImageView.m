//
//  ExchangeImageView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/6/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ExchangeImageView.h"

@interface ExchangeImageView () <UIApplicationDelegate>
{
    CABasicAnimation *_nowImage_OpacityAnimation;
    CABasicAnimation *_nextImage_OpacityAnimation;
}

@property (strong, nonatomic) NSString      *nowImageName;
@property (strong, nonatomic) UIImageView   *nowImageView;
@property (strong, nonatomic) UIImageView   *nextImageView;

@end

@implementation ExchangeImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _animationDuration_EX = 0.8;
        
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
        _nowImage_OpacityAnimation.delegate = self;
        
        _nextImage_OpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _nextImage_OpacityAnimation.fillMode = kCAFillModeForwards;
        _nextImage_OpacityAnimation.removedOnCompletion = NO;
        _nextImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:0];
        _nextImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:0];
    }
    
    return self;
}

- (void)exchangeToNextImage:(NSString *)imageName animation:(BOOL)animation
{
    _nextImageView.image = [UIImage imageNamed:imageName];
    
    _nowImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:1];
    _nowImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:0];
    _nowImage_OpacityAnimation.duration = _animationDuration_EX;
    [_nowImageView.layer addAnimation:_nowImage_OpacityAnimation forKey:_nowImage_OpacityAnimation.keyPath];
    
    _nextImage_OpacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    _nextImage_OpacityAnimation.toValue = [NSNumber numberWithFloat:1];
    _nextImage_OpacityAnimation.duration = _animationDuration_EX;
    [_nextImageView.layer addAnimation:_nextImage_OpacityAnimation forKey:_nextImage_OpacityAnimation.keyPath];
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
    [_nowImageView.layer removeAnimationForKey:_nowImage_OpacityAnimation.keyPath];

    [_nextImageView.layer removeAnimationForKey:_nextImage_OpacityAnimation.keyPath];
    
    
    
//    if ([anim isKindOfClass:[CABasicAnimation class]]) {
//        
//        CABasicAnimation *tempCABasicAnimation = (CABasicAnimation *)anim;
//        
//        if ([tempCABasicAnimation.keyPath isEqualToString:_nowImage_OpacityAnimation.keyPath]) {
//            NSLog(@"AAA--1");
//        }
//        else if ([tempCABasicAnimation.keyPath isEqualToString:_nextImage_OpacityAnimation.keyPath]){
//            NSLog(@"AAA--2");
//        }
//        
//        tempCABasicAnimation.
//    }
    
    
}

@end
