//
//  myUtil.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyUtil : NSObject
+ (UILabel *)createLabelFrame:(CGRect)frame text:(NSString *)text textAligoment:(NSTextAlignment)textAligoment font:(UIFont *)font textColor:(UIColor *)color;

+ (UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title bgImageName:(NSString *)bgImageName imageName:(NSString *)imageName target:(id)target action:(SEL)action;
+ (UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName;
+ (NSString *)transferCateName:(NSString *)name;
@end
