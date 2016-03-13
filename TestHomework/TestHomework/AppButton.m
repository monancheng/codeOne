//
//  AppButton.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/12.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "AppButton.h"

@implementation AppButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self addSubview:self.imageView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
