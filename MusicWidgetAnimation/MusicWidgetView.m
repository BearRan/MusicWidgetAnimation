//
//  MusicWidgetView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "MusicWidgetView.h"
#import "CardView.h"

static int cardShowInView_Count = 3;

@interface MusicWidgetView ()

@property (strong, nonatomic) NSMutableArray *cardArray;

@end

@implementation MusicWidgetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    
    return self;
}

- (void)createUI
{
    _cardArray = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < cardShowInView_Count + 1; i++) {
        CardView *cardView = [[CardView alloc] initWithFrame:CGRectMake(0, 0, WIDTH * 0.8, HEIGHT * 0.7)];
        cardView.backgroundColor = [UIColor orangeColor];
        [self addSubview:cardView];
        [_cardArray addObject:cardView];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
