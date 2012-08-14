//
//  CompanyNewsController.h
//  CareCap
//
//  Created by Tba-Sh-Apple on 11/29/11.
//  Copyright (c) 2011 __The Beagle Armada__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyNewsController : UITableViewController
{
    NSMutableArray *listOfNews;
    NSOperationQueue *queue;
}

@property (nonatomic, retain) NSMutableArray *listOfNews;
@property (nonatomic, retain) NSOperationQueue *queue;

- (void) loadData;

@end
