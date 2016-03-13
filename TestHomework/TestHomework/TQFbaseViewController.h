//
//  TQFbaseViewController.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/1.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFNavViewController.h"
#import "MJRefresh.h"
#import "TQFdownloader.h"
#import "Const.h"
@class MJRefreshFooterView;
@class MJRefreshHeaderView;
@interface TQFbaseViewController : TQFNavViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,MJRefreshBaseViewDelegate>
{
    //添加表格
    UITableView *_tableView;
    //添加数据源数组
    NSMutableArray *_dataArray;
    //下载的页码
    NSInteger _curPage;
    //searchBar
    UISearchBar *_searchBar;
    //上拉加载更多
    MJRefreshFooterView *_footerView;
    //当前是否正在加载
    BOOL _isLoading;
    //当前下载的urlString
    NSString *_urlString;
    
    //下拉刷新
    MJRefreshHeaderView *_headerView;
    //分类的
    NSString *_cateUrl;
    //categoryId分类的
    NSString *_categoryId;
}

//创建下载
- (void)downloadData;
//结束下载状态
- (void)refreshUI;
//创建表格
- (void)createTableView;
//创建导航
- (void)createMyNavi;
//创建搜索栏
- (void)createSeachBar;
//创建刷新加载更多
- (void)getMoreData;
//分类方法实现
-  (void)categoryAction;
//设置实现
- (void)setAction;

@end
