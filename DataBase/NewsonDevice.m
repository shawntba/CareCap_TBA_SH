//
//  NewsonDevice.m
//  CareCap
//
//  Created by Shawn Ray on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsonDevice.h"
#import "DataBase.h"

@implementation NewsonDevice

//Find all news which have been stored on this Device
+(NSArray *) findAll{
    PLSqliteDatabase *dataBase = [DataBase setup];
    
    id<PLResultSet> rs;
    
    rs = [dataBase executeQuery:@"SELECT * FROM News;"];
    
    //Stored the news in the array
    NSMutableArray *listOfNews = [[NSMutableArray alloc] init];
    
    //Translate the rs database information to news objects list
    while ([rs next]) {
        NSString *ID = [rs objectForColumn:@"ID"];
        NSString *title = [rs objectForColumn:@""];
        NSString *content = [rs objectForColumn:@""];
        NSString *isRead = [rs objectForColumn:@""];
        NSString *publishDate = [rs objectForColumn:@""];
        NSString *accessURL = [rs objectForColumn:@""];
        
        //Intial the news object
        NewsonDevice *news = [[NewsonDevice alloc] initWithID:ID Title:title Content:content IsRead:isRead PublishDate:publishDate AccessURL:accessURL];
        
        [listOfNews addObject:news];
        
        [news release];
    }
    
    //Close db connection
    [rs close];
    
    return listOfNews;
}

//Get the count of news on the device
+ (int) count{
    PLSqliteDatabase *dataBase = [DataBase setup];
    int newsCount = 0;
    
    id<PLResultSet> rs;
    
    rs = [dataBase executeQuery:@"SELECT COUNT(ID) AS NewsCount FROM News"];
    
    if ([rs next]) {
        newsCount = [[rs objectForColumn:@"NewsCount"] intValue];
    }
    
    [rs close];
    
    return newsCount;
}

//Update the [IsRead] property of the news object
+ (int) update:(NSString *)ID IsRead:(NSString *)isRead{
    PLSqliteDatabase *dataBase = [DataBase setup];
    
    BOOL bResult = [dataBase executeUpdate:@"UPDATE News SET IsRead = ? WHERE ID = ?", isRead, ID];
    
    return bResult;
}

//Add news object into database
+ (int) createWithID:(NSString *)ID Title:(NSString *)title Content:(NSString *)content IsRead:(NSString *)isRead PublishDate:(NSString *)publishDate AccessURL:(NSString *)accessURL{
    PLSqliteDatabase *dataBase = [DataBase setup];
    
//    NSString *query = [NSString stringWithFormat:@"INSERT INTO News (ID, Title, Content, IsRead, PublishDate, AccessURL) VALUES ('%@','%@','%@','%@','%@','%@')", ID, title, content, isRead, publishDate, accessURL];
    
//    title = [title stringByReplacingOccurrencesOfString:@"'" withString:@"\'"];
//    
//    content = @"";
//    
//    NSLog(@"%@", content);
//    
//    BOOL bResult = [dataBase executeUpdate:@"INSERT INTO News (ID, Title, Content, IsRead, PublishDate, AccessURL) VALUES (?,?,?,?,?,?)",
//                    ID,
//                    title,
//                    content,
//                    isRead,
//                    publishDate,
//                    accessURL];
    
    BOOL bResult = [dataBase executeUpdate:@"INSERT INTO News (ID, Title, Content, IsRead, PublishDate, AccessURL) VALUES (?,?,?,?,?,?)",
                    @"1",
                    @"1",
                    @"1",
                    @"1",
                    @"1",
                    @"1"];
//    BOOL bResult = [dataBase executeUpdate:query];
//    BOOL bResult = YES;
//    
//    id<PLPreparedStatement> stmt = [dataBase prepareStatement: @"INSERT INTO News (ID, Title, Content, IsRead, PublishDate, AccessURL) VALUES (?,?,?,?,?,?)"];
//    
//    title = [title stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
//    content = [content stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
//    // Bind the parameters
//    [stmt bindParameters: [NSArray arrayWithObjects: @"1", @"1", @"1", @"1", @"1", @"1", nil]];
//    // Execute the INSERT
//    if ([stmt executeUpdate] == NO){
//        NSLog(@"INSERT failed");
//        bResult = NO;
//    } else {
//        NSLog(@"INSERT successed");
//    }
    
    return bResult;
}

//Initial Method
- (id) initWithID:(NSString *)ID Title:(NSString *)title Content:(NSString *)content IsRead:(NSString *)isRead PublishDate:(NSString *)publishDate AccessURL:(NSString *)accessURL{
    if(self = [super init]){
        _id = [ID retain];
        _title = [title retain];
        _content = [content retain];
        _isRead = [isRead retain];
        _publishDate = [publishDate retain];
        _accessURL = [accessURL retain];
    }
    return self;
}

- (NSString *) ID{
    return _id;
}

- (NSString *) Title{
	return _title;
}

- (NSString *) Content{
	return _content;
}

- (NSString *) IsRead{
	return _isRead;
}

- (NSString *) PublishDate{
	return _publishDate;
}

- (NSString *) AccessURL{
	return _accessURL;
}
@end
