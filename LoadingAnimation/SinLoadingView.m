//
//  SinLoadingView.m
//  LoadingAnimation
//
//  Created by he15his on 15/6/4.
//  Copyright (c) 2015年 he15his. All rights reserved.
//

#import "SinLoadingView.h"

#define kPointNumber 15
#define kPointSpace  1.0

@implementation SinLoadingView {
    CAShapeLayer *shapeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = frame;
        shapeLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:shapeLayer];
        
        [self starAnimation];
    }
    return self;
}

- (UIBezierPath *)sinPathWithProgress:(CGFloat)progress {
    CGRect frame = self.frame;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat radius = (CGRectGetWidth(frame) - (kPointNumber - 1) * kPointSpace) / (CGFloat)kPointNumber / 2.0;
    
    for (NSInteger i = 0; i < kPointNumber; i++) {
        CGFloat x = radius + i * (kPointSpace + radius*2);
        CGFloat y = CGRectGetHeight(frame) / 2.0 * (sin(i / (kPointNumber - 1.0) * (M_PI * 2) + progress * M_PI * 2) + 1);
        [path moveToPoint:CGPointMake(x, y)];
        [path addArcWithCenter:CGPointMake(x, y) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    }
    return path;
}

- (void)starAnimation {
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressValueChange)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)progressValueChange {
    static CGFloat progress = 0.0;
    progress += 0.015;
    
    if (progress > 1) {
        progress = 0;
    }
    shapeLayer.path = [self sinPathWithProgress:progress].CGPath;
}
@end
