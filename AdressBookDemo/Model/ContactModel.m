//
//  ContactModel.m
//  AdressBookDemo
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ContactModel.h"

//文件路径
#define  FilePath [NSHomeDirectory() stringByAppendingPathComponent:@"contact.txt"]

static NSString *name = @"name";
static NSString *mobile = @"mobile";

@implementation ContactModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:name];
        _mobile = [aDecoder decodeObjectForKey:mobile];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:name];
    [aCoder encodeObject:_mobile forKey:mobile];
}

#pragma mark  --复杂对象写入文件
- (void)archiverWithContactModel:(ContactModel *)contact{
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3:开始归档
    [archiver encodeObject:contact forKey:@"contact"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:FilePath atomically:YES];
    if (result) {
        NSLog(@"归档成功:%@",FilePath);
    }else
    {
        NSLog(@"归档不成功!!!");
    }
}

#pragma mark ---  反归档/反序列化/解码/解档 ----
+ (ContactModel *)unarchiver{
    NSData *myData = [NSData dataWithContentsOfFile:FilePath];
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    //反归档
    ContactModel *contact = [ContactModel new];
    contact = [unarchiver decodeObjectForKey:@"contact"];
    //完成反归档
    [unarchiver finishDecoding];

    return contact;
}

#pragma mark  --复杂对象数组写入文件
+ (void)archiverWithContactList:(NSMutableArray *)contacts{
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3:开始归档
    [archiver encodeObject:contacts forKey:@"contact"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:FilePath atomically:YES];
    if (result) {
        NSLog(@"归档成功:%@",FilePath);
    }else
    {
        NSLog(@"归档不成功!!!");
    }
}

#pragma mark ---  反归档/反序列化/解码/解档 ----
+ (NSMutableArray *)unarchiverList{
    NSData *myData = [NSData dataWithContentsOfFile:FilePath];
    if (!myData) {
        return nil;
    }
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    //反归档
    NSMutableArray *contacts = [NSMutableArray array];
    contacts = [unarchiver decodeObjectForKey:@"contact"];
    //完成反归档
    [unarchiver finishDecoding];
    
    return contacts;
}

@end
