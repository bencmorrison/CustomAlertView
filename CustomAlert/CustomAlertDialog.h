//
//  CustomAlertDialog.h
//  CustomAlert
//
//  Created by Ben Morrison on 11/16/12.
//  Copyright (c) 2012 Ben Morrison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol CustomAlertDialogDelgate;


@interface CustomAlertDialog : UIView <UIScrollViewDelegate> {
@private
    UIView *alertView;              // View that Contains all
    UIView *titleView;              // View that holds the title (and border)
    UIView *messageView;            // View that holds the messsage (and button container
    UIScrollView *buttonView;       // View that is the button container
    
    UITextView *messageText;        // The actual message view
    UILabel *titleLabel;            // The actual alert title label
    
    NSInteger TOTALNUMBEROFBUTTONS; // Total buttons to show on the view
    CGFloat BORDERWIDTH;            // Border Width on views (buttons are -1 of this number)
    CGFloat DOUBLEBORDERWIDTH;      // Double the border width
    CGFloat BUTTONBORDERWIDTH;      // Border width on buttons (usually -1 of BORDERWIDTH)
    CGFloat DOUBLEBUTTONBORERWIDTH; // DOuble button border width
    CGFloat BUTTONHEIGHT;
    CGFloat BUTTONSPACER;
    BOOL NOMESSAGEOVERRIDE;         // If only a title is given, this will pretend they entred a message only.
    BOOL NOTITLEGIVEN;
    BOOL INITED;
    CGFloat TITLEFONTSIZE;
    CGFloat MESSAGEFONTSIZE;
    
    CGRect ContainingFrame;
    CGRect TitleViewFrame;
    CGRect MessageViewFrame;
    CGRect MessageTextFrame;
    CGRect ButtonViewFrame;
    
    NSMutableArray *buttonList;     // List of buttons on the alert dialog
}


@property (nonatomic, assign) id DelegateClass;                 
@property (nonatomic, copy) NSString *messageTitle;             // The Title to be displayed on the view
@property (nonatomic, copy) NSString *dialogMessage;            // The Message to be displayed on the view
@property (nonatomic, copy) NSString *cancelButtonTitleString;  // The Cancel Button's Title
@property (nonatomic) NSMutableArray *otherButtonTitleStrings;  // The array of button names given


@property (nonatomic, setter = setAlertBackgroundColor:) UIColor *alertBackgroundColor;
@property (nonatomic, setter = setAlertBorderColor:) UIColor *alertBorderColor;
@property (nonatomic, setter = setCancelButtonColor:) UIColor *cancelButtonColor;
@property (nonatomic, setter = setOtherButtonsColor:) UIColor *otherButtonsColor;
@property (nonatomic, setter = setTextColor:) UIColor *textColor;

-(id)initWithTitle:(NSString *) titleMessage message:(NSString *) message delegate:(id) delegate cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

-(void) show;


@end





@protocol CustomAlertDialogDelgate <NSObject>
@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)customAlertDialog:(CustomAlertDialog *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)customAlertDialogCancel:(CustomAlertDialog *)alertView;

- (void)willPresentCustomAlertDialog:(CustomAlertDialog *)alertView;  // before animation and showing view
- (void)didPresentCustomAlertDialog:(CustomAlertDialog *)alertView;  // after animation

- (void)customAlertDialog:(CustomAlertDialog *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view
- (void)customAlertDialog:(CustomAlertDialog *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

// Called after edits in any of the default fields added by the style
- (BOOL)customAlertDialogShouldEnableFirstOtherButton:(CustomAlertDialog *)alertView;

@end