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

@interface WHDBManager ()

@property (nonatomic, copy) NSString *dbPath;


@property (nonatomic, strong) FMDatabaseQueue *dbq;
@end


@implementation WHDBManager

+ (id)defaultManager
{
    static WHDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WHDBManager alloc] init];
    });
    return manager;
}

- (void)loadDatabase:(NSString *)dbpath
{
    if (self.dbPath != dbpath)
    {
        [self.dbq close];
        self.dbPath = dbpath;
        self.dbq = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        
        [self queryAllFriends];
        [self queryAllConversation];
    }
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
                     [conversationIds addObject:[candidateName substringFromIndex:5]];
                 }
             }
         } while ([set hasAnotherRow]);
     }];

    
    NSMutableArray *conversations = [NSMutableArray array];
    dispatch_apply([self.contacts count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t idx)
                   {
                       [self.dbq inDatabase:^(FMDatabase *db)
                        {
                            WHContact *contact = self.contacts[idx];
                            NSString *md5 = [contact userName].MD5Digest;
                            if ([conversationIds containsObject:[contact userName].MD5Digest])
                            {
                                FMResultSet *conversationSet = [db executeQuery:[NSString stringWithFormat:@"select * from %@ order by MesLocalID", [NSString stringWithFormat:@"Chat_%@", md5]]];
                                WHConversation *con = [WHConversation conversationWithResult:conversationSet];
                                [con setContacts:@[contact]];
                                [conversations addObject:con];
                            }
                        }];
                   });
    self.conversations = [conversations copy];
}

@end
