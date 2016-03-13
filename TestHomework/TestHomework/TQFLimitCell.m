//
//  TQFLimitCell.m
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFLimitCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"
@implementation TQFLimitCell
- (void)config:(LimitModel *)model index:(NSInteger)index cutLength:(NSInteger)length TQFViewControllertype:(TQFViewControllertype )type
{
    //背景图片
    if (index%2==0) {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg1"];
    }else
    {
        self.bgImageView.image = [UIImage imageNamed:@"cate_list_bg2"];
    }
    //图片
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    //名字
    self.nameLabel.text = [NSString stringWithFormat:@"%ld.%@",index+1,model.name];
    
    //时间
    NSString *time = [self timeLabelText:model cutLenth:length TQFViewControllertype:type];
    self.timeLabel.text = time;
    
    //价格
    NSString *price = [NSString stringWithFormat:@"￥：%@",model.lastPrice];
    NSDictionary *dict = @{NSStrikethroughStyleAttributeName:@1};
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:price attributes:dict];
    
    self.priceLabel.attributedText = string;
    
    //星级
    [self.myStarView setRating:model.starCurrent.floatValue];
    //类型
    self.categoryLabel.text = [MyUtil transferCateName:model.categoryName];
    //分享
    self.shareLabel.text = [NSString stringWithFormat:@"分享%@次",model.shares];
    //收藏
    self.favoriteLabel.text = [NSString stringWithFormat:@"收藏%@次",model.favorites];
    //下载
    self.downloadlabel.text = [NSString stringWithFormat:@"下载%@次",model.downloads];
    
}
- (NSString *)timeLabelText:(LimitModel *)model cutLenth:(NSInteger)length TQFViewControllertype:(TQFViewControllertype )type
{
    NSString *text = nil;
    switch (type) {
        case 0:
        {
            //时间
            NSString *dateStr = [model.expireDatetime substringToIndex:model.expireDatetime.length -length];
            NSDateFormatter *dateFmat = [[NSDateFormatter alloc]init];
            [dateFmat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFmat dateFromString:dateStr];
            
            //就算时间差
            NSCalendar *cale = [NSCalendar currentCalendar];
            
            unsigned int unit = NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDateComponents *dc = [cale components:unit fromDate:[NSDate date] toDate:date options:0];
            text =  [NSMutableString stringWithFormat:@"剩余%02ld：%02ld：%02ld",[dc hour],[dc minute],[dc second]];
        }
            break;
        case 1:
        {
            text = [NSString stringWithFormat:@"现价：%@",model.currentPrice];
        }
            break;
        case 2:
        {
            text = [NSString stringWithFormat:@"评分：%.01f",model.starCurrent.floatValue];
        }
            break;
        case 3:
        {
            self.priceLabel.attributedText = nil;
            self.priceLabel.text = [NSString stringWithFormat:@"￥：%@",model.currentPrice];
            text = [NSString stringWithFormat:@"评分：%.01f",model.starCurrent.floatValue];
        }
            break;
        default:
            break;
    }
    return text;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
