//
//  BXMainTableViewController.m
//  boxue-oc
//
//  Created by hui xiang on 2019/1/9.
//  Copyright © 2019 xianghui. All rights reserved.
//

#import "BXMainTableViewController.h"
#import "BXFolderTableViewCell.h"
#import "BXVideoViewController.h"

@interface BXMainTableViewController ()

@property (nonatomic, strong) NSMutableArray *filesArray;

@end

@implementation BXMainTableViewController

- (void)didInitializeWithStyle:(UITableViewStyle)style {
    [super didInitializeWithStyle:style];
    // init 时做的事情请写在这里
    
    
}

- (void)initTableView {
    [super initTableView];
    // 对 self.tableView 的操作写在这里
}

- (void)viewDidLoad {
    self.cellClass = [BXFolderTableViewCell class];
    
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
    if (!self.fileModel) {
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *boxueFilePath = [filePath stringByAppendingPathComponent:@"boxue"];
        self.fileModel = [[BXFileModel alloc] init];
        self.fileModel.filePath = boxueFilePath;
        self.fileModel.isFolder = YES;
        self.fileModel.fileName = @"泊学视频";
    }
    
    
    [self startRefresh];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    
    NSString *title = self.fileModel.fileName;
    if ([title containsString:@"("]) {
        NSArray *titles = [title componentsSeparatedByString:@"("];
        self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
        self.title = titles.firstObject;
        self.titleView.subtitle = [titles.lastObject stringByReplacingOccurrencesOfString:@")" withString:@""];
    }else{
        
        self.title = title;
    }
    
}

#pragma mark - <QMUITableViewDataSource, QMUITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id model = [self.datas objectAtIndex:indexPath.row];
    
    if ([model isKindOfClass:[BXFileModel class]]) {
        BXFileModel *file = model;
        if (file.isFolder) {
            BXMainTableViewController *vc = [[BXMainTableViewController alloc] init];
            vc.fileModel = file;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            NSInteger index = indexPath.row + 1;
            NSInteger index1 = 0;
            if (index%2 == 0) {
                index1 = index - 1;
            }else{
                index1 = index + 1;
            }
            
            BXFileModel *file1 = [self.datas objectAtIndex:index1-1];
            
            BXVideoModel *videoModel = [[BXVideoModel alloc] init];
            if ([file.fileName hasSuffix:@"png"]) {
                videoModel.imgFileName = file.fileName;
                videoModel.imgFilePath = file.filePath;
            }else if ([file.fileName hasSuffix:@"mp4"]) {
                videoModel.videoFileName = file.fileName;
                videoModel.videoFilePath = file.filePath;
            }
            if ([file1.fileName hasSuffix:@"png"]) {
                videoModel.imgFileName = file1.fileName;
                videoModel.imgFilePath = file1.filePath;
            }else if ([file1.fileName hasSuffix:@"mp4"]) {
                videoModel.videoFileName = file1.fileName;
                videoModel.videoFilePath = file1.filePath;
            }
            
            
            BXVideoViewController *vc = [[BXVideoViewController alloc] init];
            vc.videoModel = videoModel;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}


- (void)refreshComplete:(void (^)(NSArray *, NSError *))complete{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    // 获取指定路径对应文件夹下的所有文件
    NSArray <NSString *> *fileArray = [fileManager contentsOfDirectoryAtPath:self.fileModel.filePath error:&error];
    NSArray *sortedArr = [fileArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = obj1;
        NSString *str2 = obj2;
        if ([str1 containsString:@"-"] && [str2 containsString:@"-"]) {
            NSInteger index1 = [[str1 componentsSeparatedByString:@"-"].firstObject integerValue];
            NSInteger index2 = [[str2 componentsSeparatedByString:@"-"].firstObject integerValue];
            return [@(index1) compare:@(index2)];
        }else{
            return [obj1 compare:obj2];
        }
    }];
    
    NSMutableArray *datas = [NSMutableArray array];
    
    BXVideoModel *videoModel = nil;
    
    for (NSString *fileName in sortedArr) {
        if ([fileName containsString:@"DS_Store"]) {
            continue;
        }
        
        BXFileModel *file = [[BXFileModel alloc] init];
        file.fileName = fileName;
        file.filePath = [self.fileModel.filePath stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        [fileManager fileExistsAtPath:file.filePath isDirectory:&isDirectory];
        file.isFolder = isDirectory;
        
        if (!videoModel) {
            videoModel = [[BXVideoModel alloc] init];
        }
        
        if ([file.fileName hasSuffix:@"png"]) {
            
            videoModel.imgFileName = file.fileName;
            videoModel.imgFilePath = file.filePath;
            
            
        }else if ([file.fileName hasSuffix:@"mp4"]) {
            
        }else{
            
        }
        
        [datas addObject:file];
    }
    
    
    if (complete) {
        complete(datas, error);
    }
}

@end
