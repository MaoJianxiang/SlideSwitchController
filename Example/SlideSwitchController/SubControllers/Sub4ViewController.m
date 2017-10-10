//
//  Sub4ViewController.m
//  SlideSwitchController
//
//  Created by SG on 2017/3/31.
//  Copyright © 2017年 15208105440@163.com. All rights reserved.
//

#import "Sub4ViewController.h"

@interface Sub4ViewController ()

@end

@implementation Sub4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.center = self.view.center;
    label.textAlignment=NSTextAlignmentCenter;
    label.text = @"第四页";
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
}



@end
