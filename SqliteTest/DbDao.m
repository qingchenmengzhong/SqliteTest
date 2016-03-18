//
//  DbDao.m
//  SqliteTest
//
//  Created by foxwang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DbDao.h"
#import "DbFileManager.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"
#import "UserEntity.h"

static DbDao *gSharedInstance = nil;

@implementation DbDao
@synthesize dbFile;
@synthesize dbQueue;

+(DbDao *)sharedInstance
{
    @synchronized(self)
    {
        if (gSharedInstance == nil)
			gSharedInstance = [[DbDao alloc] init];
    }
    return gSharedInstance;	
}

- (void)dealloc
{
    [self.dbFile release];
    self.dbQueue = nil;
    [super dealloc];
}

- (id)init
{
    
    self = [super init];
    if (self)
    {
        self.dbFile = [DbFileManager dbFilePath];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbFile];
        
        
    }
    return  self;
}


- (UserEntity *)rsToUser:(FMResultSet*)rs
{
    UserEntity *user = [[[UserEntity alloc] init] autorelease];
    user.ID = [rs intForColumn:@"_id"];
    user.name = [rs stringForColumn:@"name"];
    user.password = [rs  stringForColumn:@"password"];
    return user;
}

- (void)addUser:(UserEntity *)user
{
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db open];
        NSString *sql = @"insert into tbl_user(name, password) values (?, ?)";
        [db executeUpdate:sql,user.name, user.password];
        [db close];
    }];  
}

- (NSArray *)getUsers;
{
    __block NSMutableArray *users = [[[NSMutableArray alloc] init] autorelease];  
    [self.dbQueue inDatabase:^(FMDatabase *db)   {
        [db open];
        NSString *sql = @"select * from tbl_user ";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next])
        {
            [users addObject:[self rsToUser :rs]]; 
        }
        [db close];
    }];
    return users;
}
@end
