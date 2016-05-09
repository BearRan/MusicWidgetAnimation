//
//  MusicWidgetView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "MusicWidgetView.h"
#import "CardView.h"

static int      cardShowInView_Count    = 4;
static CGFloat  animationDuration       = 0.2;


@interface MusicWidgetView ()
{
    UIPanGestureRecognizer  *_panGesture;
    NSMutableArray          *_cardArray;
    PanDirection            panDir;
    CGFloat                 cardView_width;
    CGFloat                 cardView_height;
}

@property (assign, nonatomic) int   cardIndex;

@end

@implementation MusicWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        cardView_width = WIDTH * 0.8;
        cardView_height = HEIGHT * 0.7;
        
        [self createUI];
        
        self.cardIndex = 0;
        panDir = kPanDir_Null;
        
#warning DAD
//        [self test];
    }
    
    return self;
}

#warning DAD
- (void)test
{
    UIView *viewC = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    viewC.backgroundColor = [UIColor greenColor];
    [self addSubview:viewC];
    [viewC BearSetCenterToParentViewWithAxis:kAXIS_X_Y];
    
//    [self testRotation:viewC];
}

- (void)createUI
{
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture_Event:)];
    _cardArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < cardShowInView_Count + 2; i++) {
        
        CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, cardView_width, cardView_height)];
        cardView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        cardView.mainLabel.text = [NSString stringWithFormat:@"%d", i];
        [_cardArray addObject:cardView];
        [self addSubview:cardView];
        
        if (i == 1) {
            cardView.backgroundColor = [UIColor redColor];
        }
        
        if (i > 0) {
            [self insertSubview:cardView belowSubview:_cardArray[i - 1]];
        }else{
            [self addSubview:cardView];
        }
    }
    
    [self updateCardsWithAnimation:NO];
}

- (void)updateCardsWithAnimation:(BOOL)animation
{
    if (animation) {
        
        [UIView animateWithDuration:animationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self updateCardsDetail];
        } completion:^(BOOL finished) {
            
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
    cardView_willAppear.alpha = 1 - cardShowInView_Count * delta_AlphaGap;
    [cardView_willAppear setCenter:CGPointMake(self.width / 2.0, self.height / 2.0 - gap_y * cardShowInView_Count)];
    cardView_willAppear.hidden = YES;
    
    //  缩放动画
    cardView_willAppear.scaleAnimation.fromValue = cardView_willAppear.scaleAnimation.toValue;
    cardView_willAppear.scaleAnimation.toValue = [NSNumber numberWithFloat:1 - cardShowInView_Count * delta_ScaleRatio];
    cardView_willAppear.scaleAnimation.duration = animationDuration;
    [cardView_willAppear.layer addAnimation:cardView_willAppear.scaleAnimation forKey:cardView_willAppear.scaleAnimation.keyPath];
    
    
    //  中间可见的cardView
    for (int j = 0 ; j < cardShowInView_Count; j++) {
        
        int i = j + _cardIndex;
        if (i >= cardAll_count) {
            i -= cardAll_count;
        }
        
        CardView *cardView = _cardArray[i];
        cardView.hidden = NO;
        cardView.alpha = 1 - j * delta_AlphaGap;
        [cardView setCenter:CGPointMake(self.width / 2.0, self.height / 2.0 - gap_y * j)];

        //  缩放动画
        cardView.scaleAnimation.fromValue = cardView.scaleAnimation.toValue;
        cardView.scaleAnimation.toValue = [NSNumber numberWithFloat:1 - j * delta_ScaleRatio];
        cardView.scaleAnimation.duration = animationDuration;
        [cardView.layer addAnimation:cardView.scaleAnimation forKey:cardView.scaleAnimation.keyPath];
        
        //  手势移交
        if (j == 0) {
            [_panGesture.view removeGestureRecognizer:_panGesture];
            [cardView addGestureRecognizer:_panGesture];
        }
        
        //  即将显示的view插入在最后一个可见cardView的下方
        if (j == cardShowInView_Count - 1) {
             [self insertSubview:cardView_willAppear belowSubview:cardView];
        }
        
        
//        //  测试旋转
//        CGAffineTransform transform = CGAffineTransformMakeRotation(45.0 / 180 * M_PI);
//        [cardView setTransform:transform];

    }
    
}

#warning DAD
- (void)testRotation:(UIView *)view
{
    __block CGFloat i = 0;
    CGFloat duration = 0.01;   //间隔时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, duration * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        
        i += 0.1;
        if (i > 180) {
            dispatch_source_cancel(timer);  //执行5次后停止
            NSLog(@"-- end");
        }else{
            NSLog(@"-- Method_C i:%f", i);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                CGAffineTransform transform = CGAffineTransformMakeRotation(1.0 * i / 180 * M_PI);
                [view setTransform:transform];
            });
            
        }
    });
    dispatch_resume(timer);
}

