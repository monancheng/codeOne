//
//  TQFdownloader.h
//  TestHomework
//
//  Created by 陌南城 on 16/3/3.
//  Copyright © 2016年 陌南城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQFdownloader : NSObject

@property(nonatomic,copy)void(^downBlock)(id result);

- (void)downloadDateBack:(NSString *)urlString;

@end
