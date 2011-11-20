//
//  CompanyNewsController.h
//  CareCap
//
//  Created by Ray Shawn on 10/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CompanyNewsController : UITableViewController {
    NSMutableArray *listOfNews;
}

@property (nonatomic, retain) NSMutableArray *listOfNews;

@end
