//
//  TQFbaseViewController.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFbaseViewController.h"
#import "TQFCategoryViewController.h"
#import "TQFDetailViewController.h"
#import "LimitModel.h"
@interface TQFbaseViewController ()

@end

@implementation TQFbaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc]init];
    _curPage = 1;
    [self downloadData];
    [self createTableView];
    [self createMyNavi];
    [self createSeachBar];
    [self getMoreData];
}
#pragma mark===上下拉动加载更多数据
- (void)getMoreData
{
    _footerView = [MJRefreshFooterView footer];
    _footerView.delegate = self;
    _footerView.scrollView =_tableView;
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.delegate = self;
    _headerView.scrollView =_tableView;
    
}
- (void)dealloc
{
    _footerView.scrollView = nil;
    _headerView.scrollView = nil;
}
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
        _curPage=1;
        [self downloadData];
    }
}
#pragma mark ==UITabelView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view  addSubview:_tableView];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"这个方法必须实现：%s",__FUNCTION__);
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQFDetailViewController *detail = [[TQFDetailViewController alloc]init];
    LimitModel *model = _dataArray[indexPath.row];
    detail.applicationId = model.applicationId;
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma  mark===导航
- (void)createMyNavi
{
//    [self addNavLabelTitle:@"限免"];
    [self addNaviButton:@"分类" bgImageName:@"buttonbar_action" target:self action:@selector(categoryAction) isLeft:YES];
    [self addNaviButton:@"设置" bgImageName:@"buttonbar_action" target:self action:@selector(setAction) isLeft:NO];
}
-  (void)categoryAction
{
    TQFCategoryViewController *cate = [[TQFCategoryViewController alloc]init];
    UILabel *label = (UILabel *)self.navigationItem.titleView;
    cate.name =label.text;
    cate.cateUrlString = _cateUrl;
    [cate setCategoryBlock:^(NSString *categoryId, NSString *name) {
        UILabel *label = (UILabel *)self.navigationItem.titleView;
        NSString *str = [label.text substringToIndex:2];
        label.text = [NSString stringWithFormat:@"%@-%@",str,name];
        _categoryId = categoryId;
        _curPage = 1;
        if ([str isEqualToString:@"热榜"]) {
            _curPage = 0;
        }
        [self downloadData];
    }];
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:cate animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)setAction
{
    NSLog(@"设置");
}
#pragma mark===seachBar
- (void)createSeachBar
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 0, 355, 44)];
    _searchBar.delegate =self;
    _searchBar.barStyle = UIBarStyleDefault;
    _tableView.tableHeaderView =_searchBar;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //显示取消按钮
    
    searchBar.showsCancelButton = YES;
    UIView *superview = [searchBar.subviews lastObject];
    for (UIView *subView in superview.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *button = (UIButton *)subView;
            [button setTitle:@"取消" forState:UIControlStateNormal];
            UIColor *color = [UIColor colorWithRed:80/255.0 green:160/255.0  blue:200/255.0  alpha:1];
            [button setTitleColor:color forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
        }
    }
}
#pragma mark ===下载
- (void)downloadData
{
    if (_isLoading ==YES) {
        return;
    }
    
    if ([_urlString isEqualToString:kRankUrl]) {
        _curPage = 0;
    }
    _urlString = [NSString stringWithFormat:_urlString,_curPage];
    if (_categoryId!=nil) {
        _urlString = [NSString stringWithFormat:@"%@&category_id=%@",_urlString,_categoryId];
    }
    
    
}
- (void)refreshUI
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];
    _isLoading = NO;
    [_tableView reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    searchBar.text = @"";
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
