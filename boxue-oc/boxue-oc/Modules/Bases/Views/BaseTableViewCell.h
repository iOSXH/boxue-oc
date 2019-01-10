//
//  BaseTableViewCell.h
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface BaseTableViewCell : QMUITableViewCell


/**
 cell高度

 @return 高度
 */
+ (CGFloat)CellHeight;


/**
 cell复用key

 @return key
 */
+ (NSString *)CellReuseIdentifier;


- (void)updateViewsWithModels:(id)model;

@end
