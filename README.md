# SlideSwitchController

[![CI Status](http://img.shields.io/travis/15208105440@163.com/SlideSwitchController.svg?style=flat)](https://travis-ci.org/15208105440@163.com/SlideSwitchController)
[![Version](https://img.shields.io/cocoapods/v/SlideSwitchController.svg?style=flat)](http://cocoapods.org/pods/SlideSwitchController)
[![License](https://img.shields.io/cocoapods/l/SlideSwitchController.svg?style=flat)](http://cocoapods.org/pods/SlideSwitchController)
[![Platform](https://img.shields.io/cocoapods/p/SlideSwitchController.svg?style=flat)](http://cocoapods.org/pods/SlideSwitchController)


## 变更

 - 移除默认的标题灰色阴影效果，通过设置shadowColor阴影线颜色属性来添加阴影色的颜色效果。若不设置就没有效果
 @property (nonatomic, strong) UIColor *shadowColor;

## 简要

 - 这是一个实现标题选项选择和视图拖动切换视图控制器的文件，SlideSwitchController是主要是实现控制器，而且SlideMenuView是标题视图。

 - SlideSwitchController已经处理了导航栏推出，导航栏隐藏，无导航栏的情况下视图控制器的显示问题。若要再单独调整位置，可以再设置topHeight的属性。但是要注意的是在使用子视图控制器中，view.center在显示时不是在View的中心，也不是在屏幕中心，所以要根据情况调整frame.

 -  SlideMenuView标题视图，在子视图控制器为3个(包含)以下时，以及未设置标题宽度(menuItemWith)属性时，都会以标题全屏平分标题处理。

 -  SlideMenuView标题视图，在子视图控制器为多个情况下，可以固定每个标题宽度，设置SlideSwitchController的属性menuItemWith属性即可实现。标题的宽度不低于45，设置时低于了45,会以45的宽度加载。

 -  通过设置SlideSwitchController的标题栏高度属性menuViewHight，可以调整SlideMenuView标题视图的高度。


## 使用说明

 - 通过设置属性可以配置相关的属性来配置关相显示效果。
 1.每个标题的宽度\n@property(assign,nonatomic)CGFloat menuItemWith;
 2.标题栏高度
 @property(assign,nonatomic)CGFloat menuViewHight;
 3.top高度,Navigation的高度可以自行调整
 @property (nonatomic, assign) CGFloat topHeight;
 4.tab高度
 @property (nonatomic, assign) CGFloat tabHeight;
 5.ScrollSlideController 背景颜色
 @property (nonatomic, strong) UIColor *BGColor;
 6.背景颜色
 @property (nonatomic, strong) UIColor *menuBackGroudColor;
 7.字体大小
 @property (nonatomic, strong) UIFont  *menuItemFont;
 8.字体的颜色
 @property (nonatomic, strong) UIColor *menuItemTitleColor;
 9.字体选中的颜色
 @property (nonatomic, strong) UIColor *menuItemSelectedTitleColor;
 10.指示器的颜色
 @property (nonatomic, strong) UIColor *menuIndicatorColor;
 
 - 获取当前相关信息
 
 1.标题数组
 @property (nonatomic, strong, readonly) NSMutableArray *titles;
 2.控制器
 @property (nonatomic, strong, readonly) NSMutableArray *controllers;
 3.内容ScrollView
 @property (nonatomic, strong, readonly) UIScrollView *contentScrollView;
 4.当前是第几个控制器，从0开始的
 @property (nonatomic, assign, readonly) NSInteger currentControllerIndex;
 5.当前控制器
 @property (nonatomic, strong, readonly) UIViewController *currentController;
 6.标题View
 @property(nonatomic,strong)SlideMenuView *menuView;

 - 标题栏上加一小横线

     方法：- (void)setShadowView:(UIView *)lineView;
   
## 实例

   - 实例化五个视图控制器
   
   Sub1ViewController *sub1 = [[Sub1ViewController alloc] init];
   Sub2ViewController *sub2 = [[Sub2ViewController alloc] init];
   Sub3ViewController *sub3 = [[Sub3ViewController alloc] init];
   Sub4ViewController *sub4 = [[Sub4ViewController alloc] init];
   Sub5ViewController *sub5 = [[Sub5ViewController alloc] init];
   NSArray *controllers = @[sub1,sub2,sub3,sub4,sub5];


- 加载显示：

方式1:

NSArray *titles = @[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"];
SlideSwitchController *slidswitch = [[SlideSwitchController alloc] initWithControllers:controllers titles:titles parentController:self];[self.view addSubview:slidswitch.view];


方式2: 若不传titles,则设置子视图控制器的title。

sub1.title = @"标题1";
sub2.title = @"标题2";
sub3.title = @"标题3";
sub4.title = @"标题4";
sub5.title = @"标题5";


SlideSwitchController *slidswitch = [[SlideSwitchController alloc] initWithControllers:controllers titles:nil parentController:self];


/*每个标题为100，这样标题栏的宽度就不会平分整个屏幕的宽度,可去拖动选择标题*/
slidswitch.menuItemWith = 100;


/*配置标题的相关参数*/
slidswitch.menuBackGroudColor = [UIColor lightGrayColor];
slidswitch.menuIndicatorColor = [UIColor redColor];
slidswitch.menuItemTitleColor = [UIColor blackColor];
slidswitch.menuItemSelectedTitleColor = [UIColor cyanColor];

[self.view addSubview:slidswitch.view];

```ruby
pod "SlideSwitchController"
```

## Author

 毛建祥, 15208105440@163.com

## License

SlideSwitchController is available under the MIT license. See the LICENSE file for more info.
