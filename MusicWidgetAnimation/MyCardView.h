//
//  MyCardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/31.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CardView.h"

@class CardViewBack;

typedef enum {
    kCardStatus_Front,
    kCardStatus_Back,
}CardStatus;

@interface MyCardView : CardView

@property (assign, nonatomic) CGFloat   animationDuration_Flip;     //翻转动画时间

@property (strong, nonatomic) CardViewBack  *cardViewBack;
@property (strong, nonatomic) UIImageView   *headImgV;
@property (strong, nonatomic) UILabel       *mainLabel;
@property (strong, nonatomic) UILabel       *assignLabel_1;
@property (strong, nonatomic) UILabel       *assignLabel_2;

@property (strong, nonatomic) UIView        *frontBgView;
@property (strong, nonatomic) UIView        *backBgView;
@property (assign, nonatomic) CardStatus    cardStatus;

@end
