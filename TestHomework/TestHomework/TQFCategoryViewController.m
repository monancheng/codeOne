//
//  TQFCategoryViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/3.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFCategoryViewController.h"
#import "CategoryItem.h"
#import "MyUtil.h"
@interface TQFCategoryViewController ()

@end

@implementation TQFCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)createMyNavi
{
    NSString *name = [self.name substringToIndex:2];
    [self addNavLabelTitle:[NSString stringWithFormat:@"%@-分类",name]];
    [self addNaviButton:@"返回" bgImageName:@"buttonbar_action" target:self action:@selector(backAction) isLeft:YES];
}

- (void)downloadData
{
    TQFdownloader *downloader = [[TQFdownloader alloc]init];
    [downloader downloadDateBack:self.cateUrlString];
    [downloader setDownBlock:^(id result) {
        if ([result isKindOfClass:[NSError class]]) {
            NSLog(@"%@",result);
        }else if ([result isKindOfClass:[NSDictionary class]])
        {
            if (_curPage ==0) {
                [_dataArray removeAllObjects];
            }
            
            NSArray *array = result[@"category"];
            for (NSDictionary *dict in array) {
                CategoryItem *model = [[CategoryItem alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [_dataArray addObject:model];
            }
            [_dataArray removeObjectAtIndex:0];
            [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
        }
    }];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark====UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    CategoryItem *model = _dataArray[indexPath.row];
    cell.textLabel.text = [MyUtil transferCateName:model.categoryName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@款应用,其中限免%@款",model.lessenPrice,model.count];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"category_%@.jpg",model.categoryName]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItem *model = _dataArray[indexPath.row];
    NSString *name = [MyUtil transferCateName:model.categoryName];
    self.categoryBlock(model.categoryId,name);
    [self.navigationController popViewControllerAnimated:YES];
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
