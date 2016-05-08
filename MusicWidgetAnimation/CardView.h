//
//  CardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (strong, nonatomic) UIImageView   *headImgV;
@property (strong, nonatomic) UILabel       *mainLabel;
@property (strong, nonatomic) UILabel       *assignLabel_1;
@property (strong, nonatomic) UILabel       *assignLabel_2;

@property (strong, nonatomic) CABasicAnimation  *scaleAnimation;

@end
