//
//  ZzpCalculationController.h
//  CareCap
//
//  Created by Gary.Gan on 11-7-29.
//  Copyright 2011 __The Beagle Armada__. All rights reserved.
//

#define CalculationResultAlert 1
#define ContactInformationAlert 2
#define ConsultationOption 0
#define AZROption 1
#define DeclaretenOption 2
#define EIditorOption 3
#define ZAPliveOption 4
#define OthersOption 5

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface ZzpCalculationController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
    NSString *zzp;
    NSMutableArray *textFields;
    NSArray *listContent;
    NSDictionary *resultDictionary;
    IBOutlet UITableView *tbl;
    IBOutlet UIButton *BackgroundButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withZZP:(NSString *) zzp;
- (IBAction) backgroundClick;

-(void)sendEMail;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;

-(void) createSurveyForm:(UIAlertView *) sender;

@property (nonatomic, retain) NSString *zzp;
@property (nonatomic, retain) NSMutableArray *textFields;
@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSDictionary *resultDictionary;
@property (nonatomic, retain) IBOutlet UITableView *tbl;

@end
