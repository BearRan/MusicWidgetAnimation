//
//  CardViewFront.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/31.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CardViewFront.h"

#define color_blue      UIColorFromHEX(0x4cb9f3)
#define color_545556    UIColorFromHEX(0x545556)


@implementation CardViewFront

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    //  components
    _unitIndicatorPoint = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 9, 9)];
    _unitIndicatorPoint.layer.cornerRadius = _unitIndicatorPoint.width / 2.0;
    _unitIndicatorPoint.layer.masksToBounds = YES;
    _unitIndicatorPoint.backgroundColor = color_blue;
    [self addSubview:_unitIndicatorPoint];
    
    _unitLabel = [[UILabel alloc] init];
    _unitLabel.font = [UIFont systemFontOfSize:13];
    _unitLabel.textColor = color_545556;
    [self addSubview:_unitLabel];
    
    _headImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _headImgV.layer.cornerRadius = _headImgV.height / 2.0;
    _headImgV.layer.masksToBounds = YES;
    _headImgV.contentMode = UIViewContentModeScaleAspectFill;
    _headImgV.backgroundColor = [UIColor blueColor];
    [self addSubview:_headImgV];
    
    _mainLabel = [[UILabel alloc] init];
    [self addSubview:_mainLabel];
    
    _assignLabel_1 = [[UILabel alloc] init];
    [self addSubview:_assignLabel_1];
    
    _assignLabel_2 = [[UILabel alloc] init];
    [self addSubview:_assignLabel_2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _unitLabel.text = @"动漫Action";
    _assignLabel_1.text = @"EFG";
    _assignLabel_2.text = @"HIJ";
    
    
    
    
    [_unitLabel sizeToFit];
    [_unitLabel BearSetRelativeLayoutWithDirection:kDIR_RIGHT destinationView:_unitIndicatorPoint parentRelation:NO distance:4 center:YES];
    
    
    [_headImgV BearSetRelativeLayoutWithDirection:kDIR_UP destinationView:nil parentRelation:YES distance:50 center:YES];
    
    [_mainLabel sizeToFit];
    [_mainLabel BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_headImgV parentRelation:NO distance:30 center:YES];
    
    [_assignLabel_1 sizeToFit];
    [_assignLabel_1 BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_mainLabel parentRelation:NO distance:20 center:YES];
    
    [_assignLabel_2 sizeToFit];
    [_assignLabel_2 BearSetRelativeLayoutWithDirection:kDIR_DOWN destinationView:_assignLabel_1 parentRelation:NO distance:20 center:YES];
}

@end
