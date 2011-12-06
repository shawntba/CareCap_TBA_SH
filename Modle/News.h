//
//  News.h
//  CareCap
//
//  Created by Shawn Ray on 11/5/11.
//  Copyright (c) 2011 __The Beagle Armada__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject<NSCoding> {
    NSNumber *ID;
    NSString *Title;
    NSString *Content;
    NSNumber *IsRead;
    NSDate *PublishDate;
    NSString *URL;
}

@property (nonatomic, retain) NSNumber *ID;
@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSString *Content;
@property (nonatomic, retain) NSNumber *IsRead;
@property (nonatomic, retain) NSDate *PublishDate;
@property (nonatomic, retain) NSString *URL;

@end
