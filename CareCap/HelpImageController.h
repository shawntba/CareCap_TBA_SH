//
//  HelpImageController.h
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 12/29/11.
//  Copyright (c) 2011 The beagle armada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpImageController : UIViewController{
    UIImageView *imageView;
	int pageNumber;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

-(id)initWithPageNumber:(int)page;

@end
