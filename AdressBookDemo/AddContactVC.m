//
//  AddContactVC.m
//  AdressBookDemo
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AddContactVC.h"


@interface AddContactVC ()
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfMobile;

@end

@implementation AddContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听文本框的输入情况，用户名和密码都没有输入的时候  登录不允许点击
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.tfName];
    //object为空的情况下，默认是给所有的textfield都添加了观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)textChange{
    self.btnSave.enabled =  self.tfMobile.text.length && self.tfName.text.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加联系人信息
- (IBAction)saveContact:(id)sender {
    ContactModel *contact = [[ContactModel alloc]init];
    contact.name = self.tfName.text;
    contact.mobile = self.tfMobile.text;
    
    if (self.addContactBlock) {
        self.addContactBlock(contact);
    }
    [self.navigationController popViewControllerAnimated:YES];
//    //归档
//    [contact archiverWithContactModel:contact];
//    
//    [ContactModel unarchiver];
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
