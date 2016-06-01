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

@interface ViewController () <CardAnimationViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CardAnimationView *cardAnimationView = [[CardAnimationView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    cardAnimationView.delegate = self;
    cardAnimationView.backgroundColor = ys_302e35;
    cardAnimationView.cardShowInView_Count = 6;
//    cardAnimationView.animationDuration_Normal = 0.7;
//    cardAnimationView.animationDuration_Flip = 1.0;
//    cardAnimationView.cardRotateWhenPan = NO;
//    cardAnimationView.cardRotateMaxAngle = 45;
//    cardAnimationView.cardAlphaGapValue = 0.1;
//    cardAnimationView.cardOffSetPoint = CGPointMake(25, 40);
//    cardAnimationView.cardScaleRatio  = 0.15;
//    cardAnimationView.cardFlyMaxDistance = 80;
    cardAnimationView.cardCycleShow = YES;
//    cardAnimationView.cardPanEnable = NO;

    [self.view addSubview:cardAnimationView];

}


#pragma mark - CardAnimationView delegate
- (CardViewCell *)cardViewInCardAnimationView:(CardAnimationView *)cardAnimationView AtIndex:(int)index
{
    CGFloat cardView_width = WIDTH * 0.8;
    CGFloat cardView_height = HEIGHT * 0.7;
    NSString *cardViewID_Str = @"cardViewID_Str";
    
    MyCardView *cardView = (MyCardView *)[cardAnimationView dequeueReusableCardViewCellWithIdentifier:cardViewID_Str];
    if (!cardView) {
        cardView = [[MyCardView alloc] initWithFrame:CGRectMake(0, 0, cardView_width, cardView_height) reuseIdentifier:cardViewID_Str];
    }
    
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.cardViewFront.mainLabel.text = [NSString stringWithFormat:@"%d--1", index];
    
    return cardView;
}

- (NSInteger)numberOfCardsInCardAnimationView:(CardAnimationView *)cardAnimationView
{
    return 20;
}

- (void)cardViewWillShowWithIndex:(NSInteger)index
{
    NSLog(@"index:%ld", (long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
