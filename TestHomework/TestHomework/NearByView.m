//
//  NearByView.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/12.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "NearByView.h"
#import "MyUtil.h"
#import "LimitModel.h"
#import "UIImageView+WebCache.h"
@implementation NearByView
{
    UIImageView *_imagView;
    UILabel *_label;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imagView = [MyUtil createImageViewFrame:CGRectMake(0, 0, 80, 60) imageName:nil];
        [self addSubview:_imagView];
        _label = [MyUtil createLabelFrame:CGRectMake(0, 60, 80, 20) text:nil textAligoment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:18] textColor:[UIColor blackColor]];
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
    return self;
}
- (void)setModel:(LimitModel *)model
{
    _model = model;
    [_imagView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    _label.text = model.name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
