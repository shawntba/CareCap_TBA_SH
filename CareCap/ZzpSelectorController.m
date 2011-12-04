//
//  ZzpSelectorController.m
//  CareCap
//
//  Created by J on 11-7-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ZzpSelectorController.h"
#import "ZzpCalculationController.h"

@implementation ZzpSelectorController

@synthesize selectorBtn;
@synthesize picker;
@synthesize pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [selectorBtn release];
    [pickerView release];
    [picker release];
    [data release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Picker

-(void) hidePicker
{
    [pickerView setHidden:YES];
    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setDuration:0.3];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[pickerView layer] addAnimation:animation forKey:@"hide picker"];
}

-(void) showPicker
{
    [pickerView setHidden:NO];    
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromTop];
    [animation setDuration:0.3];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[pickerView layer] addAnimation:animation forKey:@"show picker"];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [data count];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 260;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [data objectAtIndex:row];
}

-(IBAction) next
{
    NSString *zzp = [data objectAtIndex:[picker selectedRowInComponent:0]];
    [selectorBtn setTitle:zzp forState:UIControlStateNormal];
    [self hidePicker];
    
    ZzpCalculationController *controller = [[ZzpCalculationController alloc] initWithNibName:@"ZzpCalculationController" bundle:nil withZZP:zzp];
    
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"ZZPList" ofType:@"plist"];
    data = [[NSArray alloc] initWithArray:[NSArray arrayWithContentsOfFile:dataPath]];
    
    [pickerView setHidden:YES];
    [pickerView setFrame:CGRectMake(0, 156, 320, 260)];
    [self.view addSubview:pickerView];
    
    [selectorBtn addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTitle:@"Selector"];
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
//    return YES;
}

@end
