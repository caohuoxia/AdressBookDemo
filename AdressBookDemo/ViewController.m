//
//  ViewController.m
//  AdressBookDemo
//
//  Created by admin on 17/1/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ViewController.h"
#import "ContactTableViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfName;

@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UISwitch *switchPwd;

@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@end

@implementation ViewController
- (IBAction)btnLogin:(id)sender {
    if (![self.tfName.text isEqualToString:@"jike"]) {
        NSLog(@"用户名不正确");
        return;
    }
    if (![self.tfPwd.text isEqualToString:@"123"]) {
        NSLog(@"密码不正确");
        return;
    }
    
    //模拟网络请求，登录
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听文本框的输入情况，用户名和密码都没有输入的时候  登录不允许点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.tfName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.tfPwd];
}

- (void)textChange{
    //用户名和密码都非空的时候，登录按钮才可点
    //特别要注意&&  而不是&
    self.btnLogin.enabled = self.tfName.text.length && self.tfPwd.text.length;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ContactTableViewController *vc = [segue destinationViewController];
    vc.title = [NSString stringWithFormat:@"%@的联系人列表", self.tfName.text];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
