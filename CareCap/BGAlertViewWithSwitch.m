//
//  BGAlertViewWithSwitch.m
//  CareCap
//
//  Created by Tba-Sh-Apple Development on 3/22/12.
//  Copyright (c) 2012 The beagle armada. All rights reserved.
//

#import "BGAlertViewWithSwitch.h"


@implementation BGAlertViewWithSwitch
@synthesize alertSwitch = _alertSwitch;
@synthesize alertSwitchLabel = _alertSwitchLabel;

@synthesize consultancyAlertSwitch = _consultancyAlertSwitch;
@synthesize consultancyAlertSwitchLabel = _consultancyAlertSwitchLabel;

@synthesize azrAlertSwitch = _azrAlertSwitch;
@synthesize azrAlertSwitchLabel = _azrAlertSwitchLabel;

@synthesize declarerenAlertSwitch = _declarerenAlertSwitch;
@synthesize declarerenAlertSwitchLabel = _declarerenAlertSwitchLabel;

@synthesize toolsAlertSwitch = _toolsAlertSwitch;
@synthesize toolsAlertSwitchLabel = _toolsAlertSwitchLabel;

@synthesize zapAlertSwitch = _zapAlertSwitch;
@synthesize zapAlertSwitchLabel = _zapAlertSwitchLabel;

@synthesize othersAlertSwitch = _othersAlertSwitch;
@synthesize othersAlertSwitchLabel = _othersAlertSwitchLabel;


#pragma mark - UISwitch Accessor

-(BOOL)isOn
{
    return self.alertSwitch.isOn;
}


#pragma mark - View lifecycle

- (void)InitialSwitches
{
    self.consultancyAlertSwitch = [[UISwitch alloc] init];
    self.consultancyAlertSwitch.on = YES; 
    [self addSubview:self.consultancyAlertSwitch];
    [self.consultancyAlertSwitch retain];
    
    self.azrAlertSwitch = [[UISwitch alloc] init];
    self.azrAlertSwitch.on = YES; 
    [self addSubview:self.azrAlertSwitch];
    [self.azrAlertSwitch retain];
    
    self.declarerenAlertSwitch = [[UISwitch alloc] init];
    self.declarerenAlertSwitch.on = YES; 
    [self addSubview:self.declarerenAlertSwitch];
    [self.declarerenAlertSwitch retain];
    
    self.toolsAlertSwitch = [[UISwitch alloc] init];
    self.toolsAlertSwitch.on = YES; 
    [self addSubview:self.toolsAlertSwitch];
    [self.toolsAlertSwitch retain];
    
    self.zapAlertSwitch = [[UISwitch alloc] init];
    self.zapAlertSwitch.on = YES; 
    [self addSubview:self.zapAlertSwitch];
    [self.zapAlertSwitchLabel retain];
    
    self.othersAlertSwitch = [[UISwitch alloc] init];
    self.othersAlertSwitch.on = YES; 
    [self addSubview:self.othersAlertSwitch];
    [self.othersAlertSwitchLabel retain];
}

- (void)InitialSwitchesLabel
{
    self.consultancyAlertSwitchLabel = [[UILabel alloc] init];
    self.consultancyAlertSwitchLabel.text = NSLocalizedString(@"Switch_Consultancy", nil);
    self.consultancyAlertSwitchLabel.tag = consultancyAlertSwitchLableTag;
    self.consultancyAlertSwitchLabel.textAlignment = UITextAlignmentLeft;
    [self addSubview:self.consultancyAlertSwitchLabel];
    [self.consultancyAlertSwitchLabel retain];
    
    self.azrAlertSwitchLabel = [[UILabel alloc] init];
    self.azrAlertSwitchLabel.text = NSLocalizedString(@"Switch_AZR", nil);
    self.azrAlertSwitchLabel.tag = azrAlertSwitchLableTag;
    self.azrAlertSwitchLabel.textAlignment = UITextAlignmentLeft;
    [self addSubview:self.azrAlertSwitchLabel];
    [self.azrAlertSwitchLabel retain];
    
    self.declarerenAlertSwitchLabel = [[UILabel alloc] init];
    self.declarerenAlertSwitchLabel.text = NSLocalizedString(@"Switch_Declareren", nil);
    self.declarerenAlertSwitchLabel.tag = declarerenAlertSwitchLableTag;
    [self addSubview:self.declarerenAlertSwitchLabel];
    [self.declarerenAlertSwitchLabel retain];
    
    self.toolsAlertSwitchLabel = [[UILabel alloc] init];
    self.toolsAlertSwitchLabel.text = NSLocalizedString(@"Switch_Tools", nil);
    self.toolsAlertSwitchLabel.tag = toolsAlertSwitchLableTag;
    [self addSubview:self.toolsAlertSwitchLabel];
    [self.toolsAlertSwitchLabel retain];
    
    self.zapAlertSwitchLabel = [[UILabel alloc] init];
    self.zapAlertSwitchLabel.text = NSLocalizedString(@"Swtich_ZAP", nil);
    self.zapAlertSwitchLabel.tag = zapAlertSwitchLableTag;
    [self addSubview:self.zapAlertSwitchLabel];
    [self.zapAlertSwitchLabel retain];
    
    self.othersAlertSwitchLabel = [[UILabel alloc] init];
    self.othersAlertSwitchLabel.text = NSLocalizedString(@"Switch_Others", nil);
    self.othersAlertSwitchLabel.tag = othersAlertSwitchLableTag;
    [self addSubview:self.othersAlertSwitchLabel];
    [self.othersAlertSwitchLabel retain];
}

