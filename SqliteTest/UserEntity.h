//
//  UserEntity.h
//  SqliteTest
//
//  Created by foxwang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserEntity : NSObject
{
    int _id;
    NSString *name;
    NSString *password;
}

@property (nonatomic, assign)int ID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *password;
@end
