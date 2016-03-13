//
//  TQFPicViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/12.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFPicViewController.h"
#import "DetailItem.h"
#import "MyUtil.h"
#import "UIImageView+WebCache.h"
#import "DetailItem.h"
@interface TQFPicViewController ()<UIScrollViewDelegate>

{
    UILabel *_label;
}
@end

@implementation TQFPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self createMyNavi];
    [self createScrollView];
}
-(void)createMyNavi
{
    UIImageView *imageView = [MyUtil createImageViewFrame:CGRectMake(0, 20, 375, 44) imageName:@"navigationbar"];
    imageView.userInteractionEnabled= YES;
    [self.view addSubview:imageView];
    UIButton *button = [MyUtil createButtonFrame:CGRectMake(300, 2, 60, 40) title:@"确定" bgImageName:nil imageName:@"buttonbar_action " target:self action:@selector(buttonCilck)];
    [imageView addSubview:button];
     _label= [MyUtil createLabelFrame:CGRectMake(100, 4, 100, 30) text:nil textAligoment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:18] textColor:[UIColor blackColor]];
    [imageView addSubview:_label];
    
}
- (void)buttonCilck
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, 375, 300)];
    scrollView.delegate= self;
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceHorizontal = YES;
    [self.view addSubview:scrollView];
    CGFloat width = scrollView.bounds.size.width;
    CGFloat height = scrollView.bounds.size.height;
    for (int i = 0; i<self.imageArr.count; i++) {
        
        UIImageView *imageView = [MyUtil createImageViewFrame:CGRectMake(width*i, 0, width, height) imageName:nil];
        PhotoItem *item =self.imageArr[i];
//        NSLog(@"%@",item.originalUrl);
        [imageView sd_setImageWithURL:[NSURL URLWithString:item.originalUrl]];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(width*self.imageArr.count, height);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentOffset = CGPointMake(width*self.index, 0);
    _label.text = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.imageArr.count];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _label.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imageArr.count];
    
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
