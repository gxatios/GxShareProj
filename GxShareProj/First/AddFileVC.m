//
//  AddFileVC.m
//  GxShareProj
//
//  Created by iOS-iMac on 2018/3/21.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "AddFileVC.h"
#import "Reachability.h"

#import <GCDWebServer/GCDWebServerDataResponse.h>
#import <GCDWebServer/GCDWebUploader.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface AddFileVC () <GCDWebUploaderDelegate>

@property (weak, nonatomic) IBOutlet UILabel *wifiLabel;
@property (weak, nonatomic) IBOutlet UILabel *volLabel;
@property (weak, nonatomic) IBOutlet UILabel *wifiIntroLabel;
@property (weak, nonatomic) IBOutlet UITextView *itunesTextV;

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic,strong) GCDWebUploader  *webUploader;

@end

@implementation AddFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"导入音频";
    // Do any additional setup after loading the view.
    self.volLabel.text = [MethodExt getDivceSize];
    _wifiLabel.text = @"未连接wifi";
    _itunesTextV.text = @"1，将iPhone/iPad与电脑连接，打开iTunes后点击你的设备。\n2,在左侧功能列表选择应用，在右侧\"文件共享\"区域中选中当前app。\n3，点击右下角“添加文件”按钮，选择文件即可共享到iPhone/iPad。";
    [self reachabilityInit];
    [self wifiInit];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_webUploader stop];
    _webUploader = nil;
}
-(void)reachabilityInit{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //Change the host name here to change the server you want to monitor.
    NSString *remoteHostName = @"www.baidu.com";
    NSString *remoteHostLabelFormatString = NSLocalizedString(@"Remote Host: %@", @"Remote host label format string");
    NSString *resultStr = [NSString stringWithFormat:remoteHostLabelFormatString, remoteHostName];
    
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachability:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self updateInterfaceWithReachability:self.internetReachability];
}
- (void) reachabilityChanged:(NSNotification *)note{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}
- (void)updateInterfaceWithReachability:(Reachability *)reachability{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    if (netStatus != ReachableViaWiFi) {
        NSLog(@"当前无wifi连接");
        _wifiLabel.text = @"当前无wifi连接";
    }else{
        _wifiLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@:%i", nil),[self getIPAddress], (int)_webUploader.port];
    }
}
-(void)wifiInit{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
    _webUploader.delegate = self;
    _webUploader.allowHiddenItems = YES;
    if ([_webUploader start]) {
        _wifiLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@:%i", nil),[self getIPAddress], (int)_webUploader.port];
    } else {
        _wifiLabel.text = NSLocalizedString(@"当前无wifi连接!", nil);
    }
}
- (void)webUploader:(GCDWebUploader*)uploader didUploadFileAtPath:(NSString*)path {
    NSLog(@"[UPLOAD] %@", path);
}

- (void)webUploader:(GCDWebUploader*)uploader didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    NSLog(@"[MOVE] %@ -> %@", fromPath, toPath);
}

- (void)webUploader:(GCDWebUploader*)uploader didDeleteItemAtPath:(NSString*)path {
    NSLog(@"[DELETE] %@", path);
}

- (void)webUploader:(GCDWebUploader*)uploader didCreateDirectoryAtPath:(NSString*)path {
    NSLog(@"[CREATE] %@", path);
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
// 获取ip地址
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
@end
