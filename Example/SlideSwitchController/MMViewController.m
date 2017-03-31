//
//  MMViewController.m
//  SlideSwitchController
//
//  Created by 15208105440@163.com on 03/31/2017.
//  Copyright (c) 2017 15208105440@163.com. All rights reserved.
//

#import "MMViewController.h"
#import "SlideSwitchController.h"

#import "Sub1ViewController.h"
#import "Sub2ViewController.h"
#import "Sub3ViewController.h"
#import "Sub4ViewController.h"
#import "Sub5ViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    Sub1ViewController *sub1 = [[Sub1ViewController alloc] init];
    Sub2ViewController *sub2 = [[Sub2ViewController alloc] init];
    Sub3ViewController *sub3 = [[Sub3ViewController alloc] init];
    Sub4ViewController *sub4 = [[Sub4ViewController alloc] init];
    Sub5ViewController *sub5 = [[Sub5ViewController alloc] init];

    NSArray *controllers = @[sub1,sub2,sub3,sub4,sub5];

//#pragma mark -- 方式1
//     NSArray *titles = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"];
//    SlideSwitchController *slidswitch = [[SlideSwitchController alloc] initWithControllers:controllers titles:titles parentController:self];
//    [self.view addSubview:slidswitch.view];

    sub1.title = @"标题1";
    sub2.title = @"标题2";
    sub3.title = @"标题3";
    sub4.title = @"标题4";
    sub5.title = @"标题5";

    SlideSwitchController *slidswitch = [[SlideSwitchController alloc] initWithControllers:controllers titles:nil parentController:self];
    slidswitch.menuItemWith = 100;//每个标题为100，这样标题栏的滑动宽度就不会平分整个屏幕的宽度了

    //配置标题的相关参数
    slidswitch.menuBackGroudColor = [UIColor lightGrayColor];
    slidswitch.menuIndicatorColor = [UIColor redColor];
    slidswitch.menuItemTitleColor = [UIColor blackColor];
    slidswitch.menuItemSelectedTitleColor = [UIColor cyanColor];

    [self.view addSubview:slidswitch.view];










    
}



@end
