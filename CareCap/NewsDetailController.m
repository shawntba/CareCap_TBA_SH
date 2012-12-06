//
//  NewsDetailController.m
//  CareCap
//
//  Created by Ray Shawn on 10/6/11.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#import "NewsDetailController.h"
#import "NewsFullContentController.h"
#import "SHK.h"
#import "SHKTwitter.h"

@implementation NewsDetailController

@synthesize news;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withNews:(News *)anews
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.news = anews;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)share
{
    //NSURL *url = [NSURL URLWithString:self.news.URL];
    NSURL *url = [NSURL URLWithString:@"www.thebeaglearmada.nl"];
    NSString *tweet = [NSString stringWithFormat:@"News:%@", self.news.Title];
    
	SHKItem *item = [SHKItem URL:url title:tweet contentType:(SHKURLContentTypeUndefined)];
    //SHKItem *item = [SHKItem URL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=3t8MeE8Ik4Y"] title:@"Big bang" contentType:SHKURLContentTypeVideo];
    //item.facebookURLSharePictureURI = @"http://www.state.gov/cms_images/india_tajmahal_2003_06_252.jpg";
    //item.facebookURLShareDescription = @"description text";
    //item.mailToRecipients = [NSArray arrayWithObjects:NSLocalizedString(@"Company_Email", nil), nil];
    //item.shareType = SHKShareTypeURL;
    
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [SHK setRootViewController:self];
	[actionSheet showFromToolbar:self.navigationController.toolbar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self setTitle:NSLocalizedString(@"News_Detail", nil)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 93)];
    
    [webview setDelegate: self];
    
    NSLog(@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content);
    
    [webview loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.Content] baseURL:nil];
    
    [self.view addSubview:webview];
    
    [webview release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Add Share Button
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = shareButton;
    [shareButton release];
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
    //return YES;
}

#pragma mark - WebView lifecycle

- (BOOL) webView: (UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@"Clicked and invoked!");
        
        NewsFullContentController *controller = [[NewsFullContentController alloc] initWithNibName:@"NewsFullContentController" bundle:nil withNews:self.news];
        
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
        return NO;
    }
    
    NSLog(@"Without click, but invoked!");
    
    return YES;
}

@end
