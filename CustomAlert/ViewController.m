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
@synthesize AlertWithOneButton, AlertWithTwoButtons, AlertWithThreeButtons, AlertWithFourButtons, StandardUIAlert;


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
        CustomAlertDialog *cAlert = [[CustomAlertDialog alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", @"Button 2", @"Button 3", nil];
        [cAlert show];
    } else if (sender == AlertWithOneButton) {
        CustomAlertDialog *cAlert = [[CustomAlertDialog alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:nil];
        [cAlert show];
    } else if (sender == AlertWithThreeButtons) {
        CustomAlertDialog *cAlert = [[CustomAlertDialog alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Cancel"
                                                           otherButtonTitles:@"Button 1", @"Button 2", nil];
        [cAlert show];
    } else if (sender == AlertWithTwoButtons) {
        CustomAlertDialog *cAlert = [[CustomAlertDialog alloc] initWithTitle:@"Test Title"
                                                                     message:@"This is a test message"
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
    }
    
    
    
    
}


-(void)customAlertDialog:(CustomAlertDialog *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"We have a Delegate Button Press at index: %i", buttonIndex);
}

-(void) customAlertDialogCancel:(CustomAlertDialog *)alertView {
    NSLog(@"Cancel being called, no button click");
}

-(void) willPresentCustomAlertDialog:(CustomAlertDialog *)alertView {
    NSLog(@"Custom Alert View will get presented");
}

-(void) didPresentCustomAlertDialog:(CustomAlertDialog *)alertView {
    NSLog(@"Custom AlertView did get prestented");
}

-(void)customAlertDialog:(CustomAlertDialog *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"AlertDialog will be closing due to button at index: %i", buttonIndex);
}

-(void)customAlertDialog:(CustomAlertDialog *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"AlertDialog did close due to button at index: %i", buttonIndex);
}
/*
-(BOOL)customAlertDialogShouldEnableFirstOtherButton:(CustomAlertDialog *)alertView {
    NSLog(@"This shouldn't get called");
    
    return false;
}
*/

@end
