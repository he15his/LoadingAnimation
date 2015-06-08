//
//  SnakeLoadingView.h
//  LoadingAnimation
//
//  Created by he15his on 15/6/4.
//  Copyright (c) 2015年 he15his. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnakeLoadingView : UIView
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *color;

- (void)stopAnimation;
- (void)starAnimation;
@end
