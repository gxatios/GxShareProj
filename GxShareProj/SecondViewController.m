//
//  SecondViewController.m
//  GxShareProj
//
//  Created by pro2013 on 2018/2/5.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "SecondViewController.h"
#import "DirectoryWatcher.h"
#import "AddFileVC.h"
#import <QuickLook/QuickLook.h>

@interface SecondViewController ()<UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *listTV;
@property(nonatomic,retain) NSMutableArray *dirArray;
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音视频";
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    addBtn.frame = CGRectMake(0, 30, 40, 35);
    [addBtn addTarget:self action:@selector(upBtnDown) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];

    [[DirectoryWatcher defaultWatcher] startMonitoringDocumentAsynchronous];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileChanageAction:) name:ZFileChangedNotification object:nil];
    self.dirArray = [[NSMutableArray alloc] init];

     [self getFileInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getFileInfo];
}
-(void)upBtnDown{
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"First" bundle:nil];
    AddFileVC *addVC =  [firstStoryBoard instantiateViewControllerWithIdentifier:@"AddFileVC"];
    addVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addVC animated:YES];
}

-(NSString *)ducoFileStr{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentPaths objectAtIndex:0];
    return documentsDirectory;
}
-(void)getFileInfo{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:[self ducoFileStr] error:&error];
    [self.dirArray removeAllObjects];
    for (NSString *file in fileList){
        if ([file containsString:@".mp3"]||[file containsString:@".wav"]||[file containsString:@".rm"]||[file containsString:@".ape"]||[file containsString:@".midi"]||[file containsString:@".wma"]||[file containsString:@".ape"]||[file containsString:@".wmv"]||[file containsString:@".rmvb"]||[file containsString:@".3gp"]||[file containsString:@".mov"]||[file containsString:@".mp4"]||[file containsString:@".m4v"]||[file containsString:@".avi"]||[file containsString:@".mkv"]||[file containsString:@".flv"]) {
            [self.dirArray addObject:file];
        }
    }
    [_listTV reloadData];
}
- (void)setupDocumentControllerWithURL:(NSURL *)url{
    if (self.docInteractionController == nil){
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }else{
        self.docInteractionController.URL = url;
    }
}
#pragma mark- 列表操作
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellName = @"CellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSURL *fileURL= nil;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:indexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    
    [self setupDocumentControllerWithURL:fileURL];
    cell.textLabel.text = [self.dirArray objectAtIndex:indexPath.row];
    NSInteger iconCount = [self.docInteractionController.icons count];
    if (iconCount > 0)
    {
        cell.imageView.image = [self.docInteractionController.icons objectAtIndex:iconCount - 1];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dirArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    previewController.dataSource = self;
    previewController.delegate = self;
    
    // start previewing the document at the current section index
    previewController.currentPreviewItemIndex = indexPath.row;
    previewController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:previewController animated:YES];
    //  [self presentViewController:previewController animated:YES completion:nil];
}

// right gest
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *shareRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"分享" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSURL *fileURL= nil;
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [documentPaths objectAtIndex:0];
        NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:indexPath.row]];
        fileURL = [NSURL fileURLWithPath:path];
        UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
        [documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }];
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        // 删除操作
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否确认删除?"
                                                                                 message:@"删除后不能恢复"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self deleteItemAt:indexPath];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    return @[deleteRoWAction,shareRowAction];
}
-(void)deleteItemAt:(NSIndexPath *)indexPath{
    NSError *removeError;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];//找到 Documents 目录
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[self.dirArray objectAtIndex:indexPath.row]];
    if ([fileManager removeItemAtPath:path error:&removeError]) {
        NSLog(@"remove success");
//        [self getFileInfo];
    }else{
        NSLog(@"%@",removeError.description);
    }
}


#pragma mark - UIDocumentInteractionControllerDelegate

- (NSString *)applicationDocumentsDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return self;
}

#pragma mark - QLPreviewControllerDataSource

// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 1;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    // if the preview dismissed (done button touched), use this method to post-process previews
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    NSURL *fileURL = nil;
    NSIndexPath *selectedIndexPath = [_listTV indexPathForSelectedRow];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:selectedIndexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    return fileURL;
}
- (void)dealloc
{
    // 取消监听Document目录的文件改动
    [[DirectoryWatcher defaultWatcher] stopMonitoringDocument];
    [[NSNotificationCenter defaultCenter] removeObserver:ZFileChangedNotification];
}

- (void)fileChanageAction:(NSNotification *)notification
{
    // ZFileChangedNotification 通知是在子线程中发出的, 因此通知关联的方法会在子线程中执行
    NSLog(@"文件发生了改变, %@", [NSThread currentThread]);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSError *error;
    // 获取指定路径对应文件夹下的所有文件
    NSArray <NSString *> *fileArray = [fileManager contentsOfDirectoryAtPath:filePath error:&error];
    NSLog(@"%@", fileArray);
}
@end
