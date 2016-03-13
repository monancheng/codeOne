//
//  TQFReduceViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFReduceViewController.h"
#import "LimitModel.h"
#import "TQFLimitCell.h"

@interface TQFReduceViewController ()

@end

@implementation TQFReduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _curPage = 1;
}
- (void)createMyNavi
{
    [super createMyNavi];
    [self addNavLabelTitle:@"降价"];
}
- (void)categoryAction
{
    _cateUrl =kCategoryRankUrl;
    [super categoryAction];
}
#pragma mark=====下载数据
- (void)downloadData
{
    _urlString =kReduceUrl;
    [super downloadData];
//    NSString *urlString = [NSString stringWithFormat:kReduceUrl,_curPage];
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:_urlString];
    downloader.downBlock = ^(id result){
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }else if([result isKindOfClass:[NSDictionary class]])
        {
            
            //如果是下拉刷新，需要删除之前的数据
            if (_curPage ==1) {
                [_dataArray removeAllObjects];
            }
            NSDictionary *dict = result;
            NSArray *array = dict[@"applications"];
            for (NSDictionary *dicts in array) {
                LimitModel *model = [[LimitModel alloc]init];
                [model setValuesForKeysWithDictionary:dicts];
                [_dataArray addObject:model];
            }
            [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
        }
    };
}
#pragma mark=== UITableView代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"limitCellId";
    TQFLimitCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TQFLimitCell" owner:nil options:nil]lastObject];
        
    }
    LimitModel *model = _dataArray[indexPath.row];
    [cell config:model index:indexPath.row cutLength:0 TQFViewControllertype:TQFViewControllerReduce];
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
