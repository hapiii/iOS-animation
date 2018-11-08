//
//  UoProgressHUD.h
//  UoUo
//
//  Created by 王强 on 2018/8/16.
//  Copyright © 2018年 鹰云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UoProgressHUD : UIView
/**
 线条颜色，默认为 [UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
中间图片
 */
@property (nonatomic, strong) UIImageView *centerImg;

/**
 动画内圈运动的时长，默认为1s
 */
@property CFTimeInterval inDuration;

/**
 动画外圈运动的时长，默认为1.5s
 */
@property CFTimeInterval outDuration;

/**
 线圈的颜色条
 */
@property(nonatomic, strong) CALayer  *outLayer;  // 外圈layer


/**
 初始化HUD
 
 @param frame 视图frame，默认中心为屏幕中心，大小为 (50, 50)
 @param lineColor 线条颜色，默认为 [UIColor whiteColor]
 @return WBProgressHUD
 */
-(instancetype) initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor;

/**
 开始动画
 */
-(void) start;

/**
 只停止动画
 */
-(void) stop;

/**
 停止动画并隐藏
 
 @param animated 是否开启动画隐藏
 */
-(void) hideAnimated:(BOOL)animated;

/**
 实例化添加到视图上
 
 @param view 需要添加的view， 默认为视图中心点
 @param animated 是否启动动画
 @return WBLoadingViewHUD
 */
+(instancetype) showToView:(UIView *)view animated:(BOOL)animated;
@end
