//
//  ContactTableViewController.m
//  AdressBookDemo
//
//  Created by admin on 17/1/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ContactTableViewController.h"
#import "ContactModel.h"
#import "AddContactVC.h"

@interface ContactTableViewController ()

@property (strong, nonatomic)NSMutableArray *datalist;

@end

@implementation ContactTableViewController
//懒加载数据源
-(NSMutableArray *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
        if ([ContactModel unarchiverList]) {
            _datalist = [ContactModel unarchiverList];
        }
    }
    return  _datalist;
}

- (IBAction)doCancel:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销？" message:@"真的要注销吗？" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTableViewCell"];
    if (self.datalist.count > 0) {
        ContactModel *contact = self.datalist[indexPath.row];
        cell.textLabel.text = contact.name;
        cell.detailTextLabel.text = contact.mobile;
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.datalist removeObjectAtIndex:indexPath.row];
        //模型数组归档
        [ContactModel archiverWithContactList:self.datalist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AddContactVC *vc = [segue destinationViewController];
    //block传值
    vc.addContactBlock = ^(ContactModel *contact){
        [self.datalist addObject:contact];
        //模型数组归档
        [ContactModel archiverWithContactList:self.datalist];
        [self.tableView reloadData];
    };
}

@end
