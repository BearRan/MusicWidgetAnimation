//
//  CardViewCell.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/28.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CardViewCell.h"

@implementation CardViewCell

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
