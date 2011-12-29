//
//  HelpImageController.m
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 12/29/11.
//  Copyright (c) 2011 The beagle armada. All rights reserved.
//

#import "HelpImageController.h"

static NSArray *__pageControlImageList = nil;

@implementation HelpImageController

@synthesize imageView;

+(UIImage *)pageControlImageWithIndex:(NSUInteger)index
{
	UIImage *image1 = [UIImage imageNamed:@"01.png"];
	UIImage *image2 = [UIImage imageNamed:@"02.png"];
	UIImage *image3 = [UIImage imageNamed:@"03.png"];
    UIImage *image4 = [UIImage imageNamed:@"04.png"];
    
	if (__pageControlImageList==nil) {
		__pageControlImageList = [[NSArray alloc] initWithObjects:image1,image2,image3,image4, nil];
	}
	return [__pageControlImageList objectAtIndex:index %[__pageControlImageList count]];
}

- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"HelpImageController" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
	[imageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    [imageView setImage:[HelpImageController pageControlImageWithIndex:pageNumber]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
