//
//  BXModel.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "BXModel.h"

@implementation BXModel

@end


@implementation BXFileModel

- (NSInteger)fileIndex{
    
    NSInteger index = [[self.fileName componentsSeparatedByString:@"-"].firstObject integerValue];
    
    return index;
}

@end

@implementation BXVideoModel

@end
