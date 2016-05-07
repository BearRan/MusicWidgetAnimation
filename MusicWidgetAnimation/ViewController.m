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
    [self.view addSubview:musicWidgetView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
