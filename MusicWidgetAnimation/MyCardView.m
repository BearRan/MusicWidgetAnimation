//
//  MyCardView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/31.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "MyCardView.h"
#import "CardViewBack.h"


@implementation MyCardView
{
    UITapGestureRecognizer  *_tapGesture;
    CGFloat                 cardView_width;
    CGFloat                 cardView_height;
}

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        cardView_width = self.width;
        cardView_height = self.height;
        
        _animationDuration_Flip     = 2;
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture_Event:)];
        _tapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_tapGesture];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    self.cardStatus = kCardStatus_Front;
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    
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
}

#pragma mark - Gesture

- (void)tapGesture_Event:(UITapGestureRecognizer *)tapGesture
{
    MyCardView *cardView = (MyCardView *)tapGesture.view;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:_animationDuration_Flip];
    
    NSUInteger index_back = [cardView.subviews indexOfObject:cardView.backBgView];
    NSUInteger index_front = [cardView.subviews indexOfObject:cardView.frontBgView];
    
    
    //  翻转后，back模式
    if (index_back < index_front) {
        
        cardView.cardStatus = kCardStatus_Back;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cardView cache:YES];
        
        [self setBigSize:cardView];
        [self setBigSize:cardView.frontBgView];
        [self setBigSize:cardView.backBgView];
        [self setBigSize:(UIView *)cardView.cardViewBack];
    }
    //  翻转后，front模式
    else{
        
        cardView.cardStatus = kCardStatus_Front;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardView cache:YES];
        
        [self setSmallSize:cardView];
        [self setSmallSize:cardView.frontBgView];
        [self setSmallSize:cardView.backBgView];
        [self setSmallSize:(UIView *)cardView.cardViewBack];
    }
    
    [cardView exchangeSubviewAtIndex:index_back withSubviewAtIndex:index_front];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(flipAnimationWillStart_Event)];
    [UIView setAnimationDidStopSelector:@selector(flipAnimationDidStop_Event)];
    [UIView commitAnimations];
}

- (void)flipAnimationWillStart_Event
{
    //    [_cardView_Now removeGestureRecognizer:_panGesture];
}

- (void)flipAnimationDidStop_Event
{
    //    [_cardView_Now addGestureRecognizer:_panGesture];
}

- (void)setBigSize:(UIView *)view
{
    //    view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [view setWidth_DonotMoveCenter:WIDTH];
    [view setHeight_DonotMoveCenter:HEIGHT];
}

- (void)setSmallSize:(UIView *)view
{
    [view setWidth_DonotMoveCenter:cardView_width];
    [view setHeight_DonotMoveCenter:cardView_height];
}

- (void)initSetBackView
{
    _cardViewBack = [[CardViewBack alloc] initWithFrame:self.frame];
    [_backBgView addSubview:_cardViewBack];
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

@end
