//
//  Sub5ViewController.m
//  SlideSwitchController
//
//  Created by SG on 2017/3/31.
//  Copyright © 2017年 15208105440@163.com. All rights reserved.
//

#import "Sub5ViewController.h"

@interface Sub5ViewController ()

@end

@implementation Sub5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.center = self.view.center;
    label.textAlignment=NSTextAlignmentCenter;
    label.text = @"第五页";
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
