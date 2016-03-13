//
//  TQFNavViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFNavViewController.h"
#import "MyUtil.h"
@interface TQFNavViewController ()

@end

@implementation TQFNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//标题名字
- (void)addNavLabelTitle:(NSString *)title
{
    UIColor *color = [UIColor colorWithRed:80/255.0 green:160/255.0  blue:200/255.0  alpha:1];
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(80, 0, 215, 44) text:title textAligoment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:28] textColor:color];
    self.navigationItem.titleView =label;
    
}
//导航左右按钮
- (void)addNaviButton:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action isLeft:(BOOL)isLeft
{
    UIButton *button = [MyUtil createButtonFrame:CGRectMake(10, 4, 60, 36) title:title bgImageName:bgImageName imageName:nil target:target action:action];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    if (isLeft ==YES) {
        self.navigationItem.leftBarButtonItem = item;
    }else
    {
        self.navigationItem.rightBarButtonItem = item;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
