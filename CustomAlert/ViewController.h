//
//  ViewController.h
//  CustomAlert
//
//  Created by Ben Morrison on 11/16/12.
//  Copyright (c) 2012 Ben Morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAlertDialog.h"

@interface ViewController : UIViewController <CustomAlertDialogDelgate>

@property (nonatomic) IBOutlet UIButton *AlertWithOneButton;
@property (nonatomic) IBOutlet UIButton *AlertWithTwoButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithThreeButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithFourButtons;
@property (nonatomic) IBOutlet UIButton *StandardUIAlert;

@end