-(id)initWithTitle:(NSString*) title
           message:(NSString*) message
     switchMessage:(NSString*) switchMessage
          delegate:(id) delegate
 cancelButtonTitle:(NSString*) cancelButtonTitle
     okButtonTitle:(NSString*) okButtonTitle
{
    
    //For testing layout
    NSString *placeHolder = @"";
    
    //Append a line to the message that leaves the place for the switch. 
    NSString *_expandedMessage = [NSString stringWithFormat:@"%@\n%@\n%@\n", message, placeHolder, placeHolder];
    
    if (self = [self initWithTitle:title
                           message:_expandedMessage
                          delegate:delegate
                 cancelButtonTitle:cancelButtonTitle
                 otherButtonTitles:okButtonTitle, nil])
    {
        //Add switch.
//        self.alertSwitch = [[UISwitch alloc] init];
//        self.alertSwitch.on = YES; 
//        [self addSubview:self.alertSwitch];
//        [self.alertSwitch retain];
        
        [self InitialSwitches];
        
        //Add label.
//        self.alertSwitchLabel = [[UILabel alloc] init];
//        self.alertSwitchLabel.text = switchMessage;
//        self.alertSwitchLabel.tag = kAlertSwitchLabelTag;
//        [self addSubview:self.alertSwitchLabel];
//        [self.alertSwitchLabel retain];
        
        [self InitialSwitchesLabel];
        
        self.frame = CGRectMake(0,0,300,200);
    }
    return self;
}

- (void)dealloc
{
    self.alertSwitch = nil;
    self.alertSwitchLabel = nil;
    
    self.consultancyAlertSwitch = nil;
    self.consultancyAlertSwitchLabel = nil;
    
    self.azrAlertSwitch = nil;
    self.azrAlertSwitchLabel = nil;
    
    self.declarerenAlertSwitch = nil;
    self.declarerenAlertSwitchLabel = nil;
    
    self.toolsAlertSwitch = nil;
    self.toolsAlertSwitchLabel = nil;
    
    self.zapAlertSwitch = nil;
    self.zapAlertSwitchLabel = nil;
    
    self.othersAlertSwitch = nil;
    self.othersAlertSwitchLabel = nil;
    
    [super dealloc];
}


#pragma mark - Topography

- (void)SetSwitchesLayout:(UILabel *)messageLabel settedSwitch:(UISwitch *) settedSwitch settedLabel:(UILabel *) settedLabel horizontalCentering:(float) horizontalCentering increaseHeight:(float) increaseHeight
{
    float switchVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - settedSwitch.frame.size.height ) / 2;
    
    CGRect alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - settedSwitch.frame.size.width - horizontalCentering,
                                         messageLabel.frame.origin.y + messageLabel.frame.size.height - settedSwitch.frame.size.height - switchVerticalCentering + increaseHeight,
                                         settedSwitch.frame.size.width,
                                         settedSwitch.frame.size.height);
    
    settedSwitch.frame = alertSwitchFrame;