#pragma mark - TapGesture
/**
 *
 *  lastPositionX:              上一次的X值
 *  lastView:                   上一次处理的view
 *
 *  leftThreshold_x:            手势阈值 绝对向左手势
 *  rightThreshold_x:           手势阈值 绝对向右手势
 *  position:                   手势在self中的坐标
 *  rotationThreshold_degree:   旋转阈值，旋转角度超出该阈值后不再旋转，开始平移操作
 *  gestureView:                当前手势所在view
 */
- (void)panGesture_Event:(UIPanGestureRecognizer *)panGesture
{
    static CGFloat      lastPositionX = 0;
    static UIView       *lastView;
    
    CGFloat     leftThreshold_x             = self.width * (1.0 / 4);
    CGFloat     rightThreshold_x            = self.width * (3.0 / 4);
    CGPoint     position                    = [panGesture locationInView:self];
    CGFloat     rotationThreshold_degree    = 8.0 / 180 * M_PI;
    CardView    *gestureView                = (CardView *)panGesture.view;
    
    //  没有历史数据，每次切换页面时，只存储历史值，然后return
    if (!lastView || ![lastView isEqual:panGesture.view]) {
        lastView = panGesture.view;
        lastPositionX = position.x;
        return;
    }

    
    CGFloat tanA = (position.x - self.width / 2.0) / (cardView_height / 3.0);
    CGFloat rotation_degree = atan(tanA);
    
    
    //  旋转
    BOOL res_rotation1 = (rotation_degree > 0 && rotation_degree < rotationThreshold_degree);
    bool res_rotation2 = (rotation_degree < 0 && -rotation_degree < rotationThreshold_degree);
    if (res_rotation1 || res_rotation2)
    {
        
        gestureView.layer.position = CGPointMake(self.width / 2.0, self.height / 2.0 + cardView_height / 2.0);
        gestureView.layer.anchorPoint = CGPointMake(0.5, 1);

        gestureView.rotationAnimation.fromValue = gestureView.rotationAnimation.toValue;
        gestureView.rotationAnimation.toValue = [NSNumber numberWithFloat:rotation_degree];
        [gestureView.layer addAnimation:gestureView.rotationAnimation forKey:gestureView.rotationAnimation.keyPath];
        
    }
    
    //  平移
    else{
        
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
    }
    
    
    //  存储历史X值
    lastPositionX = position.x;
}

//  从左侧消失
- (void)disappearToLeft:(UIPanGestureRecognizer *)panGesture
{
    if (self.cardIndex + 1 > [_cardArray count]) {
        self.cardIndex = 0;
    }else{
        self.cardIndex = self.cardIndex + 1;
    }
}

//  从右侧消失
- (void)disappearToRight:(UIPanGestureRecognizer *)panGesture
{
    if (self.cardIndex + 1 > [_cardArray count]) {
        self.cardIndex = 0;
    }else{
        self.cardIndex = self.cardIndex + 1;
    }
}


#pragma mark - 重写cardIndex

@synthesize cardIndex = _cardIndex;
- (void)setCardIndex:(int)cardIndex
{
    _cardIndex = cardIndex;
    
    [self updateCardsWithAnimation:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
