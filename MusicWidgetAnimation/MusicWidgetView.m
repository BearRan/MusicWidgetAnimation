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
    PanDirection            panDir;
}

@property (assign, nonatomic) int   cardIndex;

@end

@implementation MusicWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self createUI];
        
        self.cardIndex = 0;
        panDir = kPanDir_Null;
    }
    
    return self;
}

- (void)createUI
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture_Event:)];
    _cardArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < cardShowInView_Count + 2; i++) {
        
        CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, WIDTH * 0.8, HEIGHT * 0.7)];
        cardView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        cardView.mainLabel.text = [NSString stringWithFormat:@"%d", i];
        [_cardArray addObject:cardView];
        [self addSubview:cardView];
        
        if (i == 1) {
            cardView.backgroundColor = [UIColor redColor];
        }
    }
    
    [self updateCardsViewWithAnimation:NO];
}

- (void)updateCardsViewWithAnimation:(BOOL)animation
{
    if (animation) {
        [UIView animateWithDuration:animationDuration animations:^{
            [self updateCardsDetail];
        }];
    }else{
        [self updateCardsDetail];
    }
}

- (void)updateCardsDetail
{
    CGFloat gap_y               = 25;
    CGFloat delta_ScaleRatio    = 0.08;
    CGFloat delta_AlphaGap      = 0.25;
    
    int cardAll_count = (int)[_cardArray count];
    int cardWillDisappear_index = _cardIndex - 1;
    int cardWillAppear_index = _cardIndex + cardShowInView_Count;
    
    if (_cardIndex == 0) {
        cardWillDisappear_index = cardAll_count - 1;
    }
    
    if (cardWillAppear_index >= cardAll_count) {
        cardWillAppear_index -= cardAll_count;
    }
    
    
    //  即将消失的cardView
    CardView *cardView_willDisappear = _cardArray[cardWillDisappear_index];
    cardView_willDisappear.hidden = YES;
    if (panDir == kPanDir_Left){
        [cardView_willDisappear setMaxX:0];
    }
    else if (panDir == kPanDir_Right) {
        [cardView_willDisappear setX:self.width];
    }
    
    
    //  即将显示的cardView
    CardView *cardView_willAppear = _cardArray[cardWillAppear_index];
    cardView_willAppear.hidden = YES;
    
    
    //  可见的中间三个cardView
    for (int j = 0 ; j < cardShowInView_Count; j++) {
        
        int i = j + _cardIndex;
        if (i >= cardAll_count) {
            i -= cardAll_count;
        }
        
        CardView *cardView = _cardArray[i];
        
        cardView.hidden = NO;
        CGFloat alpha_f = 1 - j * delta_AlphaGap;
        cardView.alpha = alpha_f;
        [cardView setCenter:CGPointMake(self.width / 2.0, self.height / 2.0 - gap_y * j)];
        cardView.transform = CGAffineTransformMakeScale(1 - j * delta_ScaleRatio, 1 - j * delta_ScaleRatio);
        
        //  手势移交
        if (j == 0) {
            [_panGesture.view removeGestureRecognizer:_panGesture];
            [cardView addGestureRecognizer:_panGesture];
        }
        
        
        
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
    if (self.cardIndex + 1 > [_cardArray count]) {
        self.cardIndex = 0;
    }else{
        self.cardIndex = self.cardIndex + 1;
    }
}

- (void)disappearToRight:(UIPanGestureRecognizer *)panGesture
{
    if (self.cardIndex + 1 > [_cardArray count]) {
        self.cardIndex = 0;
    }else{
        self.cardIndex = self.cardIndex + 1;
    }
}

- (void)pushNextCard:(UIPanGestureRecognizer *)panGesture
{
    
}


#pragma mark - 重写cardIndex

@synthesize cardIndex = _cardIndex;
- (void)setCardIndex:(int)cardIndex
{
    _cardIndex = cardIndex;
    
    
    [self updateCardsViewWithAnimation:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
