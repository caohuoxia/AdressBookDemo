//
//  AddContactVC.h
//  AdressBookDemo
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactModel.h"

typedef void(^AddContactBlock)(ContactModel *contact);

@interface AddContactVC : UIViewController
@property (nonatomic, copy)AddContactBlock addContactBlock;

@end
