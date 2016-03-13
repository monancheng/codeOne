//
//  TQFDetailViewController.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/11.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import "TQFNavViewController.h"

@interface TQFDetailViewController : TQFNavViewController
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
- (IBAction)favoriteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
- (IBAction)downAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;
@property (nonatomic,copy)NSString *applicationId;

















@end
