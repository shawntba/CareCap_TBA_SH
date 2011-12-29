//
//  HelpController.h
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 12/29/11.
//  Copyright (c) 2011 The beagle armada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpController : UIViewController
<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
	NSMutableArray *viewControllers;
    BOOL pageControlUsed;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end
