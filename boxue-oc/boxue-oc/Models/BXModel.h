//
//  BXModel.h
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BXModel : NSObject

@end

@interface BXFileModel : BXModel

@property(nonatomic, strong) NSString *fileName;
@property(nonatomic, strong) NSString *filePath;
@property(nonatomic, assign) BOOL isFolder;

@property(nonatomic, assign) NSInteger fileIndex;

@end


@interface BXVideoModel : BXFileModel

@property(nonatomic, assign) NSInteger index;

@property(nonatomic, strong) NSString *imgFileName;
@property(nonatomic, strong) NSString *imgFilePath;

@property(nonatomic, strong) NSString *videoFileName;
@property(nonatomic, strong) NSString *videoFilePath;

@end


NS_ASSUME_NONNULL_END
