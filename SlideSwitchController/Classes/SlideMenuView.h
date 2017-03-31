//
//  MenuView.h
//  Mao1
//
//  Created by Mao on 2017/3/29.
//  Copyright © 2017年 MaoJianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SMDirectionType) {
    SMDirectionTypeLeft = 0,
    SMDirectionTypeRight
};

#define SMMainWidth  [UIScreen mainScreen].bounds.size.width
#define SMMMainHeight   [UIScreen mainScreen].bounds.size.height

@protocol SlideMenuViewDelegate <NSObject>

- (void)scrollMenuViewSelectedIndex:(NSInteger)index;

@end

@interface SlideMenuView : UIView
// 代理
@property(nonatomic,weak)id<SlideMenuViewDelegate> delegate;

// 滚动视图
@property(nonatomic,strong)UIScrollView *scrollView;
// 设选项的宽度
@property(assign,nonatomic)CGFloat itemWith;
// 标题数组
@property(nonatomic,strong)NSArray *titles;

//背景
@property (nonatomic, strong) UIColor *BGColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *itemSelectedTitleColor;
@property (nonatomic, strong) UIColor *indicatorColor;//指示器颜色

#pragma mark --根据缩放率和方向调整标题
- (void)scrollingToTargartViewZoomRatio:(CGFloat)ratio Direction:(SMDirectionType)type;

#pragma mark -- 调整标题位置
- (void)adjustThePositionIndicatorWithNewIndex:(NSInteger)index;

//设置阴影线
- (void)setShadowView:(UIView *)lineView;


@end
