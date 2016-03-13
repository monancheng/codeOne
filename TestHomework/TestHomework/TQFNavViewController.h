//
//  TQFNavViewController.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQFNavViewController : UIViewController
//标题名字
- (void)addNavLabelTitle:(NSString *)title;
//导航左右按钮
- (void)addNaviButton:(NSString *)title bgImageName:(NSString *)bgImageName target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;
@end
