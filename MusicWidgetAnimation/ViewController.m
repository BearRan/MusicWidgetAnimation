//
//  ViewController.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "ViewController.h"
#import "MusicWidgetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MusicWidgetView *musicWidgetView = [[MusicWidgetView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    musicWidgetView.backgroundColor = ys_302e35;
//    musicWidgetView.cardShowInView_Count = 6;
//    musicWidgetView.animationDuration_Normal = 2.0;
//    musicWidgetView.animationDuration_Flip = 1.0;
    musicWidgetView.cardRotateWhenPan = NO;
    
    [self.view addSubview:musicWidgetView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
