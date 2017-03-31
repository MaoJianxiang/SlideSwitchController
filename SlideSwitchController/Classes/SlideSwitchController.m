//
//  ScrollSlideControllers.m
//  Mao1
//
//  Created by Mao on 2017/3/29.
//  Copyright © 2017年 MaoJianxiang. All rights reserved.
//

#import "SlideSwitchController.h"

#define  Hidden self.navigationController.navigationBar.isHidden
#define  NavigationHeight self.navigationController.navigationBar.bounds.size.height


@interface SlideSwitchController ()<SlideMenuViewDelegate,UIScrollViewDelegate>


#pragma mark -- UITableviewDelegate

@end

@implementation SlideSwitchController

#pragma mark -- 初始化控制器
- (instancetype)initWithControllers:(NSArray *)controllers
                             titles:(NSArray *)titles
                   parentController:(UIViewController *)parentController{
    self = [super init];
    if (self) {
        [parentController addChildViewController:self];
        parentController.automaticallyAdjustsScrollViewInsets = NO;//禁让scrollView左右上下都滑动
        parentController.edgesForExtendedLayout = UIRectEdgeNone;
        [self didMoveToParentViewController:parentController];
        _tabHeight = 0;//默认为0;
        _topHeight = 0;//默认为0;
        
        _menuItemFont = [UIFont systemFontOfSize:16];
        _menuItemTitleColor = [UIColor lightGrayColor];
        _menuItemSelectedTitleColor = [UIColor cyanColor];
        _menuIndicatorColor = [UIColor cyanColor];
        _BGColor = [UIColor whiteColor];
        _titles = [NSMutableArray array];
        _controllers = [NSMutableArray array];
        _controllers = [controllers mutableCopy];
        //处理标题数组
        [self handleTitles:titles withControllers:controllers];

    }
    return self;
}
#pragma mark -- 处理标题数组和控制器数组
- (void)handleTitles:(NSArray *)titles withControllers:(NSArray *)controllers{
    //处理标题和controllers不一样的时候
    if (titles) {
        if (titles.count > controllers.count) {
            _titles = [[titles subarrayWithRange:NSMakeRange(0, controllers.count)]mutableCopy] ;
        }else if (titles.count < controllers.count){
            NSMutableArray *titleArray = [NSMutableArray arrayWithArray:titles];
            for ( int i = (int)titles.count; i < controllers.count; i++) {
                UIViewController *vc = controllers[i];
                NSString *titleStr = [vc valueForKey:@"title"];
                if (!titleStr) {
                    titleStr = @"标题";
                }
                [titleArray addObject:titleStr];
            }
            titles = [titleArray mutableCopy];
        }else{
            _titles = [titles mutableCopy];
        }
    }else{

        NSMutableArray *titles = [NSMutableArray array];
        for (UIViewController *vc in _controllers) {
            NSString *titleStr = [vc valueForKey:@"title"];
            if (!titleStr) {
                titleStr = @"标题";
            }
            [titles addObject:titleStr];
        }
        _titles = [titles mutableCopy];
    }
}
#pragma mark --getter方法
//当前控制器
- (UIViewController *)currentController{
    return  self.controllers[_currentControllerIndex];
}
//标题栏高度
- (CGFloat)menuViewHight{
    if (!_menuViewHight) {
        _menuViewHight = 40;
    }
    if (_menuViewHight < 40) {
        _menuViewHight = 40;
    }
    return _menuViewHight;
}

#pragma mark -- setter方法

//设置背景色
- (void)setBGColor:(UIColor *)BGColor{
    _BGColor = BGColor;
    self.view.backgroundColor = BGColor;
}


