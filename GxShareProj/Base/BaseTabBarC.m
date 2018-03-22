//
//  BaseTabBarC.m
//  GxShareProj
//
//  Created by iOS-iMac on 2018/3/21.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "BaseTabBarC.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "SettingViewController.h"

@interface BaseTabBarC () <UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation BaseTabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor redColor];
    
    UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FirstViewController *first =  [firstStoryBoard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    UINavigationController *oneNav = [[UINavigationController alloc] initWithRootViewController:first];
    UIStoryboard *twoSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *cardVC = [twoSB instantiateViewControllerWithIdentifier:@"SecondViewController"];
    UINavigationController *twodNav = [[UINavigationController alloc] initWithRootViewController:cardVC];
    
    UIStoryboard *threeSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingViewController *threeVC = [threeSB instantiateViewControllerWithIdentifier:@"SettingViewController"];
    UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:threeVC];
    
    oneNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"文档" image:[UIImage imageNamed:@"t_b"] tag:0];
    oneNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"t_r"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    twodNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"音视频" image:[UIImage imageNamed:@"v_b"] tag:1];
    twodNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"v_r"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    threeNav.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"其它" image:[UIImage imageNamed:@"s_b"] tag:2];
    threeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"s_r"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    self.tabBar.tintColor = [UIColor colorWithRed:180/255.0 green:36/255.0 blue:25/255.0 alpha:1];
    self.viewControllers = @[oneNav, twodNav, threeNav];
    self.delegate = self;
    
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
