//
//  News.m
//  CareCap
//
//  Created by Shawn Ray on 11/5/11.
//  Copyright (c) 2011 __The Beagle Armada__. All rights reserved.
//

#import "News.h"

@implementation News

@synthesize ID;
@synthesize Title;
@synthesize Content;
@synthesize IsRead;
@synthesize PublishDate;
@synthesize URL;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])){
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.Title = [aDecoder decodeObjectForKey:@"Title"];
        self.Content = [aDecoder decodeObjectForKey:@"Content"];
        self.IsRead = [aDecoder decodeObjectForKey:@"IsRead"];
        self.PublishDate = [aDecoder decodeObjectForKey:@"PublishDate"];
        self.URL = [aDecoder decodeObjectForKey:@"URL"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.Title forKey:@"Title"];
    [aCoder encodeObject:self.Content forKey:@"Content"];
    [aCoder encodeObject:self.IsRead forKey:@"IsRead"];
    [aCoder encodeObject:self.PublishDate forKey:@"PublishDate"];
    [aCoder encodeObject:self.URL forKey:@"URL"];
}

- (void) dealloc {
    [ID release];
    [Title release];
    [Content release];
    [IsRead release];
    [PublishDate release];
    [URL release];
    [super dealloc];
}

@end