#pragma mark --添加当前的View为子控制器
- (void)setCurrentControllerIndex:(NSInteger)currentControllerIndex{
    _currentControllerIndex = currentControllerIndex;
    NSArray *childControllers =  [self childViewControllers];
    for (UIViewController *controller in childControllers) {
        [controller willMoveToParentViewController:self];
        [controller removeFromParentViewController];
        [controller didMoveToParentViewController:self];
    }
    UIViewController *currentController = (UIViewController *)self.controllers[currentControllerIndex];
    [currentController willMoveToParentViewController:self];
    [self addChildViewController:currentController];
    [currentController didMoveToParentViewController:self];
}

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //关闭透视效果
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (Hidden) {
        _topHeight = _topHeight+20;
    }
    if (!NavigationHeight) {
        _topHeight = _topHeight+20;
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, _topHeight, SMMainWidth, SMMMainHeight - _topHeight)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    //设置标题
    _menuView = [[SlideMenuView alloc]initWithFrame:CGRectMake(0,_topHeight, self.view.frame.size.width, self.menuViewHight)];
    _menuView.delegate = self;
    if (_menuBackGroudColor) {
        _menuView.BGColor = _menuBackGroudColor;
    }else{
        _menuView.BGColor = _BGColor;
    }
    _menuView.itemFont = _menuItemFont;
    _menuView.itemTitleColor = _menuItemTitleColor;
    _menuView.itemSelectedTitleColor = _menuItemSelectedTitleColor;
    _menuView.indicatorColor = _menuIndicatorColor;
    _menuView.scrollView.scrollsToTop = NO;
    
    //一定要在设置标题栏之前设置才有效
    if (self.menuItemWith) {
        _menuView.itemWith = self.menuItemWith;
    }
    _menuView.titles= self.titles;
     if (_shadowColor) {
        [_menuView setShadowViewColor:_shadowColor];
     }
    [self.view addSubview:_menuView];

    if (self.navigationController) {//兼容是否有导航栏
        CGFloat contentTop = 0;
        if (!Hidden) {//兼容有导航栏时是否隐藏的情况
            contentTop = NavigationHeight+20;
        }
        //设置内容
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_menuView.frame) , SMMainWidth, SMMMainHeight-CGRectGetMaxY(_menuView.frame)-contentTop)];
    }else{//当无导航栏的时候
        //设置内容
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_menuView.frame) , SMMainWidth, SMMMainHeight-CGRectGetMaxY(_menuView.frame))];

    }

    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.scrollsToTop = NO;
    [self.view addSubview:_contentScrollView];
    _contentScrollView.contentSize = CGSizeMake(SMMainWidth*self.controllers.count, _contentScrollView.frame.size.height);

    // 添加子视图的view到contentScrollView上
    for (int i = 0; i < self.controllers.count; i++) {
        id obj = [self.controllers objectAtIndex:i];
        if ([obj isKindOfClass:[UIViewController class]]) {
            UIViewController *controller = (UIViewController*)obj;
            CGFloat scrollWidth = SMMainWidth;
            CGFloat scrollHeght = _contentScrollView.frame.size.height;
            controller.view.frame = CGRectMake(i * scrollWidth, 0, scrollWidth, scrollHeght);
            [_contentScrollView addSubview:controller.view];
        }
    }
      _currentControllerIndex = 0;
}

#pragma mark - MenuViewDelegate 更新界面
- (void)scrollMenuViewSelectedIndex:(NSInteger)index{
 //获取目标offsetX值
    CGFloat targartX = SMMainWidth *index;
    self.currentControllerIndex = index;
    [self.contentScrollView setContentOffset:CGPointMake(targartX, 0) animated:YES];
}

#pragma mark -- c
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.isDragging) {
        CGFloat currentSetX = self.currentControllerIndex * SMMainWidth;
        CGFloat targartX =  scrollView.contentOffset.x;

        if (targartX < 0 || targartX > (self.controllers.count-1)*SMMainWidth) {
            return ;
        }

        if (currentSetX < targartX) {
            CGFloat ratio = (targartX - currentSetX)/SMMainWidth;
            [self.menuView scrollingToTargartViewZoomRatio:ratio Direction:SMDirectionTypeRight];
            if (ratio == 1) {
               self.currentControllerIndex++;
            }
        }else if (currentSetX > targartX){
            CGFloat ratio = (currentSetX - targartX)/SMMainWidth;
            [self.menuView scrollingToTargartViewZoomRatio:ratio Direction:SMDirectionTypeLeft];
            if (ratio == 1) {
                self.currentControllerIndex--;
            }
        }
    }

}

#pragma mark --拖动了一半而止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  NSInteger index =  round(scrollView.contentOffset.x/SMMainWidth);
    if (self.currentControllerIndex !=index) {
        self.currentControllerIndex = index;
    }
    [self.menuView adjustThePositionIndicatorWithNewIndex:self.currentControllerIndex];
}

@end
