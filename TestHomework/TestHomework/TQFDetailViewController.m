//
//  TQFDetailViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/11.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFDetailViewController.h"
#import "Const.h"
#import "TQFdownloader.h"
#import "DetailItem.h"
#import "LimitModel.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"
#import "AppButton.h"
#import "NearByView.h"
#import "TQFPicViewController.h"
@interface TQFDetailViewController ()
{
    DetailItem *_model;
    //
    
}
@end

@implementation TQFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createMyNavi];
    [self downloadData];
}
- (void)createMyNavi
{
    [self addNavLabelTitle:@"应用详情"];
    [self addNaviButton:@"返回" bgImageName:@"buttonbar_back" target:self action:@selector(backAction) isLeft:YES];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)downloadData
{
    [self downloadTopViewData];
    [self downloadnearByData];
}
- (void)downloadnearByData
{
    NSString *urlString = [NSString stringWithFormat:kNearByUrl];
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:urlString];
    NSMutableArray *nearByArr= [NSMutableArray new];
    [downloader setDownBlock:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }
        else if ([result isKindOfClass:[NSDictionary class]])
        {
            NSArray *array = result[@"applications"];
            for (NSDictionary *dict in array) {
                LimitModel *model = [[LimitModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [nearByArr addObject:model];
            }
            [self showNearByUI:nearByArr];
        }
        
    }];
}
- (void)showNearByUI:(NSArray *)array;
{
    for (int i = 0; i<array.count; i++) {
        LimitModel *model = array[i];
        NearByView *near = [[NearByView alloc]initWithFrame:CGRectMake((80+10)*i, 0, 80, 80)];
        near.model = model;
        
        //添加手势
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGest:)];
        [near addGestureRecognizer:tapGest];
        
        [self.bottomScrollView addSubview:near];
    }
    self.bottomScrollView.contentSize = CGSizeMake(80*array.count, 80);
}


- (void)downloadTopViewData
{
    NSString *urlString = [NSString stringWithFormat:kDetailUrl,self.applicationId];
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:urlString];
//    NSLog(@"%@",urlString);
    [downloader setDownBlock:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }
        else if([result isKindOfClass:[NSDictionary class]])
        {
            _model = [[DetailItem alloc]init];
            [_model setValuesForKeysWithDictionary:result];
            NSMutableArray *imaArr = [NSMutableArray new];
            for (NSDictionary *phDict in result[@"photos"]) {
                PhotoItem *item = [[PhotoItem alloc]init];
                [item setValuesForKeysWithDictionary:phDict];
                [imaArr addObject:item];
            }
            _model.photoArray = imaArr;
            [self performSelectorOnMainThread:@selector(showDetailsAtTopUI) withObject:nil waitUntilDone:NO];
        }
        
    }];
}

- (void)showDetailsAtTopUI
{
    //左边图片
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl]];
    //标题
    self.nameLabel.text = _model.name;
    //价格
    self.priceLabel.text = [NSString stringWithFormat:@"原价：%@",_model.lastPrice];
    self.priceLabel.adjustsFontSizeToFitWidth=YES;
    //限免
    if ([_model.priceTrend isEqualToString:@"limited"]) {
        self.freeLabel.text = @"限免中";
    }
    else
    {
        self.freeLabel.text = _model.lastPrice;
    }
    self.freeLabel.adjustsFontSizeToFitWidth = YES;
    //大小
    self.sizeLabel.text = [NSString stringWithFormat:@"%@MB",_model.fileSize];
    self.sizeLabel.adjustsFontSizeToFitWidth = YES;
    //类型
    self.categoryLabel.text = [NSString stringWithFormat:@"类型：%@",[MyUtil transferCateName:_model.categoryName]];
    self.categoryLabel.adjustsFontSizeToFitWidth = YES;
    //星级
    self.starLabel.text = [NSString stringWithFormat:@"评分:%@星",_model.starCurrent];
    self.starLabel.adjustsFontSizeToFitWidth = YES;
    //图片
    for (int i = 0; i<_model.photoArray.count; i++) {
        PhotoItem *item = _model.photoArray[i];
        AppButton *appBtn = [[AppButton alloc]initWithFrame:CGRectMake((10+80)*i, 0, 80, 80)];
        [appBtn.imageView sd_setImageWithURL:[NSURL URLWithString:item.smallUrl]];
        appBtn.tag = 100+i;
        [appBtn addTarget:self action:@selector(showPhotoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:appBtn];
    }
    self.topScrollView.contentSize = CGSizeMake(80*_model.photoArray.count,80);
    //描述
    self.descLabel.text= _model.myDescription;
    
}
- (void)showPhotoDetail:(AppButton *)button
{
    NSInteger index = button.tag-100;
    TQFPicViewController *picCtrl = [[TQFPicViewController alloc]init];
    picCtrl.index = index;
    picCtrl.imageArr = _model.photoArray;
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:picCtrl animated:YES completion:nil];
}


- (void)tapGest:(UITapGestureRecognizer *)tap
{
    NearByView *near = (NearByView *)tap.view;
    TQFDetailViewController *detail = [[TQFDetailViewController alloc]init];
    detail.applicationId = near.model.applicationId;
    [self.navigationController pushViewController:detail animated:YES];
    
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

- (IBAction)shareAction:(id)sender {
}
- (IBAction)favoriteAction:(id)sender {
}
- (IBAction)downAction:(id)sender {
}
@end
