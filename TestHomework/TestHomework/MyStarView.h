//
//  MyStarView.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/2.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStarView : UIView
{
    //白色背景图片
    UIImageView *_bgImageView;
    //橘色的前景图片
    UIImageView *_fgImageView;
}


//设置星级的方法
- (void)setRating:(CGFloat)rating;
@end
