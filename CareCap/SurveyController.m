//
//  SurveyController.m
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 3/23/12.
//  Copyright (c) 2012 The beagle armada. All rights reserved.
//

#import "SurveyController.h"

@implementation SurveyController

@synthesize emailContentLabel;
@synthesize consultencySwitchLabel;
@synthesize consultencySwitch;
@synthesize azrSwitchLabel;
@synthesize azrSwitch;
@synthesize declarerenSwitchLabel;
@synthesize declarerenSwitch;
@synthesize toolsSwitchLabel;
@synthesize toolsSwitch;
@synthesize zapSwitchLabel;
@synthesize zapSwitch;
@synthesize othersSwitchLabel;
@synthesize othersSwitch;
@synthesize createButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [emailContentLabel setText:NSLocalizedString(@"Survey_Content", nil)];
    [emailContentLabel sizeToFit];
    [emailContentLabel setLineBreakMode:UILineBreakModeWordWrap];
    
    [consultencySwitchLabel setText:NSLocalizedString(@"Switch_Consultancy", nil)];
    [azrSwitchLabel setText:NSLocalizedString(@"Switch_AZR", nil)];
    [declarerenSwitchLabel setText:NSLocalizedString(@"Switch_Declareren", nil)];
    [toolsSwitchLabel setText:NSLocalizedString(@"Switch_Tools", nil)];
    [zapSwitchLabel setText:NSLocalizedString(@"Swtich_ZAP", nil)];
    [othersSwitchLabel setText:NSLocalizedString(@"Switch_Others", nil)];
    
    [consultencySwitchLabel sizeToFit];
    [consultencySwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [azrSwitchLabel sizeToFit];
    [azrSwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [declarerenSwitchLabel sizeToFit];
    [declarerenSwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [toolsSwitchLabel sizeToFit];
    [toolsSwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [zapSwitchLabel sizeToFit];
    [zapSwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [othersSwitchLabel sizeToFit];
    [othersSwitchLabel setFont:[UIFont boldSystemFontOfSize:13]];
    

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

- (void)dealloc {
    [emailContentLabel release];
    [consultencySwitchLabel release];
    [consultencySwitch release];
    [azrSwitchLabel release];
    [azrSwitch release];
    [declarerenSwitchLabel release];
    [declarerenSwitch release];
    [toolsSwitchLabel release];
    [toolsSwitch release];
    [zapSwitchLabel release];
    [zapSwitch release];
    [othersSwitchLabel release];
    [othersSwitch release];
    [createButton release];
    [super dealloc];
}

# pragma Generate Email

- (NSString *)GenerateEmailContent
{
    NSString *emailContent = [NSString stringWithFormat:NSLocalizedString(@"Email_Content", nil), 
                              consultencySwitch.isOn ? @"checked = 'true'" : @"",
                              azrSwitch.isOn ? @"checked = 'true'" : @"",
                              declarerenSwitch.isOn ? @"checked = 'true'" : @"",
                              toolsSwitch.isOn ? @"checked = 'true'" : @"",
                              zapSwitch.isOn ? @"checked = 'true'" : @"",
                              othersSwitch.isOn ? @"checked = 'true'" : @""];
    
    //[emailContent stringByAppendingString:consultencySwitch.isOn ? @"true" : @"false"];
    
    NSLog(@"%@", emailContent);
    
    return emailContent;
}
  
//If the email could be sent 
-(void)displayComposerSheet   
{  
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];  
    
    mailPicker.mailComposeDelegate = self;  
    
    //Set up Mail Title  
    [mailPicker setSubject: NSLocalizedString(@"Email_Subject", nil)];  
    
    //Add senders  
    NSArray *toRecipients = [NSArray arrayWithObject: NSLocalizedString(@"Company_Email", nil)];  
    //NSArray *ccRecipients = [NSArray arrayWithObjects: @"second@example.com", @"third@example.com", nil];  
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];  
    [mailPicker setToRecipients: toRecipients];  
    //[mailPicker setCcRecipients: ccRecipients];      
    //[picker setBccRecipients:bccRecipients];  
    
    //Add pics as attachment 
    //    UIImage *addPic = [UIImage imageNamed: @"3.jpg"];  
    //    NSData *imageData = UIImagePNGRepresentation(addPic);            // png  
    //    // NSData *imageData = UIImageJPEGRepresentation(addPic, 1);    // jpeg  
    //    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @"3.jpg"];  
    
    //NSString *emailBody = NSLocalizedString(@"Email_Content", nil);  
    NSString *emailBody = [self GenerateEmailContent];
    [mailPicker setMessageBody:emailBody isHTML:YES];  
    
    [self presentModalViewController: mailPicker animated:YES];  
    [mailPicker release];  
}  

-(void) launchMailAppOnDevice  
{  
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@&subject=my email!", NSLocalizedString(@"Company_Email", nil)];  
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";  
    NSString *body = @"&body=email body!";  
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];  
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];  
}

-(void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg   
{  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_   
                                                    message:msg   
                                                   delegate:nil   
                                          cancelButtonTitle:@"OK"   
                                          otherButtonTitles:nil];  
    [alert show];  
    [alert release];  
}

-(void) mailComposeController:(MFMailComposeViewController *)controller   
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error   
{  
    NSString *msg;  
    
    switch (result)   
    {  
        case MFMailComposeResultCancelled:  
            msg = @"Cancel the email;";  
            break;  
        case MFMailComposeResultSaved:  
            msg = @"Saved draft;";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultSent:  
            msg = @"Send successfully;";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        case MFMailComposeResultFailed:  
            msg = @"Send failed;";  
            [self alertWithTitle:nil msg:msg];  
            break;  
        default:  
            break;  
    }  
    
    [self dismissModalViewControllerAnimated:YES];  
}

//Send emails  
-(void)sendEMail   
{  
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));  
    
    if (mailClass != nil)  
    {  
        if ([mailClass canSendMail])  
        {  
            [self displayComposerSheet];  
        }   
        else   
        {  
            [self launchMailAppOnDevice];  
        }  
    }   
    else   
    {  
        [self launchMailAppOnDevice];  
    }      
}

- (IBAction)createEmail:(id)sender {
    NSString *emailAddress = [NSString stringWithFormat:@"email://%@", NSLocalizedString(@"Company_Email", nil)];
    
    NSLog(@"%@", emailAddress);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailAddress]];

    [self sendEMail];
}
@end
