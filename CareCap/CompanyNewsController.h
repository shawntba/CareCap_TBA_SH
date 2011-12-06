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
}

@property (nonatomic, retain) NSMutableArray *listOfNews;

@end
