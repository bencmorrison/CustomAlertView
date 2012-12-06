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
@synthesize AlertWithOneButton, AlertWithTwoButtons, AlertWithThreeButtons, AlertWithFourButtons, AlertWithFiveButtons, StandardUIAlert, AlertTitleOnly, AlertMessageOnly;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showAlert:(id)sender {
    
    if (sender == AlertWithFourButtons) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", nil];
        [cAlert show];
    } else if (sender == AlertWithOneButton) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:nil];
        [cAlert show];
    } else if (sender == AlertWithThreeButtons) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", @"Button 2", nil];
        [cAlert show];
    } else if (sender == AlertWithTwoButtons) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message This is a test message "
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", nil];
        [cAlert show];
    } else if (sender == StandardUIAlert) {
        UIAlertView *cAlert = [[UIAlertView alloc] initWithTitle:@"Test Title"
                                                         message:@"This is a test message"
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", nil];
        [cAlert show];
    } else if (sender == AlertTitleOnly) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:nil
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:nil];
        [cAlert show];
    } else if (sender == AlertMessageOnly) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:nil
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:nil];
        [cAlert show];
    } else if (AlertWithFiveButtons == sender) {
        CustomAlertView *cAlert = [[CustomAlertView alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", @"Button 4", nil];
        [cAlert show];
    }
    
    
    
    
}


-(void)CustomAlertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"We have a Delegate Button Press at index: %i", buttonIndex);
}

/*
-(void) CustomAlertViewCancel:(CustomAlertView *)alertView {
    NSLog(@"Cancel being called, no button click");
}
*/

-(void) willPresentCustomAlertView:(CustomAlertView *)alertView {
    NSLog(@"Custom Alert View will get presented");
}

-(void) didPresentCustomAlertView:(CustomAlertView *)alertView {
    NSLog(@"Custom AlertView did get prestented");
}

-(void)CustomAlertView:(CustomAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"AlertDialog will be closing due to button at index: %i", buttonIndex);
}

-(void)CustomAlertView:(CustomAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"AlertDialog did close due to button at index: %i", buttonIndex);
}
/*
-(BOOL)CustomAlertViewShouldEnableFirstOtherButton:(CustomAlertView *)alertView {
    NSLog(@"This shouldn't get called");
    
    return false;
}
*/

@end
