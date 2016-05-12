//
//  CardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kCardStatus_Front,
    kCardStatus_Back,
}CardStatus;

@class CardViewBack;

@interface CardView : UIView

@property (strong, nonatomic) CardViewBack  *cardViewBack;
@property (strong, nonatomic) UIImageView   *headImgV;
@property (strong, nonatomic) UILabel       *mainLabel;
@property (strong, nonatomic) UILabel       *assignLabel_1;
@property (strong, nonatomic) UILabel       *assignLabel_2;

@property (strong, nonatomic) CABasicAnimation  *scaleAnimation;
@property (strong, nonatomic) CABasicAnimation  *rotationAnimation;
@property (strong, nonatomic) CABasicAnimation  *flipAnimation;

@property (strong, nonatomic) UIView        *frontBgView;
@property (strong, nonatomic) UIView        *backBgView;
@property (assign, nonatomic) CardStatus    cardStatus;

@end
