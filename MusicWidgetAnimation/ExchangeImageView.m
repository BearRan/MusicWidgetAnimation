//
//  ExchangeImageView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/6/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ExchangeImageView.h"

@interface ExchangeImageView ()

@property (strong, nonatomic) NSString      *nowImageName;
@property (strong, nonatomic) UIImageView   *nowImageView;
@property (strong, nonatomic) UIImageView   *nextImageView;

@end

@implementation ExchangeImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _animationDuration_EX = 4.5;
        
        _nowImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _nowImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_nowImageView];
        _nowImageView.alpha = 1;
        
        _nextImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _nextImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_nextImageView];
        _nextImageView.alpha = 1;
    }
    
    return self;
}

- (void)exchangeToNextImage:(NSString *)imageName animation:(BOOL)animation
{
    _nextImageView.image = [UIImage imageNamed:imageName];
    if (animation) {
        [UIView animateWithDuration:0.1 animations:^{
            
            _nextImageView.layer.opacity = 1;
//            _nextImageView.alpha = 1;
            _nowImageView.layer.opacity = 0;
            
        } completion:^(BOOL finished) {
            
            NSLog(@"--completion");
            _nowImageView.image = [UIImage imageNamed:imageName];
            _nowImageView.layer.opacity = 1;
            _nextImageView.layer.opacity = 0;
        }];
    }
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

@end
