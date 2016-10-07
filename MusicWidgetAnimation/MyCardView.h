//
//  MyCardView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/31.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "CRCardViewCell.h"
#import "CardViewBack.h"
#import "CardViewFront.h"
@class MyCardView;

typedef enum {
    kCardStatus_Front,
    kCardStatus_Back,
}CardStatus;

@protocol MyCardViewDelegate <NSObject>

- (void)myCardViewFlipAnimationDoing:(MyCardView *)cardView;
- (void)myCardViewFlipAnimationFinished:(MyCardView *)cardView;

@end

@interface MyCardView : CRCardViewCell

@property (assign, nonatomic) CGFloat   animationDuration_Flip;     //翻转动画时间

@property (strong, nonatomic)   CardViewBack  *cardViewBack;
@property (strong, nonatomic)   CardViewFront *cardViewFront;
@property (assign, nonatomic)   CardStatus    cardStatus;
@property (weak, nonatomic)     id<MyCardViewDelegate> delegate;

@end
