//
//  UIColor+More.h
//  JLnews
//
//  Created by he15his on 13-12-6.
//  Copyright (c) 2013年 he15his. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (More)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (void)registerColor:(UIColor *)color forName:(NSString *)name;

+ (UIColor *)colorWithString:(NSString *)string;
+ (UIColor *)colorWithRGBValue:(uint32_t)rgb;
+ (UIColor *)colorWithRGBAValue:(uint32_t)rgba;
- (UIColor *)initWithString:(NSString *)string;
- (UIColor *)initWithRGBValue:(uint32_t)rgb;
- (UIColor *)initWithRGBAValue:(uint32_t)rgba;

- (uint32_t)RGBValue;
- (uint32_t)RGBAValue;
- (NSString *)stringValue;

- (BOOL)isMonochromeOrRGB;
- (BOOL)isEquivalent:(id)object;
- (BOOL)isEquivalentToColor:(UIColor *)color;

- (UIColor *)colorWithBrightness:(CGFloat)brightness;
- (UIColor *)colorBlendedWithColor:(UIColor *)color factor:(CGFloat)factor;

//+ (UIColor *)themeColorNamed:(NSString *)key;

@end
