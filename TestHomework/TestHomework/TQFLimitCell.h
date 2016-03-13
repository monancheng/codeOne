//
//  TQFLimitCell.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStarView.h"
#import "LimitModel.h"

typedef NS_ENUM(NSInteger, TQFViewControllertype) {
    TQFViewControllerLimitFree =0,
    TQFViewControllerReduce,
    TQFViewControllerFree,
    TQFViewControllerRank,
    
}  NS_ENUM_AVAILABLE_IOS(6_0);
@interface TQFLimitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet MyStarView *myStarView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadlabel;

//传cell定制
- (void)config:(LimitModel *)model index:(NSInteger)index cutLength:(NSInteger)length TQFViewControllertype:(TQFViewControllertype )type;





@end
