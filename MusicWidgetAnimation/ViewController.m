//
//  ViewController.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "CardAnimationView.h"

@interface ViewController () <CardAnimationViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CardAnimationView *cardAnimationView = [[CardAnimationView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    cardAnimationView.delegate = self;
    cardAnimationView.backgroundColor = ys_302e35;
//    cardAnimationView.cardShowInView_Count = 6;
//    cardAnimationView.animationDuration_Normal = 2.0;
//    cardAnimationView.animationDuration_Flip = 1.0;
    cardAnimationView.cardRotateWhenPan = NO;
//    cardAnimationView.cardRotateMaxAngle = 45;
//    cardAnimationView.cardAlphaGapValue = 0.1;
//    cardAnimationView.cardOffSetPoint = CGPointMake(25, 40);
//    cardAnimationView.cardScaleRatio  = 0.15;

    [self.view addSubview:cardAnimationView];

}

//- (UIView *)cardViewFrontAtIndex:(int)index
//{
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
