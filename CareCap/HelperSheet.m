//
//  VlionActionSheet.m
//  TestActionSheet
//
//  Created by Cui Lionel on 10-12-8.
//  Copyright 2010 vlion. All rights reserved.
//

#import "HelperSheet.h"


@implementation HelperSheet
@synthesize view;
@synthesize toolBar;
-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title
{//height = 84, 134, 184, 234, 284, 334, 384, 434, 484
	self = [super init];
    if (self) 
	{
		int theight = height - 40;
		int btnnum = theight/50;
		for(int i=0; i<btnnum; i++)
		{
			[self addButtonWithTitle:@" "];
		}
		toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
		toolBar.barStyle = UIBarStyleDefault;
		
		UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain target: nil action: nil];
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleDone target: self action: @selector(done)];
		UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(docancel)];
		UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
		NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
		[toolBar setItems: array];		
		[titleButton release];
		[leftButton  release];
		[rightButton release];
		[fixedButton release];
		[array       release];
		
		[self addSubview:toolBar];
		view = [[UIView alloc] initWithFrame:CGRectMake(10, 44, 300, height-44-10)];
		view.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:view];
        
        [self sizeThatFits:CGSizeMake(300, height-44-10)];
    }
    return self;
}
-(void)done
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)docancel
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)dealloc
{
	[view release];
	[super dealloc];
}
@end
