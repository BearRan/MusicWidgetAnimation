//
//  InterimImageCellView.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/10/2.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterimImageCellView : UIImageView

@property (assign, nonatomic) CGFloat   animationDuration_EX;
@property (assign, nonatomic) BOOL      animationFinished;

- (void)opacityAnimationShowWithImage:(UIImage *)image;
- (void)opacityAnimationHideWithImage:(UIImage *)image;

@end
