//
//  ViewController.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "CardAnimationView.h"
#import "MyCardView.h"
#import "ExchangeImageView.h"
#import "BottomPageView.h"

@interface ViewController () <CardAnimationViewDelegate>
{
    NSArray             *_imageArray;
    NSArray             *_nameArray;
    NSArray             *_artistNameArray;
    NSArray             *_timeArray;
    NSArray             *_unitArray;
    
    ExchangeImageView   *_bgImageView;
    BottomPageView      *_bottomPageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _imageArray = @[@"TestImage_1",
                    @"TestImage_2",
                    @"TestImage_3",
                    @"TestImage_4",
                    @"TestImage_5",
                    @"TestImage_6",
                    @"TestImage_7",
                    @"TestImage_8",
                    @"TestImage_9",
                    @"TestImage_10",
                    @"TestImage_11",
                    @"TestImage_12",
                    @"TestImage_13",
                    @"TestImage_14",
                    @"TestImage_15",
                    @"TestImage_16",
                    @"TestImage_17",
                    @"TestImage_18"];
    
    _nameArray = @[@"人型电脑天使心",
                    @"Bleach",
                    @"境界的彼方",
                    @"TestImage_4",
                    @"TestImage_5",
                    @"Bleach",
                    @"TestImage_7",
                    @"境界的彼方",
                    @"人型电脑天使心",
                    @"境界的彼方",
                    @"TestImage_11",
                    @"Bleach",
                    @"TestImage_13",
                    @"TestImage_14",
                    @"TestImage_15",
                    @"TestImage_16",
                    @"TestImage_17",
                    @"TestImage_18"];
    
    _artistNameArray = @[@"本须秀树",
                    @"黑崎一护",
                    @"神原秋人－栗山未来",
                    @"TestImage_4",
                    @"TestImage_5",
                    @"黑崎一护",
                    @"TestImage_7",
                    @"栗山未来",
                    @"本须和秀树",
                    @"神原秋人－栗山未来",
                    @"TestImage_11",
                    @"乌尔奇奥拉·西法",
                    @"TestImage_13",
                    @"TestImage_14",
                    @"TestImage_15",
                    @"TestImage_16",
                    @"TestImage_17",
                    @"TestImage_18"];
    
    _timeArray = @[@"时长： 40:20",
                    @"时长： 34:10",
                    @"时长： 44:24",
                    @"时长： 10:34",
                    @"时长： 41:52",
                    @"时长： 14:42",
                    @"时长： 38:31",
                    @"时长： 36:14",
                    @"时长： 51:42",
                    @"时长： 26:15",
                    @"时长： 21:51",
                    @"时长： 14:43",
                    @"时长： 17:57",
                    @"时长： 43:14",
                    @"时长： 15:22",
                    @"时长： 41:50",
                    @"时长： 12:20",
                    @"时长： 30:14"];
    
    _unitArray = @[@"动漫Action",
                    @"动漫小分队",
                    @"动漫Action",
                    @"漫漫来",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action",
                    @"动漫Action"];
    
    
    
    CardAnimationView *cardAnimationView = [[CardAnimationView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    cardAnimationView.delegate = self;
    cardAnimationView.backgroundColor = [UIColor clearColor];
    cardAnimationView.cardShowInView_Count = 3;
//    cardAnimationView.animationDuration_Normal = 0.7;
//    cardAnimationView.animationDuration_Flip = 1.0;
//    cardAnimationView.cardRotateWhenPan = NO;
//    cardAnimationView.cardRotateMaxAngle = 45;
//    cardAnimationView.cardAlphaGapValue = 0.1;
    cardAnimationView.cardOffSetPoint = CGPointMake(0, 30);
    cardAnimationView.cardScaleRatio  = 0.09;
//    cardAnimationView.cardFlyMaxDistance = 80;
    cardAnimationView.cardCycleShow = YES;
//    cardAnimationView.cardPanEnable = NO;
    [self.view addSubview:cardAnimationView];
    
    _bgImageView = [[ExchangeImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _bgImageView.animationDuration_EX = 0.3;
    [self.view insertSubview:_bgImageView belowSubview:cardAnimationView];
    
    _bottomPageView = [[BottomPageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    _bottomPageView.pageAll = [_imageArray count];
    _bottomPageView.pageNow = 0;
    [self.view insertSubview:_bottomPageView belowSubview:cardAnimationView];
    [_bottomPageView setMaxY:HEIGHT - 30];

}


#pragma mark - CardAnimationView delegate
- (CardViewCell *)cardViewInCardAnimationView:(CardAnimationView *)cardAnimationView AtIndex:(int)index
{
    CGFloat cardView_width = (1.0 * 540 / 640) * WIDTH;
    CGFloat cardView_height = (1.0 * 811 / 1134) * HEIGHT;
    NSString *cardViewID_Str = @"cardViewID_Str";
    
    MyCardView *cardView = (MyCardView *)[cardAnimationView dequeueReusableCardViewCellWithIdentifier:cardViewID_Str];
    if (!cardView) {
        cardView = [[MyCardView alloc] initWithFrame:CGRectMake(0, 0, cardView_width, cardView_height) reuseIdentifier:cardViewID_Str];
    }
    
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.cardViewFront.headImgV.image = [UIImage imageNamed:_imageArray[index]];
    cardView.cardViewFront.mainLabel.text = _nameArray[index];
    cardView.cardViewFront.assignLabel_1.text = _artistNameArray[index];
    cardView.cardViewFront.assignLabel_2.text = _timeArray[index];
    cardView.cardViewFront.unitLabel.text = _unitArray[index];
    
    return cardView;
}

- (NSInteger)numberOfCardsInCardAnimationView:(CardAnimationView *)cardAnimationView
{
    return [_imageArray count];
}

- (void)cardViewWillShowWithIndex:(NSInteger)index
{
    NSLog(@"index:%ld", (long)index);
    _bgImageView.nextImageName = _imageArray[index];
    _bottomPageView.pageNow = index;
//    _bgImageView.image = [UIImage imageNamed:_imageArray[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
