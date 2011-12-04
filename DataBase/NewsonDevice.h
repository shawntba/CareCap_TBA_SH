//
//  NewsonDevice.h
//  CareCap
//
//  Created by Shawn Ray on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsonDevice : NSObject {
    NSString *_id;
    NSString *_title;
    NSString *_content;
    NSString *_isRead;
    NSString *_publishDate;
    NSString *_accessURL;
}

//Methods
+ (NSArray *) findAll;
//+ (id) find:(NSInteger) ID;
+ (int) count;
+ (int) createWithID:(NSString *) ID Title:(NSString *) title Content:(NSString *) content IsRead:(NSString *) isRead PublishDate:(NSString *)publishDate  AccessURL:(NSString *) accessURL;
+ (int) update:(NSString *)ID IsRead:(NSString *) isRead;

- (id) initWithID:(NSString *) ID Title:(NSString *) title Content:(NSString *) content IsRead:(NSString *) isRead PublishDate:(NSString *)publishDate  AccessURL:(NSString *) accessURL;

- (NSString *) ID;
- (NSString *) Title;
- (NSString *) Content;
- (NSString *) IsRead;
- (NSString *) PublishDate;
- (NSString *) AccessURL; 
@end
