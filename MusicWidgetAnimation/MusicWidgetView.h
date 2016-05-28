//
//  MusicWidgetView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/7.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kPanDir_Null,
    kPanDir_Right,
    kPanDir_Left,
}PanDirection;

@interface MusicWidgetView : UIView



@property (assign, nonatomic) CGFloat   animationDuration_Normal;   //普通动画时间
@property (assign, nonatomic) CGFloat   animationDuration_Flip;     //翻转动画时间
@property (assign, nonatomic) int       cardShowInView_Count;       //可见的卡片数量
@property (assign, nonatomic) BOOL      cardRotateWhenPan;          //卡片拖动时是否可旋转
@property (assign, nonatomic) CGFloat   cardRotateMaxAngle;         //卡片可旋转的最大角度(角度制，如，90，180)

@end
