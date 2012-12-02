//
//  ViewController.m
//  CustomAlert
//
//  Created by Ben Morrison on 11/16/12.
//  Copyright (c) 2012 Ben Morrison. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CustomAlertDialog *cAlert = [[CustomAlertDialog alloc] initWithTitle:@"Test Title"
                                                                 message:@"This is a test message"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"Button 1", @"Button 2", nil];
    [cAlert show];
    [self.view addSubview:cAlert];
    
    cAlert.cancelButtonColor = [UIColor yellowColor];
    cAlert.otherButtonsColor = [UIColor purpleColor];
    cAlert.backgroundColor = [UIColor greenColor];
    cAlert.borderColor = [UIColor orangeColor];
    cAlert.textColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
