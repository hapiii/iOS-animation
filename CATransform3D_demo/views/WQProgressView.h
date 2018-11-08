//
//  WQProgressView.h
//  CATransform3D_demo
//
//  Created by 王强 on 2018/11/6.
//  Copyright © 2018 鹰云. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WQProgressView : UIView<CAAnimationDelegate>

@property(nonatomic, strong) CAShapeLayer *asmLayer;

@property(nonatomic, strong) UIColor *loadingColor;


@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, assign) CGFloat radius;

- (void) start;

@end


