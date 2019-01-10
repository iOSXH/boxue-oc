//
//  BaseTableViewCell.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)didInitializeWithStyle:(UITableViewCellStyle)style {
    [super didInitializeWithStyle:style];
    // init 时做的事情请写在这里
}

- (void)updateCellAppearanceWithIndexPath:(NSIndexPath *)indexPath {
    [super updateCellAppearanceWithIndexPath:indexPath];
    // 每次 cellForRow 时都要做的事情请写在这里
}

- (void)layoutSubviews {
    [super layoutSubviews];
}



+ (CGFloat)CellHeight{
    return 0.0;
}

+ (NSString *)CellReuseIdentifier{
    return [NSStringFromClass(self) stringByAppendingString:@"_CellReuseIdentifier"];
}

- (void)updateViewsWithModels:(id)model{
    
}

@end
