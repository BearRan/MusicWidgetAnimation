//
//  MyCardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/31.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CardViewCell.h"
#import "CardViewBack.h"
#import "CardViewFront.h"

typedef enum {
    kCardStatus_Front,
    kCardStatus_Back,
}CardStatus;

@interface MyCardView : CardViewCell

@property (assign, nonatomic) CGFloat   animationDuration_Flip;     //翻转动画时间

@property (strong, nonatomic) CardViewBack  *cardViewBack;
@property (strong, nonatomic) CardViewFront *cardViewFront;
@property (assign, nonatomic) CardStatus    cardStatus;

@end
