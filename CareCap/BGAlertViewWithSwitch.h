//
//  BGAlertViewWithSwitch.h
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 3/22/12.
//  Copyright (c) 2012 The beagle armada. All rights reserved.
//

#import <Foundation/Foundation.h>

//An assumed value.
#define ALERT_VIEW_LINE_HEIGHT 20.0
#define ALERT_VIEW_LABEL_PADDING 5.0
#define ALERT_VIEW_LABEL_ALPHA 0.5

#define kAlertSwitchLabelTag 42
#define consultancyAlertSwitchLableTag 43
#define azrAlertSwitchLableTag 44
#define declarerenAlertSwitchLableTag 45
#define toolsAlertSwitchLableTag 46
#define zapAlertSwitchLableTag 47
#define othersAlertSwitchLableTag 48

@interface BGAlertViewWithSwitch : UIAlertView 
{
    UISwitch *_alertSwitch;
    
    UISwitch *_consultancyAlertSwitch;
    UISwitch *_azrAlertSwitch;
    UISwitch *_declarerenAlertSwitch;
    UISwitch *_toolsAlertSwitch;
    UISwitch *_zapAlertSwitch;
    UISwitch *_othersAlertSwitch;
    
    UILabel *_alertSwitchLabel;
    
    UILabel *_consultancyAlertSwitchLabel;
    UILabel *_azrAlertSwitchLabel;
    UILabel *_declarerenAlertSwitchLabel;
    UILabel *_toolsAlertSwitchLabel;
    UILabel *_zapAlertSwitchLabel;
    UILabel *_othersAlertSwitchLabel;
}

@property (nonatomic, retain) UISwitch *alertSwitch;
@property (nonatomic, retain) UILabel *alertSwitchLabel;

@property (nonatomic, retain) UISwitch *consultancyAlertSwitch;
@property (nonatomic, retain) UILabel *consultancyAlertSwitchLabel;
@property (nonatomic, retain) UISwitch *azrAlertSwitch;
@property (nonatomic, retain) UILabel *azrAlertSwitchLabel;
@property (nonatomic, retain) UISwitch *declarerenAlertSwitch;
@property (nonatomic, retain) UILabel *declarerenAlertSwitchLabel;
@property (nonatomic, retain) UISwitch *toolsAlertSwitch;
@property (nonatomic, retain) UILabel *toolsAlertSwitchLabel;
@property (nonatomic, retain) UISwitch *zapAlertSwitch;
@property (nonatomic, retain) UILabel *zapAlertSwitchLabel;
@property (nonatomic, retain) UISwitch *othersAlertSwitch;
@property (nonatomic, retain) UILabel *othersAlertSwitchLabel;

@property (nonatomic, readonly, getter=isOn) BOOL on;

-(id)initWithTitle:(NSString*) title
           message:(NSString*) message
     switchMessage:(NSString*) switchMessage
          delegate:(id) delegate
 cancelButtonTitle:(NSString*) cancelButtonTitle
     okButtonTitle:(NSString*) okButtonTitle;

@end
