//
//  CardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewCell.h"

@interface CardView : CardViewCell

@property (strong, nonatomic) CABasicAnimation  *scaleAnimation;
@property (strong, nonatomic) CABasicAnimation  *rotationAnimation;
@property (strong, nonatomic) CABasicAnimation  *flipAnimation;

@end
