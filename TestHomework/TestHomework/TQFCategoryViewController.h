//
//  TQFCategoryViewController.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/3.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFbaseViewController.h"

@interface TQFCategoryViewController : TQFbaseViewController
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *cateUrlString;
@property(nonatomic,copy)void (^categoryBlock)(NSString *categoryId,NSString *name);
@end
