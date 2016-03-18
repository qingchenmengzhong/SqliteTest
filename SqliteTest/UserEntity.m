//
//  UserEntity.m
//  SqliteTest
//
//  Created by foxwang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity
@synthesize ID = _id;
@synthesize name;
@synthesize password;

- (void)dealloc
{
    self.name = nil;
    self.password = nil;
    [super dealloc];
}

@end
