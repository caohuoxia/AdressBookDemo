//
//  ContactModel.h
//  AdressBookDemo
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject<NSCoding>
@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *mobile;
-(void)archiverWithContactModel:(ContactModel *)contact;
+(ContactModel *)unarchiver;

+ (void)archiverWithContactList:(NSMutableArray *)contacts;
+ (NSMutableArray *)unarchiverList;
@end
