//
//  TQFFreeViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFFreeViewController.h"
#import "LimitModel.h"
#import "TQFLimitCell.h"
@interface TQFFreeViewController ()

@end

@implementation TQFFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curPage = 1;
}
//导航
- (void)createMyNavi
{
    [super createMyNavi];
    [self addNavLabelTitle:@"免费"];
}
//分类
- (void)categoryAction
{
    _cateUrl= kCategoryFreeUrl;
    [super categoryAction];
}

//下载
- (void)downloadData
{
    _urlString =kFreeUrl;
    [super downloadData];
//    NSString *urlString = [NSString stringWithFormat:kFreeUrl,_curPage];
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:_urlString];
    [downloader setDownBlock:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }else if ([result isKindOfClass:[NSDictionary class]])
        {
            if (_curPage==1) {
                [_dataArray removeAllObjects];
            }
            
            NSArray *array = result[@"applications"];
            for (NSDictionary *dict in array) {
                LimitModel *model = [[LimitModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
        }
    }];
}
//列表
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"limitCellId";
    TQFLimitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TQFLimitCell" owner:nil options:nil]lastObject];
    }
    LimitModel *model =_dataArray[indexPath.row];
    [cell config:model index:indexPath.row cutLength:0 TQFViewControllertype:TQFViewControllerFree];
    return cell;
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
