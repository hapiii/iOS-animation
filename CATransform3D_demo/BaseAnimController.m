//
//  BaseAnimController.m
//  CATransform3D_demo
//
//  Created by 王强 on 2018/11/7.
//  Copyright © 2018 鹰云. All rights reserved.
//

#import "BaseAnimController.h"
#import "WQProgressView.h"
#import "UoProgressHUD.h"

@interface BaseAnimController ()
@property(nonatomic,strong)WQProgressView *bgView;
@end

@implementation BaseAnimController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBg];
    //[self shapelayerAnim];
    // Do any additional setup after loading the view.
}
#define viewWidth 100
-(void)configBg{
     self.bgView = [[WQProgressView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.view addSubview:self.bgView];
    [self.bgView start];
    
    CGRect rect = CGRectMake(0, 0,100,100);
    UoProgressHUD *hud = [[UoProgressHUD alloc] initWithFrame:rect  lineColor:[UIColor whiteColor]];
    hud.backgroundColor = [UIColor clearColor];
    hud.frame = CGRectMake(100, 200, 100,100);
    hud.centerImg.image = [UIImage imageNamed:@"lines_reject"];
    [self.view addSubview:hud];
    [hud start];
    
    
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
