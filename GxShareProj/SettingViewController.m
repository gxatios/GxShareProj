//
//  SettingViewController.m
//  GxShareProj
//
//  Created by pro2013 on 2018/2/5.
//  Copyright © 2018年 Gx. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutVC.h"
#import "AppIntroVC.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTV;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"其它";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (indexPath.row == 0) {
        cell.textLabel.text = @"使用简介";
    }else{
        cell.textLabel.text = @"联系我";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
        AppIntroVC *addVC =  [firstStoryBoard instantiateViewControllerWithIdentifier:@"AppIntroVC"];
        addVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        UIStoryboard *firstStoryBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
        AboutVC *addVC =  [firstStoryBoard instantiateViewControllerWithIdentifier:@"AboutVC"];
        addVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addVC animated:YES];
        
    }
}


@end
