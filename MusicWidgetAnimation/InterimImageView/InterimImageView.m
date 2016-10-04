//
//  InterimImageView.m
//  MusicWidgetAnimation
//
//  Created by Bear on 16/6/3.
//  Copyright © 2016年 Bear. All rights reserved.
//

#import "InterimImageView.h"
#import "InterimImageCellView.h"

@interface InterimImageView ()

@property (strong, nonatomic) NSString          *nowImageName;
@property (strong, nonatomic) NSMutableArray    *imageViewsArray;   //复用队列数组
@property (assign, nonatomic) NSInteger         imageViewsIndexNow; //复用队列中计数器，从0开始计数
@property (assign, nonatomic) NSInteger         imageViewsMaxNum;   //复用队列数量上限


@end

@implementation InterimImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _animationDuration_EX = 0.3;
        
        _imageViewsArray = [NSMutableArray new];
        _imageViewsIndexNow = -1;
        _imageViewsMaxNum = 5;
        
        
        //  虚化背景
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.alpha = 0.8;
        visualEffectView.frame = self.frame;
        visualEffectView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        [self addSubview:visualEffectView];

    }
    
    return self;
}

@synthesize nextImageName = _nextImageName;
- (void)setNextImageName:(NSString *)nextImageName
{
    _nextImageName = nextImageName;
    
    //  第一次加载，无动效
    if ([_nowImageName length] == 0) {
        
        [self insertImage:nextImageName];
    }else{
        
        [self insertImage:nextImageName];
        [self hideFormerImage];
    }
}

- (void)insertImage:(NSString *)imgName
{
    __weak typeof(self) weakSelf = self;
    
    void (^insertNewBlock)() = ^(){
        InterimImageCellView *interimImageCellView = [[InterimImageCellView alloc] initWithFrame:self.bounds];
        interimImageCellView.animationDuration_EX = _animationDuration_EX;
        
        //  放置图层最上方
        [weakSelf insertSubview:interimImageCellView atIndex:[[weakSelf subviews] count]];
        
        [interimImageCellView opacityAnimationShowWithImage:[UIImage imageNamed:imgName]];
        [_imageViewsArray addObject:interimImageCellView];
        
        _imageViewsIndexNow ++;
    };
    
    void (^hideLastBlock)() = ^(){
        
        InterimImageCellView *formerImageCellView = [weakSelf getFormerImageCellView];
        [formerImageCellView opacityAnimationHideWithImage:nil];
    };
    
    //  第一次切换图片
    if ([_imageViewsArray count] == 0) {
        
        if (insertNewBlock) {
            insertNewBlock();
        }
    }
    //  非第一次切换图片
    else{
        
        //  新增InterimImageCellView
        if ([_imageViewsArray count] < _imageViewsMaxNum) {
            
            if (insertNewBlock) {
                insertNewBlock();
            }
            
            if (hideLastBlock) {
                hideLastBlock();
            }
        }
        
        //  复用队列中尾部ImageCellView
        else{
            
            InterimImageCellView *tailImageCellView = [self getQueueTailImageCellView];
            
            //  放置图层最上方
            [self insertSubview:tailImageCellView atIndex:[[self subviews] count]];
            
            [tailImageCellView opacityAnimationShowWithImage:[UIImage imageNamed:imgName]];
            
            _imageViewsIndexNow = [self getImageCellViewIndex:tailImageCellView];
            
            if (hideLastBlock) {
                hideLastBlock();
            }
        }
    }
    
    
    
    
}

- (void)hideFormerImage
{
    InterimImageCellView *formerImageCellView = [self getFormerImageCellView];
    
    if (formerImageCellView) {
        [formerImageCellView opacityAnimationHideWithImage:nil];
    }
}

- (InterimImageCellView *)getFormerImageCellView
{
    if ([_imageViewsArray count] <= 1) {
        return nil;
    }
    
    NSInteger imageViewsIndexFormer = _imageViewsIndexNow - 1;
    if (imageViewsIndexFormer < 0) {
        imageViewsIndexFormer = [_imageViewsArray count] - 1;
    }
    
    InterimImageCellView *formerImageCellView = _imageViewsArray[imageViewsIndexFormer];
    return formerImageCellView;
}

- (InterimImageCellView *)getQueueTailImageCellView
{
    if ([_imageViewsArray count] <= 1) {
        return nil;
    }
    
    //  数量未满
    if ([_imageViewsArray count] < _imageViewsMaxNum){
        return nil;
    }
    
    NSInteger imageViewsIndexTail = _imageViewsIndexNow + 1;
    if (imageViewsIndexTail > [_imageViewsArray count] - 1) {
        imageViewsIndexTail = 0;
    }
    
    InterimImageCellView *formerImageCellView = _imageViewsArray[imageViewsIndexTail];
    return formerImageCellView;
}

- (NSInteger)getImageCellViewIndex:(InterimImageCellView *)imageCellView
{
    NSInteger index = [_imageViewsArray indexOfObject:imageCellView];
    
    return index;
}

@end
