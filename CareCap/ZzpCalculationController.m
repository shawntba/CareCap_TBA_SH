//
//  ZzpCalculationController.m
//  CareCap
//
//  Created by Gary.Gan on 11-7-29.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import "ZzpCalculationController.h"


@implementation ZzpCalculationController
@synthesize zzp;
@synthesize tbl;
@synthesize textFields;

@synthesize listContent;
@synthesize resultDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withZZP:(NSString *) azzp
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.zzp = azzp;
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"ZZPPackage" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:dataPath]];
        
        listContent = [[dict objectForKey:azzp] retain];
        textFields = [[NSMutableArray alloc] initWithCapacity:[listContent count]];
        
        for(int i=0;i<[listContent count];i++){
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(220, 10, 70, 24)];
            
            [textField setBorderStyle:UITextBorderStyleRoundedRect];
            [textField setFont:[UIFont systemFontOfSize:16]];
            [textField setText:[NSString stringWithFormat:@"%d",0]];
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
            [textField setDelegate:self];
            [textFields addObject:textField];
        }
        
        [dict release];
    }
    
    return self;
}

- (void)dealloc
{
    [zzp release];
    [textFields release];
    [listContent release];
    [resultDictionary release];
    
    [super dealloc];
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) calculate
{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"FunctionRule" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:dataPath]];
    
    NSString *hoursDataPath = [[NSBundle mainBundle] pathForResource:@"FunctionHours" ofType:@"plist"];
    NSDictionary *hoursDict = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:hoursDataPath]];
    
    NSString *aliasDataPath = [[NSBundle mainBundle] pathForResource:@"FunctionAlias" ofType:@"plist"];
    NSDictionary *aliasDict = [[NSDictionary alloc] initWithDictionary:[NSDictionary dictionaryWithContentsOfFile:aliasDataPath]];
    
    NSMutableArray *initialResultsArray = [[NSMutableArray alloc] initWithCapacity:[aliasDict count]];
    
    for (int i = 0; i < [aliasDict count]; i++) {
        [initialResultsArray addObject:[NSNumber numberWithFloat:0.00]];
    }
    
    resultDictionary = [[NSMutableDictionary alloc] initWithObjects:initialResultsArray forKeys:[aliasDict allKeys]];
    
    float result = 0.0;
    int count = [listContent count];
    
    for(int i=0; i<count; i++){
        UITextField *textField = [textFields objectAtIndex:i];
        
        if([textField isKindOfClass:[UITextField class]] && [textField.text floatValue] != 0){
            result += [textField.text floatValue] * [[dict objectForKey:[listContent objectAtIndex:i]] floatValue];
            
            NSDictionary *rulesDict = [hoursDict objectForKey:[listContent objectAtIndex:i]];
            
            for (NSString *key in rulesDict) {
                id tmpRule = [rulesDict objectForKey:key];
                NSString *ruleAlias = [aliasDict objectForKey:key];
                
                float tmpResultPerRule = ([tmpRule floatValue] * [textField.text floatValue])/36;
                
                float sumResultsPerRule = [[resultDictionary valueForKey:key] floatValue] + tmpResultPerRule;
                
                [resultDictionary setValue:[NSNumber numberWithFloat:sumResultsPerRule] forKey:key];
                
                NSLog(@"%@: %.1f", ruleAlias, tmpResultPerRule);
            }
        }
    }
    
    result = result/36;
    
    NSInteger showResult = ceil(result);
    
    NSLog(@"%d", showResult);
    
    float totalResult = 0.0;
    NSString *showTotalResult = @"";
    
    for (NSString *key in resultDictionary) {
        id resultPerRule = [resultDictionary objectForKey:key];
        NSString *aliasPerRule = [aliasDict objectForKey:key];
        
        NSLog(@"%@: %.1f", aliasPerRule, [resultPerRule floatValue]);
        
        NSString *tmpresultPerRule = [NSString stringWithFormat:@"%.1f", [resultPerRule floatValue]];
        
        if([tmpresultPerRule floatValue] > 0.0)
        {
            showTotalResult = [showTotalResult stringByAppendingString:[NSString stringWithFormat:@"%.1f %@\n", [resultPerRule floatValue], aliasPerRule]];

            totalResult = totalResult + [tmpresultPerRule floatValue];
        }
    }
    
    NSLog(@"Total: %f", totalResult);
    
    showTotalResult = [[NSString stringWithFormat:@"%.1f FTE benodigd volgens NZa normen:\n\n", totalResult] stringByAppendingString:showTotalResult];
    
    [dict release];
    [hoursDict release];
    [aliasDict release];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:showTotalResult delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
    
    ((UILabel*)[[alert subviews] objectAtIndex:1]).textAlignment = UITextAlignmentLeft;
}

-(IBAction) backgroundClick
{
    for(UITextField *textField in textFields){
        [textField resignFirstResponder];
    }
    
    [BackgroundButton setHidden:YES];
}

#pragma mark - Table

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    int index = [textFields indexOfObject:textField];
    [tbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //Set the intial input value as string.empty;
    [textField setText:@""];
    
    [BackgroundButton setHidden:NO];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 6)
        return NO;
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listContent count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *function = [listContent objectAtIndex:indexPath.row];
    
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setNeedsDisplayInRect:CGRectMake(10, 10, 150, 20)];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    cell.textLabel.text = function;
    
    UITextField *textField = [textFields objectAtIndex:indexPath.row];
    [cell.contentView addSubview:textField];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.listContent objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *btnCalculate = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Calculate_Button", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(calculate)];
    [self.navigationItem setRightBarButtonItem:btnCalculate];
    [btnCalculate release];
    
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    [bottom setBackgroundColor:[UIColor clearColor]];
    [tbl setTableFooterView:bottom];
    [bottom release];
    
    [BackgroundButton setHidden:YES];
    
    tbl.scrollEnabled = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    return YES;
}

@end
