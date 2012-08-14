//
//  NewsFullContentController.m
//  CareCap
//
//  Created by Tba-Sh-Apple on 8/10/12.
//
//

#import "NewsFullContentController.h"

@interface NewsFullContentController ()

@end

@implementation NewsFullContentController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self setTitle:NSLocalizedString(@"News_Content", nil)];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 93)];
    
    [webview setDelegate: self];
    
    NSLog(@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.FullContent);
    
    [webview loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name=\"apple-mobile-web-app-capable\" content=\"yes\"></head><body>%@</body></html>",self.news.FullContent] baseURL:nil];
    
    [self.view addSubview:webview];
    
    [webview release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - WebView lifecycle

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ([[[inRequest URL] scheme] isEqual:@"mailto"]) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
