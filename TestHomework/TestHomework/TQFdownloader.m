//
//  TQFdownloader.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/3.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFdownloader.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSString+MD5.h"
@implementation TQFdownloader
{
    NSString *_urlString;
}
- (void)downloadDateBack:(NSString *)urlString
{
//    NSString *urlString = [NSString stringWithFormat:kLimitUrl,_curPage];
    AFHTTPRequestOperationManager *mananger = [[AFHTTPRequestOperationManager alloc]init];
    mananger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json",nil];
    [mananger GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [self sendData:responseObject];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [self sendData:error];
        
    }];
}
- (void)sendData:(id)data
{
    self.downBlock(data);
}
- (BOOL)isFileCached:(NSString *)urlString timeOut:(NSInteger)seconds
{
    
    NSString *path = [self pathOfUrlString:urlString];
    NSFileManager *fm =[NSFileManager defaultManager];
    BOOL flag = [fm fileExistsAtPath:path];
    //判断是否过期
    //24*60*60
    NSDate *date = [NSDate date];
    //创建文件的时间
    NSDictionary *dict = [fm attributesOfItemAtPath:path error:nil];
    NSDate *createDate = dict [NSFileCreationDate];
    //时间差
    NSTimeInterval minusTime = [date timeIntervalSinceDate:createDate];
    BOOL isTimeOut = minusTime>seconds;
    
    return flag&&isTimeOut;
}
//下载回来的路径
- (NSString *)pathOfUrlString:(NSString *)urlString
{
    //文件名加密
    //MD5加密【通过一个算法是将一个字符串转化为另一个字符串】
    NSString *fleName = [urlString MD5Hash];
    NSString *path =[NSHomeDirectory()stringByAppendingFormat:@"/Library/Caches/%@",fleName];
    return path;
}

- (void)downloadWithUrlString:(NSString *)urlString
{
    _urlString = urlString;
    //判断本地文件时候有缓存
    BOOL isChached = [self isFileCached:urlString timeOut:24*60*60];
    if (isChached) {
        NSString *path = [self pathOfUrlString:urlString];
        //如果有本地文件不做网络请求
    
        //延时调用
        [self performSelector:@selector(finish) withObject:nil afterDelay:0.001];
        
        return;
    }
    
}

@end
