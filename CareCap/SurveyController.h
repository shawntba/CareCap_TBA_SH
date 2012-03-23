//
//  SurveyController.h
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 3/23/12.
//  Copyright (c) 2012 The beagle armada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SurveyController : UIViewController<MFMailComposeViewControllerDelegate>
{
    UILabel *emailContentLabel;
    UILabel *consultencySwitchLabel;
    UISwitch *consultencySwitch;
    UILabel *azrSwitchLabel;
    UISwitch *azrSwitch;
    UILabel *declarerenSwitchLabel;
    UISwitch *declarerenSwitch;
    UILabel *toolsSwitchLabel;
    UISwitch *toolsSwitch;
    UILabel *zapSwitchLabel;
    UISwitch *zapSwitch;
    UILabel *othersSwitchLabel;
    UISwitch *othersSwitch;
}

@property (retain, nonatomic) IBOutlet UILabel *emailContentLabel;
@property (retain, nonatomic) IBOutlet UILabel *consultencySwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *consultencySwitch;
@property (retain, nonatomic) IBOutlet UILabel *azrSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *azrSwitch;
@property (retain, nonatomic) IBOutlet UILabel *declarerenSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *declarerenSwitch;
@property (retain, nonatomic) IBOutlet UILabel *toolsSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *toolsSwitch;
@property (retain, nonatomic) IBOutlet UILabel *zapSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *zapSwitch;
@property (retain, nonatomic) IBOutlet UILabel *othersSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *othersSwitch;

@property (retain, nonatomic) IBOutlet UIButton *createButton;

- (IBAction)createEmail:(id)sender;
@end
