//
//  AppIntroVC.m
//  GxShareProj
//
//  Created by iOS-iMac on 2018/3/21.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "AppIntroVC.h"

@interface AppIntroVC ()
@property (weak, nonatomic) IBOutlet UITextView *introTextV;

@end

@implementation AppIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _introTextV.text = @"\n1,第一版支持基本的导入、查看、预览功能。\n2,第二版加入文件夹管理、音视频编辑、密码加密文件\n3,第三版加入联网登录、广告区域展示。\n";
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

@end
