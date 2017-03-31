//
//  MenuView.m
//  Mao1
//
//  Created by Mao on 2017/3/29.
//  Copyright © 2017年 MaoJianxiang. All rights reserved.
//

#import "SlideMenuView.h"

static const CGFloat MenuViewMargin = 5;
static const CGFloat indicatorHeight = 2;

@interface SlideMenuView()
// 指示View
@property(nonatomic,strong)UIView *indicatorView;
// 存放标题项的数组
@property(nonatomic,strong)NSArray *itemViews;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation SlideMenuView{
    CGFloat MenuViewWidth;
}

#pragma mark - 初始化的方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 默认颜色
        _BGColor = [UIColor whiteColor];
        _itemFont = [UIFont systemFontOfSize:16];
        _itemTitleColor = [UIColor lightGrayColor];
        _itemSelectedTitleColor = [UIColor cyanColor];
        _indicatorColor = [UIColor cyanColor];
;
        self.backgroundColor = _BGColor;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
       _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
      
    }
    return self;
}
#pragma mark --Setter方法
//背景
- (void)setBGColor:(UIColor *)BGColor{
    if (!BGColor) {
        return;
    }
    _BGColor = BGColor;
    self.backgroundColor = BGColor;
}

//字体
- (void)setItemFont:(UIFont *)itemFont{
    if (!itemFont) {
        return;
    }
    _itemFont = itemFont;
    for (UILabel *label in _itemViews) {
        label.font = itemFont;
        [label adjustsFontSizeToFitWidth];
    }
}
//字体的颜色
- (void)setItemTitleColor:(UIColor *)itemTitleColor{
    if (!itemTitleColor) {
        return ;
    }
    _itemTitleColor = itemTitleColor;
    for (UILabel *label in _itemViews) {
        label.textColor = itemTitleColor;
    }
}
//设置指示器颜色
- (void)setIndicatorColor:(UIColor *)indicatorColor{
    if (!indicatorColor) {
        return ;
    }
    _indicatorColor = indicatorColor;
    _indicatorView.backgroundColor = indicatorColor;
}
//设置选项的宽度
- (void)setItemWith:(CGFloat)itemWith{
    if (itemWith < 45) {
        _itemWith = 45;
    }else{
        _itemWith = itemWith;
    }
    MenuViewWidth = _itemWith;
}

#pragma mark -- 设置标题并初始化页面
//设置标题
- (void)setTitles:(NSArray *)titles{
    if (_titles == titles) {
        return;
    }
    _titles = titles;
    if (titles.count <= 3 || self.itemWith < 45) {
        MenuViewWidth = SMMainWidth/titles.count;
    }
    NSMutableArray *views = [NSMutableArray array];
    for (int i = 0; i < _titles.count; i ++) {
        CGRect frame = CGRectMake(MenuViewMargin + MenuViewWidth*i, 0, MenuViewWidth-2*MenuViewMargin, self.frame.size.height - indicatorHeight);
         UILabel *itemView = [[UILabel alloc] initWithFrame:frame];
        [_scrollView addSubview:itemView];
        itemView.tag = 200 + i;
        itemView.text = titles[i];
        itemView.userInteractionEnabled = YES;
        itemView.layer.cornerRadius = 3;
        itemView.layer.masksToBounds = YES;
        itemView.textAlignment = NSTextAlignmentCenter;
        itemView.font = self.itemFont;
        itemView.textColor = _itemTitleColor;
        [views addObject:itemView];
        if (i == 0) {
            itemView.textColor = _itemSelectedTitleColor;
        }

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapClick:)];
        [itemView addGestureRecognizer:tapGesture];
    }
    self.currentIndex = 0;
    self.itemViews = [NSArray arrayWithArray:views];
    
    //指示器
     _indicatorView = [[UIView alloc] init];
    _indicatorView.frame = CGRectMake(MenuViewMargin, self.frame.size.height - indicatorHeight, MenuViewWidth - 2*MenuViewMargin, indicatorHeight);
    _indicatorView.backgroundColor = self.indicatorColor;
    [_scrollView addSubview:_indicatorView];
    _scrollView.contentSize = CGSizeMake(MenuViewWidth*titles.count,self.frame.size.height);
    
}
#pragma mark -- 设置标题下面的阴影线
- (void)setShadowView:(UIView *)lineView{
    // 如果之前有View,就将其删除
    UIView *line = [self viewWithTag:300];
    if (line) {
        [line removeFromSuperview];
    }
    // 添加新的阴影
    if (lineView) {
      lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
        lineView.tag = 300;
      [self addSubview:lineView];
    }else{
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
        view.tag = 300;
        view.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:view];
    }
}
#pragma mark - 点击某个标题
- (void)itemViewTapClick:(UITapGestureRecognizer *)tapGesture{
    //只要有点击,马上执行动画，把交互关闭
    self.userInteractionEnabled = NO;
    self.superview.userInteractionEnabled = NO;

    UILabel *label = (UILabel *)[tapGesture view];
    NSInteger index = label.tag - 200;
    if (self.currentIndex == index) {
        return ;
    }
    [self adjustThePositionIndicatorWithNewIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:index];
    }
}

