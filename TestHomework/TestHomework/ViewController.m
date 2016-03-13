//
//  ViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "ViewController.h"
#import "TQFLmitFreeViewController.h"
#import "TQFReduceViewController.h"
#import "TQFFreeViewController.h"
#import "TQFRankViewController.h"
#import "TQFSubObjectViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTabBarController];
}
- (void)createTabBarController
{
    NSArray *ctrlArr = @[@"TQFLmitFreeViewController",@"TQFReduceViewController",@"TQFFreeViewController",@"TQFSubObjectViewController",@"TQFRankViewController"];
    NSArray *titleArr = @[@"限免",@"降价",@"免费",@"专题",@"热榜"];
    NSArray *imageArr = @[@"tabbar_limitfree",@"tabbar_reduceprice",@"tabbar_appfree",@"tabbar_subject",@"tabbar_rank"];
    //选中的图片
    NSArray *selectArray = @[@"tabbar_limitfree_press",@"tabbar_reduceprice_press",@"tabbar_appfree_press",@"tabbar_subject_press",@"tabbar_rank_press"];
    NSMutableArray *vcArray = [NSMutableArray new];
    for (int i = 0; i<ctrlArr.count; i++) {
        NSString *classStr = ctrlArr[i];
        //创建控制器
        UIViewController *vc =[[NSClassFromString(classStr) alloc]init];
        //获取标题和图片
        NSString *title = titleArr[i];
        NSString *imageName = imageArr[i];
        NSString *selImage = selectArray[i];
        
        //设置tabbarItem
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        
        [vcArray addObject:navi];
    }
    
    self.viewControllers = vcArray;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
