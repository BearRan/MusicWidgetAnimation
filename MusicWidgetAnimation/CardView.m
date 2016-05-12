//
//  CardView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CardView.h"
#import "CardViewBack.h"

@interface CardView ()

@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.cornerRadius = 5;
       
        //  _backBgView
        _backBgView = [[UIView alloc] initWithFrame:self.bounds];
        _backBgView.backgroundColor = [UIColor greenColor];
        [self addSubview:_backBgView];
        
        [self initSetBackView];
        
        
        //  _frontBgView
        _frontBgView = [[UIView alloc] initWithFrame:self.bounds];
        _frontBgView.backgroundColor = [UIColor brownColor];
        [self addSubview:_frontBgView];
        
        
        //  components
        _headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _headImgV.layer.cornerRadius = _headImgV.height / 2.0;
        _headImgV.backgroundColor = [UIColor blueColor];
        [_frontBgView addSubview:_headImgV];
        
        _mainLabel = [[UILabel alloc] init];
        [_frontBgView addSubview:_mainLabel];
        
        _assignLabel_1 = [[UILabel alloc] init];
        [_frontBgView addSubview:_assignLabel_1];
        
        _assignLabel_2 = [[UILabel alloc] init];
        [_frontBgView addSubview:_assignLabel_2];
        
        
        //  缩放动画
        _scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        _scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
        _scaleAnimation.fillMode = kCAFillModeForwards;
        _scaleAnimation.removedOnCompletion = NO;
        _scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        //  旋转动画
        _rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
        _rotationAnimation.toValue = [NSNumber numberWithFloat:0];
        _rotationAnimation.fillMode = kCAFillModeForwards;
        _rotationAnimation.removedOnCompletion = NO;
        _rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        //  翻转动画
        _flipAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        _flipAnimation.fromValue = [NSNumber numberWithFloat:0];
        _flipAnimation.toValue = [NSNumber numberWithFloat:M_PI];
        _flipAnimation.fillMode = kCAFillModeForwards;
        _flipAnimation.removedOnCompletion = NO;
        _flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    
    return self;
}

- (void)initSetBackView
{
    _cardViewBack = [[CardViewBack alloc] initWithFrame:self.frame];
    [_backBgView addSubview:_cardViewBack];
    
    CALayer *layer = _cardViewBack.layer;
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, 0.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _headImgV.image = [UIImage imageNamed:@""];
//    _mainLabel.text = @"ABC";
    _assignLabel_1.text = @"EFG";
    _assignLabel_2.text = @"HIJ";
    
    [_headImgV BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:50 center:YES];
    
    [_mainLabel sizeToFit];
    [_mainLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_headImgV parentRelation:NO distance:30 center:YES];
    
    [_assignLabel_1 sizeToFit];
    [_assignLabel_1 BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_mainLabel parentRelation:NO distance:20 center:YES];
    
    [_assignLabel_2 sizeToFit];
    [_assignLabel_2 BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_assignLabel_1 parentRelation:NO distance:20 center:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