#pragma mark -- 调整标题位置
- (void)adjustThePositionIndicatorWithNewIndex:(NSInteger)index{
    //处理本身就是拖动到了正确位置的时候
     CGRect currentFrame = self.indicatorView.frame;
     CGFloat allowance = currentFrame.origin.x - (MenuViewWidth * index + MenuViewMargin) ;
    float FabsAllowance  = fabs(allowance);
    
    if (FabsAllowance < MenuViewMargin) {
        return ;
    }
    
    //获取要变动的ItemView
    UILabel *currentLabel = [self.scrollView viewWithTag:(self.currentIndex+200)];
    UILabel *tagartLabel = [self.scrollView viewWithTag:(200 + index)];
    currentLabel.textColor = _itemTitleColor;
    tagartLabel.textColor = _itemSelectedTitleColor;

    //获取要变动的指示器的位置
    CGRect tagartFrame = currentFrame;
    tagartFrame.origin.x = tagartLabel.frame.origin.x;

    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.frame = tagartFrame;
    } completion:^(BOOL finished) {
        if (self.itemWith && self.itemWith>=45) {
            [self updateScrollViewContentSize];
        }
        //只要更新完成,把交互打开
        self.userInteractionEnabled = YES;
        self.superview.userInteractionEnabled = YES;

    }];
    //保存选中项
    self.currentIndex = index;
}

#pragma mark -- 更新一个scrollView的ContentSize
- (void)updateScrollViewContentSize{
    //获取当前选项的大小x,注意处理边界的Margin
    CGFloat maxX = self.indicatorView.frame.origin.x+MenuViewWidth-MenuViewMargin;
    CGFloat minX = self.indicatorView.frame.origin.x-MenuViewMargin;

    //获取scrollView的x
    CGFloat offsetX = self.scrollView.contentOffset.x;

    //要么就是在最右边，maxX超出右边，要么就是在最左边，minx超出左边
    if (maxX > (offsetX + SMMainWidth)) {
        CGFloat tagartX = maxX - SMMainWidth;
        [self.scrollView setContentOffset:CGPointMake(tagartX, 0) animated:YES];
    }else if (minX < offsetX ){
        [self.scrollView setContentOffset:CGPointMake(minX, 0) animated:YES];
    }

}

- (void)scrollingToTargartViewZoomRatio:(CGFloat)ratio Direction:(SMDirectionType)type{
    CGFloat variable = MenuViewWidth*ratio;
     CGRect frame = self.indicatorView.frame;
    if (type == SMDirectionTypeRight) {
        frame.origin.x = self.currentIndex*MenuViewWidth+MenuViewMargin + variable;
        if (ratio == 1) {
            UILabel *currentLabel = [self.scrollView viewWithTag:(self.currentIndex+200)];
            UILabel *tagartLabel = [self.scrollView viewWithTag:(200 + self.currentIndex+1)];
            currentLabel.textColor = _itemTitleColor;
            tagartLabel.textColor = _itemSelectedTitleColor;
            [self updateScrollViewContentSize];
             self.currentIndex ++;
        }
    }
    else if (type == SMDirectionTypeLeft){
        frame.origin.x = self.currentIndex*MenuViewWidth+MenuViewMargin - variable;
        if (ratio == 1) {
            UILabel *currentLabel = [self.scrollView viewWithTag:(self.currentIndex+200)];
            UILabel *tagartLabel = [self.scrollView viewWithTag:(200 + self.currentIndex-1)];
            currentLabel.textColor = _itemTitleColor;
            tagartLabel.textColor = _itemSelectedTitleColor;
            [self updateScrollViewContentSize];
             self.currentIndex --;
        }
    }
    self.indicatorView.frame = frame;

}


@end
