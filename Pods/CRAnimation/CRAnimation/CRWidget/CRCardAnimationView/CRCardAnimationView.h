//
//  CRCardAnimationView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRCardViewCell;
@class CRCardAnimationView;

typedef enum {
    kPanDir_Null,
    kPanDir_Right,
    kPanDir_Left,
}PanDirection;

@protocol CardAnimationViewDelegate <NSObject>

@required
- (CRCardViewCell *)cardViewInCardAnimationView:(CRCardAnimationView *)cardAnimationView AtIndex:(int)index;
- (NSInteger)numberOfCardsInCardAnimationView:(CRCardAnimationView *)cardAnimationView;
- (void)cardViewWillShowWithIndex:(NSInteger)index;

@end

@interface CRCardAnimationView : UIView

@property (weak, nonatomic) id<CardAnimationViewDelegate> delegate;

@property (assign, nonatomic) CGFloat   animationDuration_Normal;   //普通动画时间
@property (assign, nonatomic) int       cardShowInView_Count;       //可见的卡片数量
@property (assign, nonatomic) CGFloat   cardAlphaGapValue;          //相邻卡片alpha差值
@property (assign, nonatomic) CGPoint   cardOffSetPoint;            //相邻卡片偏移位置设定
@property (assign, nonatomic) CGFloat   cardScaleRatio;             //相邻卡片缩放比例
@property (assign, nonatomic) BOOL      cardCycleShow;              //卡片显示完毕后循环显示
@property (assign, nonatomic) BOOL      cardPanEnable;              //卡片是否允许拖动


@property (assign, nonatomic) BOOL      cardRotateWhenPan;          //卡片拖动时是否可旋转
@property (assign, nonatomic) CGFloat   cardRotateMaxAngle;         //卡片可旋转时:卡片可旋转的最大角度(角度制，如，90，180)
@property (assign, nonatomic) CGFloat   cardFlyMaxDistance;         //卡片不可旋转时:卡片移动超过某一值时就飞走的阈值


//  reuse
- (CRCardViewCell *)dequeueReusableCardViewCellWithIdentifier:(NSString *)CellIdentifier;

@end
