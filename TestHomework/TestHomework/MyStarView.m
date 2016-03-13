//
//  MyStarView.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "MyStarView.h"
#import "MyUtil.h"
@implementation MyStarView
//xib创建时调用
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createImageView];
    }
    return self;
}
////代码创建时调用
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self createImageView];
//    }
//    return self;
//}
- (void)createImageView
{
    _bgImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 65, 23) imageName:@"StarsBackground"];
    [self addSubview:_bgImageView];
    
    _fgImageView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 65, 23) imageName:@"StarsForeground"];
    //设置停靠模式，减去多余的星
    _fgImageView.contentMode = UIViewContentModeLeft;
    _fgImageView.clipsToBounds = YES;
    [self addSubview:_fgImageView];

}
- (void)setRating:(CGFloat)rating
{
    //修改前景图宽度
    _fgImageView.frame = CGRectMake(0, 0, rating/5.0f*65, 23);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
