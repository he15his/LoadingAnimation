//
//  SnakeLoadingView.m
//  LoadingAnimation
//
//  Created by he15his on 15/6/4.
//  Copyright (c) 2015年 he15his. All rights reserved.
//

#import "SnakeLoadingView.h"
#import "UIColor+More.h"

@implementation SnakeLoadingView{
    CAShapeLayer *shapeLayer1;
    CAShapeLayer *shapeLayer2;
    CAGradientLayer *gradientLayer;
    CGFloat radius; //半圆的半径
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        radius = CGRectGetWidth(self.frame) / 8.0;
        _lineWidth = radius;
        
        //渐变layer
        gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithString:@"#7bea93"] CGColor],(id)[[UIColor colorWithString:@"#76e7c9"] CGColor], nil]];
        [gradientLayer setStartPoint:CGPointMake(0, 0.5)];
        [gradientLayer setEndPoint:CGPointMake(1, 0.5)];
        [self.layer addSublayer:gradientLayer];
        
        //图形layer
        CALayer *layer = [CALayer layer];
        layer.frame = self.bounds;
        shapeLayer1 = [self shapeLayer];
        shapeLayer2 = [self shapeLayer];
        [layer addSublayer:shapeLayer1];
        [layer addSublayer:shapeLayer2];
        
        gradientLayer.mask = layer;
    }
    return self;
}

- (CAShapeLayer *)shapeLayer {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.frame;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = _lineWidth;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    return shapeLayer;
}

//绘制图形路径
- (UIBezierPath *)sinPathWithProgress:(CGFloat)progress offsetX:(CGFloat)offsetX{
    
    CGRect frame = self.frame;
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat angle = 0;
    CGPoint point = CGPointMake(0, 0);
    CGFloat lineHeight = 0.0;
    CGFloat lineHeight_Max = CGRectGetHeight(frame) - 2 * radius - _lineWidth;
    CGFloat girth = (lineHeight_Max) * 3 + M_PI * radius * 3;
    BOOL clockwise = NO;
    BOOL isLine = NO;
    
    if (progress < 0.25) {
        isLine = NO;
        clockwise = YES;
        angle = M_PI + M_PI * progress / 0.25;

        if (progress > 0.125) {
            CGFloat angle1 = angle - M_PI_2 * 3;
            point.x = -radius * sin(angle1);
        }else{
            CGFloat angle1 = angle - M_PI;
            point.x = radius * cos(angle1);
        }
        point.x -= radius;
        point.y = radius;

    }else if (progress < 0.5) {
        isLine = YES;
        clockwise = YES;
        lineHeight = lineHeight_Max * (1 - (progress - 0.25) / 0.25);
        point.y = CGRectGetHeight(frame) - lineHeight - radius;
    }else if (progress < 0.75) {
        isLine = NO;
        clockwise = NO;
        angle = M_PI - M_PI * (progress - 0.5) / 0.25;
        
        if (progress > 0.625) {
            CGFloat angle1 = angle;
            point.x = -radius * cos(angle1);

        }else{
            CGFloat angle1 = angle - M_PI_2;
            point.x = radius * sin(angle1);
        }
        point.x -= radius;
        point.y = CGRectGetHeight(frame) - radius;

    }else {
        isLine = YES;
        clockwise = NO;
        lineHeight = lineHeight_Max * (1 - (progress - 0.75) / 0.25);
        point.y = lineHeight + radius;
    }
    
    point.x += offsetX;
    
    point.x += _lineWidth/2.0;
    point.y += _lineWidth/2.0;
    
    if (isLine) {
        [path moveToPoint:point];
    }
    
    CGFloat lineLenth = 0.0;
    BOOL filish = NO;
    
    do {
        if (isLine) {
            
            if (lineLenth + lineHeight >= girth) {
                lineHeight = girth - lineLenth;
                filish = YES;
            }
            
            lineLenth += lineHeight;
            
            if (!clockwise) {
                point.y -= lineHeight;
            }else {
                point.y += lineHeight;
            }
            [path addLineToPoint:point];
            angle = M_PI;
            clockwise = !clockwise;
        }else {
            
            CGFloat angleGirth;
            CGFloat endAngle = 0;
            
            if (!clockwise) {
                angleGirth = radius * angle;

                if (lineLenth + angleGirth >= girth) {
                    angleGirth = girth - lineLenth;
                    endAngle = M_PI - angleGirth / radius;
                    filish = YES;
                }
            }else {
                angleGirth = radius * (M_PI * 2 - angle);

                if (lineLenth + angleGirth >= girth) {
                    angleGirth = girth - lineLenth;
                    endAngle = M_PI + angleGirth / radius;;
                    filish = YES;
                }
            }
            
            point.x += radius;
            [path addArcWithCenter:point radius:radius startAngle:angle endAngle:endAngle clockwise:clockwise];
            point.x += radius;

            lineHeight = lineHeight_Max;
            lineLenth += angleGirth;
        }
        
        isLine = !isLine;
        
    } while (!filish);

    return path;
}

- (void)stopAnimation {
    [shapeLayer1 removeAllAnimations];
    [shapeLayer2 removeAllAnimations];
    
    shapeLayer1.hidden = YES;
    shapeLayer2.hidden = YES;
}

- (void)starAnimation {
    shapeLayer1.hidden = NO;
    shapeLayer2.hidden = NO;
    CGFloat offsetX = 4 * radius;
    shapeLayer1.path = [self sinPathWithProgress:0 offsetX:0].CGPath;
    shapeLayer2.path = [self sinPathWithProgress:0 offsetX:offsetX].CGPath;
    shapeLayer1.transform = CATransform3DTranslate(shapeLayer1.transform, -4*radius, 0, 0);
    shapeLayer2.transform = CATransform3DTranslate(shapeLayer2.transform, -4*radius, 0, 0);
    
    CABasicAnimation *animation1 = [CABasicAnimation animation];
    animation1.keyPath = @"transform";
    animation1.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(shapeLayer1.transform, 4*radius, 0, 0)];
    
    CABasicAnimation *animation4 = [CABasicAnimation animation];
    animation4.keyPath = @"transform";
    animation4.toValue = [NSValue valueWithCATransform3D:CATransform3DTranslate(shapeLayer2.transform, 4*radius, 0, 0)];
    
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"strokeStart";
    animation2.fromValue = @(2 / 3.0);
    animation2.toValue = @(0);
    
    CABasicAnimation *animation3 = [CABasicAnimation animation];
    animation3.keyPath = @"strokeEnd";
    animation3.fromValue = @(1);
    animation3.toValue = @(1 / 3.0);
    
    CAAnimationGroup *group1 = [CAAnimationGroup animation];
    group1.animations = @[animation1, animation2];
    group1.duration = 0.7;
    group1.repeatCount = INT_MAX;
    
    CAAnimationGroup *group2 = [CAAnimationGroup animation];
    group2.animations = @[animation4, animation3];
    group2.duration = 0.7;
    group2.repeatCount = INT_MAX;

    [shapeLayer1 addAnimation:group1 forKey:nil];
    [shapeLayer2 addAnimation:group2 forKey:nil];
}

#pragma mark - Setter

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    shapeLayer1.lineWidth = lineWidth;
    shapeLayer2.lineWidth = lineWidth;
    
    radius = (CGRectGetWidth(self.frame) - 2 * lineWidth) / 6.0;
}
@end
