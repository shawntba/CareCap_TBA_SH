//
//  NewsDetailController.h
//  CareCap
//
//  Created by Ray Shawn on 10/6/11.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailController : UIViewController {
    News *news;
    UIActivityIndicatorView *loadingIndicator;
}

@property (nonatomic, retain) News *news;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNews:(News *)anews;

@end
