//
//  WHDBManager.m
//  WeixinHistory
//
//  Created by XCC on 12/1/13.
//  Copyright (c) 2013 XCC. All rights reserved.
//

#import "WHDBManager.h"
#import "WHSearch.h"
#import "WHContact.h"
#import "WHConversation.h"

static NSString *__dbpath = nil;

@interface WHDBManager ()

@property (nonatomic, copy) NSString *dbPath;
@property (nonatomic, strong) FMDatabase *database;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *conversations;
@end


@implementation WHDBManager

+ (id)defaultManager
{
    static WHDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WHDBManager alloc] initWithDBPath:__dbpath];
    });
    return manager;
}

+ (void)setDBPath:(NSString *)path
{
    __dbpath = [path copy];
}

- (id)initWithDBPath:(NSString *)path
{
    self = [super init];
    if (self)
    {
        _dbPath = [path copy];
        _database = [[FMDatabase alloc] initWithPath:path];
        [_database open];
        
        [self queryAllFriends];
        [self queryAllConversation];
    }
    return self;
}

- (void)queryAllFriends
{
    NSMutableArray *array = [NSMutableArray array];
    FMResultSet *set = [self.database executeQuery:@"select * from Friend_Ext, Friend where Friend_Ext.UsrName = Friend.UsrName"];
    do {
        BOOL rc = [set next];
        if (rc)
        {
            WHContact *contact = [[WHContact alloc] initWithDictionary:set.resultDictionary];

            [array addObject:contact];
        }
    } while ([set hasAnotherRow]);
    
    self.contacts = array;

}

- (void)queryAllConversation
{
    NSMutableArray *conversationIds = [NSMutableArray array];
    FMResultSet *set = [self.database executeQuery:@"select * from sqlite_sequence"];
    do {
        BOOL rc = [set next];
        if (rc)
        {
            NSString *candidateName = set.resultDictionary[@"name"];
            if ([candidateName hasPrefix:@"Chat_"])
            {
                [conversationIds addObject:candidateName];
            }
        }
    } while ([set hasAnotherRow]);
    
    for (NSString *conName in conversationIds)
    {
        FMResultSet *conversationSet = [self.database executeQuery:[NSString stringWithFormat:@"select * from %@ order by MesLocalID", conName]];
        WHConversation *con = [WHConversation conversationWithResult:conversationSet];
        
    }
    
    NSLog(@"%@", conversationIds);
}

@end
