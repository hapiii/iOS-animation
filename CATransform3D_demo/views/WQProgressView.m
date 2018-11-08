//
//  WQProgressView.m
//  CATransform3D_demo
//
//  Created by 王强 on 2018/11/6.
//  Copyright © 2018 鹰云. All rights reserved.
//

#import "WQProgressView.h"

@implementation WQProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void) setup {
    
    self.loadingColor = [UIColor orangeColor];
    self.lineWidth = 6;
    self.radius  = 40;
    
   
    
}
- (void)start {
    [self reset];
    [self loading];
}
#pragma mark - reset
- (void)reset {
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.layer removeAllAnimations];
}

- (void) loading {
    
    CAShapeLayer * shapelayer = [CAShapeLayer layer];
    self.asmLayer = shapelayer;
    self.asmLayer.frame = CGRectMake(0, 0, self.radius * 2 + self.lineWidth, self.radius * 2 + self.lineWidth);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:self.asmLayer.bounds.size.width/2 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //路径
    shapelayer.path = path.CGPath;
    //填充色
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线的颜色
    shapelayer.strokeColor = self.loadingColor.CGColor;
    //线的宽度
    shapelayer.lineWidth = self.lineWidth;
    [self.layer addSublayer:shapelayer];
    
    //旋转
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:-M_PI*2];
    anima3.duration = 1.0f;
    anima3.repeatCount = MAXFLOAT;
    anima3.removedOnCompletion = NO;//不从渲染树中移除  不加这个属性，二次调用动画不执行
    anima3.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
   
    //
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.fromValue = [NSNumber numberWithFloat:0.f];
    anima.toValue = [NSNumber numberWithFloat:1.f];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    anima.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    anima.autoreverses = YES;
    anima.removedOnCompletion = NO;
    [shapelayer addAnimation:anima forKey:@"strokeEndAniamtion"];
    
   
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
