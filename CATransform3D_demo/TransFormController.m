//
//  TransFormController.m
//  CATransform3D_demo
//
//  Created by 王强 on 2018/11/7.
//  Copyright © 2018 鹰云. All rights reserved.
//

#import "TransFormController.h"
#define rad random()%4
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]//随机色


@interface TransFormController ()
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *maskView;

@property(nonatomic,strong)UIImageView *roteView;
@property(nonatomic,strong)UIImageView *leftView;
@property(nonatomic,strong)UIImageView *rightView;
@property(nonatomic,strong)NSMutableArray<UIImage *> *imgs;
@property(nonatomic,assign)NSInteger roteIndex;

@end

@implementation TransFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgs = [NSMutableArray new];
    for (int i = 1; i<5; i++) {
        NSString *str = [NSString stringWithFormat:@"%i",i];
        [_imgs addObject:[UIImage imageNamed:str]];
    }
    
    self.bgView = [[UIView alloc] init];
    self.bgView.bounds = CGRectMake(0, 0, 300,300);
    self.bgView.center = self.view.center;
    self.bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bgView];
    
    self.maskView = [[UIView alloc] initWithFrame:self.bgView.frame];
    
    
    self.leftView = [[UIImageView alloc] init];
    self.leftView.bounds = CGRectMake(0, 0, 150, 300);
    self.leftView.center = self.view.center;
    self.leftView.layer.anchorPoint = CGPointMake(1, 0.5);
    self.leftView.image = _imgs[1];
    
    
    [self.view addSubview:self.leftView];
    
    self.rightView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 150, 300)];
    self.rightView.image = _imgs[2];
    self.rightView.backgroundColor = [UIColor clearColor];
    
    [self.bgView addSubview:self.rightView];
    
    
    
    
    self.roteView = [[UIImageView alloc] init];
    self.roteView.bounds = CGRectMake(0, 0, 150, 300);
    self.roteView.center = self.view.center;
    
    self.roteView.image = _imgs[1];
    self.roteView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    [self.view addSubview:self.roteView];
    [self.view insertSubview:self.roteView aboveSubview:self.leftView];
    
    
    
    
    
    
    
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)pan:(UIPanGestureRecognizer *)pan{
    self.rightView.image = self.imgs[3];
    if (pan.state == UIGestureRecognizerStateChanged) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1 / 400.0;
        CGPoint transP = [pan translationInView:self.view];
        CGFloat angle = transP.x * (M_PI-1) / 300.0;
        self.roteView.layer.transform = CATransform3DRotate(transform, -angle, 0, -1, 0);
        
        
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
        [UIView animateWithDuration:2 animations:^{
            CATransform3D transform = CATransform3DIdentity;
            
            transform.m34 = -1 / 400.0;
            
            
            CGFloat angle = 300 * (M_PI-1) / 300.0;
            
            self.roteView.layer.transform = CATransform3DRotate(transform, -angle, 0, -1, 0);
        } completion:^(BOOL finished) {
            
            
            self.leftView.image = self.roteView.image;
            self.roteView.image = self->_imgs[rad];
            
            
            self.roteView.layer.transform = CATransform3DIdentity;
        }];
        
    }
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