//    CGSize alertSwitchLabelSize = [self.consultancyAlertSwitchLabel.text sizeWithFont:messageLabel.font];
//    float horizontalCentering = (messageLabel.frame.size.width - (alertSwitchLabelSize.width + ALERT_VIEW_LABEL_PADDING + self.consultancyAlertSwitch.frame.size.width)) / 2;
//    float switchVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - self.consultancyAlertSwitch.frame.size.height ) / 2;
//    CGRect alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.consultancyAlertSwitch.frame.size.width - horizontalCentering,
//                                         messageLabel.frame.origin.y + messageLabel.frame.size.height - self.consultancyAlertSwitch.frame.size.height - switchVerticalCentering + 30,
//                                         self.consultancyAlertSwitch.frame.size.width,
//                                         self.consultancyAlertSwitch.frame.size.height);
//    self.consultancyAlertSwitch.frame = alertSwitchFrame;
//    
//    
//    alertSwitchLabelSize = [self.azrAlertSwitchLabel.text sizeWithFont:messageLabel.font];
//    horizontalCentering = (messageLabel.frame.size.width - (alertSwitchLabelSize.width + ALERT_VIEW_LABEL_PADDING + self.azrAlertSwitch.frame.size.width)) / 2;
//    switchVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - self.azrAlertSwitch.frame.size.height ) / 2;
//    alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.azrAlertSwitch.frame.size.width - horizontalCentering,
//                                  messageLabel.frame.origin.y + messageLabel.frame.size.height - self.azrAlertSwitch.frame.size.height - switchVerticalCentering + 30 + 30,
//                                  self.azrAlertSwitch.frame.size.width,
//                                  self.azrAlertSwitch.frame.size.height);
//    self.azrAlertSwitch.frame = alertSwitchFrame;
//    
//    alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.declarerenAlertSwitch.frame.size.width - horizontalCentering,
//                                  messageLabel.frame.origin.y + messageLabel.frame.size.height - self.declarerenAlertSwitch.frame.size.height - switchVerticalCentering + 30 + 30 + 30,
//                                  self.declarerenAlertSwitch.frame.size.width,
//                                  self.declarerenAlertSwitch.frame.size.height);
//    self.declarerenAlertSwitch.frame = alertSwitchFrame;
//    
//    alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.toolsAlertSwitch.frame.size.width - horizontalCentering,
//                                  messageLabel.frame.origin.y + messageLabel.frame.size.height - self.toolsAlertSwitch.frame.size.height - switchVerticalCentering + 30 + 30 + 30,
//                                  self.toolsAlertSwitch.frame.size.width,
//                                  self.toolsAlertSwitch.frame.size.height);
//    self.toolsAlertSwitch.frame = alertSwitchFrame;
//    
//    alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.zapAlertSwitch.frame.size.width - horizontalCentering,
//                                  messageLabel.frame.origin.y + messageLabel.frame.size.height - self.zapAlertSwitch.frame.size.height - switchVerticalCentering + 30 + 30 + 30,
//                                  self.zapAlertSwitch.frame.size.width,
//                                  self.zapAlertSwitch.frame.size.height);
//    self.zapAlertSwitch.frame = alertSwitchFrame;
//    
//    alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.othersAlertSwitch.frame.size.width - horizontalCentering,
//                                  messageLabel.frame.origin.y + messageLabel.frame.size.height - self.othersAlertSwitch.frame.size.height - switchVerticalCentering + 30 + 30 + 30,
//                                  self.othersAlertSwitch.frame.size.width,
//                                  self.othersAlertSwitch.frame.size.height);
//    self.othersAlertSwitch.frame = alertSwitchFrame;
}

