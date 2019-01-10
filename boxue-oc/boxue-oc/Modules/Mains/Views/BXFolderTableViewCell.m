//
//  BXFolderTableViewCell.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "BXFolderTableViewCell.h"

@implementation BXFolderTableViewCell

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
    return 50.0;
}



- (void)updateViewsWithModels:(id)model{
    if ([model isKindOfClass:[BXFileModel class]]) {
        
        BXFileModel *file = model;
        
        self.textLabel.text = file.fileName;
        
        self.accessoryType = file.isFolder?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryDetailButton;
        
        self.imageView.image = UIImageMake(file.isFolder?@"icon_folder":@"icon_file");
        
    }else if ([model isKindOfClass:[BXVideoModel class]]){
        
        BXVideoModel *video = model;
        
        self.textLabel.text = [video.imgFileName stringByAppendingFormat:@"(%@)", video.videoFileName];
        
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        
        self.imageView.image = UIImageMake(@"icon_file");
    }
    
}

@end
