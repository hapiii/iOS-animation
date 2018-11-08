//
//  ViewController.m
//  CATransform3D_demo
//
//  Created by 王强 on 2018/11/6.
//  Copyright © 2018 鹰云. All rights reserved.
//

#import "ViewController.h"
#import "BaseAnimController.h"
#import "TransFormController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tb;
@property(nonatomic,strong)NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _arr = [NSArray arrayWithObjects:[BaseAnimController new],[TransFormController new], nil];
    [self.view addSubview:self.tb];
// Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"动画 %@",self.arr[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = _arr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UITableView *)tb{
    if (_tb==nil) {
        _tb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tb.delegate = self;
        _tb.dataSource = self;
    }
    return _tb;
}
@end
