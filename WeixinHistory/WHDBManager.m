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
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *conversations;
@property (nonatomic, strong) FMDatabaseQueue *dbq;
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
        
        self.dbq = [FMDatabaseQueue databaseQueueWithPath:path];
        
        [self queryAllFriends];
        [self queryAllConversation];
    }
    return self;
}

- (void)queryAllFriends
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.dbq inDatabase:^(FMDatabase *db)
     {
         FMResultSet *set = [db executeQuery:@"select * from Friend_Ext, Friend where Friend_Ext.UsrName = Friend.UsrName"];
         do {
             BOOL rc = [set next];
             if (rc)
             {
                 WHContact *contact = [[WHContact alloc] initWithDictionary:set.resultDictionary];
                 
                 [array addObject:contact];
             }
         } while ([set hasAnotherRow]);
     }];
    
    self.contacts = array;
    
}

- (void)queryAllConversation
{
    NSMutableArray *conversationIds = [NSMutableArray array];
    [self.dbq inDatabase:^(FMDatabase *db)
     {
         FMResultSet *set = [db executeQuery:@"select * from sqlite_sequence"];
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
     }];
    
    NSMutableArray *conversations = [NSMutableArray array];
    dispatch_apply([conversationIds count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t idx)
                   {
                       [self.dbq inDatabase:^(FMDatabase *db)
                        {
                            NSString *conName = conversationIds[idx];
                            FMResultSet *conversationSet = [db executeQuery:[NSString stringWithFormat:@"select * from %@ order by MesLocalID", conName]];
                            WHConversation *con = [WHConversation conversationWithResult:conversationSet];
                            [conversations addObject:con];
                        }];
                   });
    self.conversations = [conversations copy];
    NSLog(@"%@", conversations);
    
}

@end
