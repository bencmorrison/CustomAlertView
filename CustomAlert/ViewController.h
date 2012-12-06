//
//  ViewController.h
//  CustomAlert
//
//  Created by Ben Morrison on 11/16/12.
//  Copyright (c) 2012 Ben Morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertView.h"

@interface ViewController : UIViewController <CustomAlertViewDelgate>

@property (nonatomic) IBOutlet UIButton *AlertWithOneButton;
@property (nonatomic) IBOutlet UIButton *AlertWithTwoButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithThreeButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithFourButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithFiveButtons;
@property (nonatomic) IBOutlet UIButton *AlertTitleOnly;
@property (nonatomic) IBOutlet UIButton *AlertMessageOnly;
@property (nonatomic) IBOutlet UIButton *StandardUIAlert;

@end
