//
//  AboutVC.m
//  GxShareProj
//
//  Created by iOS-iMac on 2018/3/21.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()
@property (weak, nonatomic) IBOutlet UITextView *showTextV;

@end

@implementation AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _showTextV.text = @"大家好,有想要的功能,或反馈问题,或有争议内容等要联系作者,请发邮件到xzgx@163.com联系,谢谢!";
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
