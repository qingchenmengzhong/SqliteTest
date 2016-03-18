//
//  DbDao.h
//  SqliteTest
//
//  Created by foxwang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabaseQueue;
@class UserEntity;
@interface DbDao : NSObject
{
    NSString *dbFile;

    FMDatabaseQueue *dbQueue;
}
@property (nonatomic , copy) NSString *dbFile;
@property (nonatomic, retain)FMDatabaseQueue *dbQueue;

+(DbDao *)sharedInstance;

- (void)addUser:(UserEntity *)user;

- (NSArray *)getUsers;

@end
