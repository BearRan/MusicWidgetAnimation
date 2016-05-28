//
//  CardViewCell.h
//  MusicWidgetAnimation
//
//  Created by Bear on 16/5/28.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardViewCell : UIView

@property (strong, nonatomic) NSString  *reuseIdentifier;

- (instancetype)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

@end
