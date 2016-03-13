//
//  TQFRankViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFRankViewController.h"
#import "LimitModel.h"
#import "TQFLimitCell.h"
@interface TQFRankViewController ()

@end

@implementation TQFRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curPage = 0;
}
//导航
- (void)createMyNavi
{
    [super createMyNavi];
    [self addNavLabelTitle:@"热榜"];
}
//分类
- (void)categoryAction
{
    _cateUrl = kCategoryRankUrl;
    [super categoryAction];
}
//下载
- (void)downloadData
{
//    if (_isLoading == YES) {
//        return;
//    }
//    
//    NSString *urlString = [NSString stringWithFormat:kRankUrl,_curPage];
//    if (_categoryId!=nil) {
//        urlString = [urlString stringByAppendingFormat:@"&category_id=%@",_categoryId];
//    }
    _urlString =kRankUrl;
    [super downloadData];
    
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:_urlString];
    [downloader setDownBlock:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }else if ([result isKindOfClass:[NSDictionary class]])
        {
            if (_curPage ==0) {
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
//刷新代理
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (_isLoading ==YES) {
        return;
    }
    
    if (refreshView ==_footerView) {
        _curPage++;
        [self downloadData];
    }else if (refreshView ==_headerView)
    {
        _curPage=0;
        [self downloadData];
    }
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
    [cell config:model index:indexPath.row cutLength:0 TQFViewControllertype:TQFViewControllerRank];
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