- (void)SetSwitchesLabelLayout:(UILabel *)messageLabel settedSwitch:(UISwitch *) settedSwitch settedLabel:(UILabel *) settedLabel horizontalCentering:(float) horizontalCentering increaseHeight:(float) increaseHeight
{
    //Label goes to the bottom left.    
    float switchLabelVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - ALERT_VIEW_LINE_HEIGHT ) / 2;
    CGRect alertSwitchLabelFrame = CGRectMake(round( messageLabel.frame.origin.x + horizontalCentering ),
                                              round( messageLabel.frame.origin.y + messageLabel.frame.size.height - ALERT_VIEW_LINE_HEIGHT - switchLabelVerticalCentering + increaseHeight),
                                              messageLabel.frame.size.width - settedSwitch.frame.size.width,
                                              ALERT_VIEW_LINE_HEIGHT); //self.alertSwitchLabel.frame.size.height);
    settedLabel.frame = alertSwitchLabelFrame;
    
    //Copy message label properties.
    settedLabel.backgroundColor = [UIColor clearColor];   
    settedLabel.textColor = messageLabel.textColor;
    settedLabel.font = messageLabel.font;
    settedLabel.shadowColor = messageLabel.shadowColor;
    settedLabel.shadowOffset = messageLabel.shadowOffset;
    
    //Weaken.
    settedLabel.alpha = ALERT_VIEW_LABEL_ALPHA;
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews to (%@)", NSStringFromCGRect(self.frame));
    
    //Weak link to the message label.
    UILabel *messageLabel;
    
    for (UIView *eachSubview in self.subviews)
    {
        if ([[eachSubview class] isEqual:[UILabel class]])
        {
            UILabel *eachLabel = (UILabel*)eachSubview;
            if (eachLabel.tag != kAlertSwitchLabelTag
                && eachLabel.tag != consultancyAlertSwitchLableTag
                && eachLabel.tag != azrAlertSwitchLableTag
                && eachLabel.tag != declarerenAlertSwitchLableTag
                && eachLabel.tag != toolsAlertSwitchLableTag
                && eachLabel.tag != zapAlertSwitchLableTag
                && eachLabel.tag != othersAlertSwitchLableTag)
            {
                messageLabel = eachLabel;
                NSLog(@"Each label frame (%@), saying '%@'", NSStringFromCGRect(eachLabel.frame), eachLabel.text);                
            }
        }
    }
    
    //Enumerate subviews to find message label (the base of the topography).
    for (UIView *eachSubview in self.subviews)
    {
        if ([[eachSubview class] isEqual:[UILabel class]])
        {
            UILabel *eachLabel = (UILabel*)eachSubview;
            
            float hTempCentering = 0;
            
            switch (eachLabel.tag) {
                case consultancyAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.consultancyAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.consultancyAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.consultancyAlertSwitch settedLabel:self.consultancyAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:30];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.consultancyAlertSwitch settedLabel:self.consultancyAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:30];
                    break;
                case azrAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.azrAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.azrAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.azrAlertSwitch settedLabel:self.azrAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:60];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.azrAlertSwitch settedLabel:self.azrAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:60];
                    break;
                case declarerenAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.declarerenAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.declarerenAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.declarerenAlertSwitch settedLabel:self.declarerenAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:90];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.declarerenAlertSwitch settedLabel:self.declarerenAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:90];
                    break;
                case toolsAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.toolsAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.toolsAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.toolsAlertSwitch settedLabel:self.toolsAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:120];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.toolsAlertSwitch settedLabel:self.toolsAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:120];
                    break;
                case zapAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.zapAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.zapAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.zapAlertSwitch settedLabel:self.zapAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:150];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.zapAlertSwitch settedLabel:self.zapAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:150];
                    break;
                case othersAlertSwitchLableTag:
                    hTempCentering = ((messageLabel.frame.size.width - ([self.othersAlertSwitchLabel.text sizeWithFont:messageLabel.font].width + ALERT_VIEW_LABEL_PADDING + self.othersAlertSwitch.frame.size.width)) / 2);
                    
                    [self SetSwitchesLayout:messageLabel settedSwitch:self.othersAlertSwitch settedLabel:self.othersAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:180];
                    [self SetSwitchesLabelLayout:messageLabel settedSwitch:self.othersAlertSwitch settedLabel:self.othersAlertSwitchLabel horizontalCentering:hTempCentering increaseHeight:180];
                    break;
                default:
                    break;
            }
        }
    }
    
//    //Center new content.
//    CGSize alertSwitchLabelSize = [self.alertSwitchLabel.text sizeWithFont:messageLabel.font];
//    float horizontalCentering = (messageLabel.frame.size.width - (alertSwitchLabelSize.width + ALERT_VIEW_LABEL_PADDING + self.alertSwitch.frame.size.width)) / 2;
//    
//    
//    //Switch goes to the bottom right.
//    float switchVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - self.alertSwitch.frame.size.height ) / 2;
//    CGRect alertSwitchFrame = CGRectMake(messageLabel.frame.origin.x + messageLabel.frame.size.width - self.alertSwitch.frame.size.width - horizontalCentering,
//                                         messageLabel.frame.origin.y + messageLabel.frame.size.height - self.alertSwitch.frame.size.height - switchVerticalCentering,
//                                         self.alertSwitch.frame.size.width,
//                                         self.alertSwitch.frame.size.height);
//    self.alertSwitch.frame = alertSwitchFrame;
//    
//    //Label goes to the bottom left.    
//    float switchLabelVerticalCentering = ((ALERT_VIEW_LINE_HEIGHT * 2 + 1) - ALERT_VIEW_LINE_HEIGHT ) / 2;
//    CGRect alertSwitchLabelFrame = CGRectMake(round( messageLabel.frame.origin.x + horizontalCentering ),
//                                              round( messageLabel.frame.origin.y + messageLabel.frame.size.height - ALERT_VIEW_LINE_HEIGHT - switchLabelVerticalCentering ),
//                                              messageLabel.frame.size.width - self.alertSwitch.frame.size.width,
//                                              ALERT_VIEW_LINE_HEIGHT); //self.alertSwitchLabel.frame.size.height);
//    self.alertSwitchLabel.frame = alertSwitchLabelFrame;
//    
//    //Copy message label properties.
//    self.alertSwitchLabel.backgroundColor = [UIColor clearColor];   
//    self.alertSwitchLabel.textColor = messageLabel.textColor;
//    self.alertSwitchLabel.font = messageLabel.font;
//    self.alertSwitchLabel.shadowColor = messageLabel.shadowColor;
//    self.alertSwitchLabel.shadowOffset = messageLabel.shadowOffset;
//    
//    //Weaken.
//    self.alertSwitchLabel.alpha = ALERT_VIEW_LABEL_ALPHA;
    
    [super layoutSubviews];
}


@end
