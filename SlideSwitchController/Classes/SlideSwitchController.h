//
//  ScrollSlideControllers.h
//  Mao1
//
//  Created by Mao on 2017/3/29.
//  Copyright © 2017年 MaoJianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideMenuView.h"

@interface SlideSwitchController : UIViewController


#pragma mark -- 参数配置
//每个标题的宽度，若设置了这个参数，那就会以这个参数设置无数个标题
@property(assign,nonatomic)CGFloat menuItemWith;

// 标题栏高度
@property(assign,nonatomic)CGFloat menuViewHight;



//top高度,Navigation的高度可以自行调整
@property (nonatomic, assign) CGFloat topHeight;
//tab高度
@property (nonatomic, assign) CGFloat tabHeight;
//ScrollSlideController 背景颜色
@property (nonatomic, strong) UIColor *BGColor;
//背景颜色
@property (nonatomic, strong) UIColor *menuBackGroudColor;
//字体大小
@property (nonatomic, strong) UIFont  *menuItemFont;
//字体的颜色
@property (nonatomic, strong) UIColor *menuItemTitleColor;
//字体选中的颜色
@property (nonatomic, strong) UIColor *menuItemSelectedTitleColor;
//指示器的颜色
@property (nonatomic, strong) UIColor *menuIndicatorColor;


#pragma mark -- 私用Private
//标题数组
@property (nonatomic, strong, readonly) NSMutableArray *titles;
//控制器
@property (nonatomic, strong, readonly) NSMutableArray *controllers;
//内容ScrollView
@property (nonatomic, strong, readonly) UIScrollView *contentScrollView;
//当前是第几个控制器，从0开始的
@property (nonatomic, assign, readonly) NSInteger currentControllerIndex;
//当前控制器
@property (nonatomic, strong, readonly) UIViewController *currentController;

#pragma mark -- 公用Public

/* controllers:子控制器数组
 * tabHeight:底部距离
 * titles:标题，可以nil,当为nil时，会去获取controllers的title,如果两者都为nil,那么显示为"标题"
 * parentController:父控制器
 */
- (instancetype)initWithControllers:(NSArray *)controllers
                             titles:(NSArray *)titles
                   parentController:(UIViewController *)parentController;
//标题View
@property(nonatomic,strong)SlideMenuView *menuView;

//设置阴影线，默认是灰色
- (void)setShadowView:(UIView *)lineView;
@end
