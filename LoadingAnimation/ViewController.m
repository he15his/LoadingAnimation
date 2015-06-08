//
//  ViewController.m
//  LoadingAnimation
//
//  Created by he15his on 15/6/4.
//  Copyright (c) 2015年 he15his. All rights reserved.
//

#import "ViewController.h"
#import "SinLoadingView.h"
#import "UIColor+More.h"
#import "SnakeLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SinLoadingView *sinView = [[SinLoadingView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    sinView.backgroundColor = [UIColor colorWithString:@"#fcce2f"];
    sinView.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    [self.view addSubview:sinView];
    
    SnakeLoadingView *snakeView = [[SnakeLoadingView alloc] initWithFrame:CGRectMake(0, 0, 200, 130)];
    snakeView.center = CGPointMake(self.view.center.x, self.view.center.y+100);;
    snakeView.lineWidth = 33;
    snakeView.layer.shadowOpacity = 0.5;
    snakeView.layer.shadowOffset = CGSizeMake(0, 10);
    snakeView.layer.shadowColor = [UIColor colorWithString:@"#d1f7eb"].CGColor;
    [self.view addSubview:snakeView];
    [snakeView starAnimation];
    
//    [sinView performSelector:@selector(stopAnimation) withObject:nil afterDelay:10];
}

@end
