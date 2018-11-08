//
//  UoProgressHUD.m
//  UoUo
//
//  Created by 王强 on 2018/8/16.
//  Copyright © 2018年 鹰云. All rights reserved.
//

#import "UoProgressHUD.h"

#define LoadingWidth 40   // 默认大小
@implementation UoProgressHUD{
    CAGradientLayer *_outGradientLayer;   
    CAShapeLayer *_outShapeLayer;
}

#pragma makr - Show To View
+(instancetype) showToView:(UIView *)view  animated:(BOOL)animated {
    
    CGRect rect = CGRectMake((view.bounds.size.width - LoadingWidth ) / 2, (view.bounds.size.height - LoadingWidth ) / 2, LoadingWidth, LoadingWidth);
    UoProgressHUD *hud = [[UoProgressHUD alloc] initWithFrame:rect lineColor:nil];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UoProgressHUD class]]) {
            if (!animated) {
                [(UoProgressHUD *)subView stop];
            }else{
                [(UoProgressHUD *)subView start];
            }
            return (UoProgressHUD *)subView;
        }
    }
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
    if (!animated) {
        [hud stop];
    }else {
        [hud start];
    }
    return hud;
}

#pragma mark - Clicye Life
-(instancetype)init {
    if (self == [super init]) {
        self = [self initWithFrame:CGRectZero  lineColor:nil];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor {
    if (self == [super initWithFrame:frame]) {
        self.lineColor = lineColor;
        // 默认时长
        self.inDuration = 1.0;
        self.outDuration = 1.5;
       
        
        if (!lineColor) {
            self.lineColor = [UIColor whiteColor];
        }
       
        
        [self initializeInterface];
    }
    return self;
}
-(void) initializeInterface {
    
    if (CGRectGetWidth(self.frame) == 0 || CGRectGetHeight(self.frame) == 0) {
        self.frame = CGRectMake(self.superview.center.x,self.superview.center.y, LoadingWidth, LoadingWidth);
    }
    self.layer.cornerRadius  = 5;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.95];
    

    _centerImg = [[UIImageView alloc] initWithFrame:self.frame];
    _centerImg.contentMode = UIViewContentModeCenter;
    [self addSubview:_centerImg];
    
    
    [self.layer addSublayer:self.outLayer];
    _outGradientLayer = [self createGradientLayer];
    _outShapeLayer = [self createCaShapeLayer];
    [self.outLayer addSublayer: _outGradientLayer];
    self.outLayer.mask = _outShapeLayer;
}

-(CAGradientLayer *)createGradientLayer{
    
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    _gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)self.lineColor.CGColor];
    //xy
    _gradientLayer.startPoint = CGPointMake(0.5, 0);
    _gradientLayer.endPoint = CGPointMake(1, 1);
    
    return _gradientLayer;
}

/**
 创建mask层
 @return maskLayer
 */
-(CAShapeLayer *)createCaShapeLayer{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat lineWidth = width / 25;  // 线宽
    CGPoint theCenter = CGPointMake(width / 2, height / 2);  // 视图中心点
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path = [UIBezierPath bezierPathWithArcCenter:theCenter radius:width / 4 startAngle:M_PI endAngle:0.999 * M_PI clockwise:YES];
    
    
    CAShapeLayer *_shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.path = path.CGPath;
    _shapeLayer.lineWidth = lineWidth;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = self.lineColor.CGColor;//边框色

    return _shapeLayer;
}

#pragma mark - Start Animations
-(void) start {
    if (self.outLayer.animationKeys) {
        // 有动画，直接返回
        return;
    }
    
    // 旋转动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(2 * M_PI);
    animation.toValue = @0;
    animation.cumulative = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = CGFLOAT_MAX;//一直重复
    animation.removedOnCompletion = NO;//不回到初始状态
    
   
    animation.fromValue = @0;
    animation.toValue = @(2 * M_PI);
    animation.duration = self.outDuration;
    [self.outLayer addAnimation:animation forKey:@"centerLayer_animation"];
    
}

#pragma mark - Stop Animations
-(void) stop {
   
    [self.outLayer removeAllAnimations];
}

#pragma mark - Hidden
-(void) hideAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.1 animations:^{
            [self stop];
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }else{
        [self stop];
        [self removeFromSuperview];
    }
}



-(CALayer *)outLayer {
    if (_outLayer) {
        return _outLayer;
    }
    _outLayer = [CALayer layer];
    _outLayer.frame = self.bounds;
    _outLayer.backgroundColor = [UIColor clearColor].CGColor;
    return _outLayer;
}

#pragma mark - Setter
-(void)setLineColor:(UIColor *)lineColor {
    if (_lineColor == lineColor) {
        return;
    }
    _lineColor = lineColor;
    // 重置颜色

    _outGradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor, (__bridge id)lineColor.CGColor];
    _outShapeLayer.strokeColor = lineColor.CGColor;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
