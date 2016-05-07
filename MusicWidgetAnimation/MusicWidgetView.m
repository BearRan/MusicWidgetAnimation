//
//  MusicWidgetView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "MusicWidgetView.h"
#import "CardView.h"

static int      cardShowInView_Count    = 3;
static CGFloat  animationDuration       = 0.2;


@interface MusicWidgetView ()
{
    UIPanGestureRecognizer  *_panGesture;
    NSMutableArray          *_cardArray;
}

@property (assign, nonatomic) int   cardIndex;

@end

@implementation MusicWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createUI];
        
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture_Event:)];
        
        self.cardIndex = 0;
    }
    
    return self;
}

- (void)createUI
{
    CGFloat gap_y               = 25;
    CGFloat delta_ScaleRatio    = 0.08;
    CGFloat delta_AlphaGap      = 0.25;
    
    _cardArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < cardShowInView_Count + 1; i++) {
        
        CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, WIDTH * 0.8, HEIGHT * 0.7)];
        cardView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        [_cardArray addObject:cardView];
        
        cardView.alpha = 1 - i * delta_AlphaGap;
        [cardView setCenter:CGPointMake(self.width / 2.0, self.height / 2.0 - gap_y * i)];
        cardView.transform = CGAffineTransformMakeScale(1 - i * delta_ScaleRatio, 1 - i * delta_ScaleRatio);
        
        if (i > 0) {
            [self insertSubview:cardView belowSubview:_cardArray[i - 1]];
        }else{
            [self addSubview:cardView];
        }
    }
}


#pragma mark - TapGesture
- (void)panGesture_Event:(UIPanGestureRecognizer *)panGesture
{
    static CGFloat      lastPositionX = 0;
    static UIView       *lastView;
    static PanDirection panDir = kPanDir_Null;
    
    CGFloat leftThreshold_x     = self.width * (1.0 / 4);
    CGFloat rightThreshold_x    = self.width * (3.0 / 4);
    CGPoint position = [panGesture locationInView:self];

    
    //  没有历史数据，每次切换页面时，只赋值，然后return
    if (!lastView || ![lastView isEqual:panGesture.view]) {
        lastView = panGesture.view;
        lastPositionX = position.x;
        return;
    }
    
    
    //  和历史坐标比较，判断左滑
    if (lastPositionX > position.x) {
        panDir = kPanDir_Left;
    }
    //  和历史坐标比较，判断右滑
    else if (lastPositionX < position.x){
        panDir = kPanDir_Right;
    }
    
    
    //  绝对左滑
    if (position.x < leftThreshold_x) {
        panDir = kPanDir_Left;
    }
    //  绝对右滑
    else if (position.x > rightThreshold_x){
        panDir = kPanDir_Right;
    }
    
    
    //  判断手势
    switch (panGesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            [panGesture.view setX:panGesture.view.x + (position.x - lastPositionX)];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            
            
            
            switch (panDir) {
                case kPanDir_Left:
                {
                    [self disappearToLeft:panGesture];
                }
                    break;
                    
                case kPanDir_Right:
                {
                    [self disappearToRight:panGesture];
                }
                    break;
                    
                case kPanDir_Null:
                {
                    nil;
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
    lastPositionX = position.x;
}

- (void)disappearToLeft:(UIPanGestureRecognizer *)panGesture
{
    [UIView animateWithDuration:animationDuration animations:^{
        [panGesture.view setMaxX:0];
    }];
}

- (void)disappearToRight:(UIPanGestureRecognizer *)panGesture
{
    [UIView animateWithDuration:animationDuration animations:^{
        [panGesture.view setX:self.width];
    }];
}


@synthesize cardIndex = _cardIndex;
- (void)setCardIndex:(int)cardIndex
{
    _cardIndex = cardIndex;
    
    [_panGesture.view removeGestureRecognizer:_panGesture];
    [_cardArray[_cardIndex] addGestureRecognizer:_panGesture];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
