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
    UIView *alertView;        // View that Contains all
    UIView *titleView;        // View that holds the title (and border)
    UIView *messageView;      // View that holds the messsage (and button container
    UIScrollView *buttonView; // View that is the button container
    
    UITextView *messageText;
    UILabel *titleLabel;
    
    NSInteger TOTALNUMBEROFBUTTONS;
    CGFloat BORDERWIDTH;
    CGFloat BUTTONBORDERWIDTH;
    
    NSMutableArray *buttonList;
}

@property (nonatomic, assign) id DelegateClass;
@property (nonatomic, copy) NSString *messageTitle;
@property (nonatomic, copy) NSString *dialogMessage;
@property (nonatomic, copy) NSString *cancelButtonTitleString;
@property (nonatomic) NSMutableArray *otherButtonTitleStrings;

@property (nonatomic, setter = setAlertBackgroundColor:) UIColor *alertBackgroundColor;
@property (nonatomic, setter = setAlertBorderColor:) UIColor *alertBorderColor;
@property (nonatomic, setter = setCancelButtonColor:) UIColor *cancelButtonColor;
@property (nonatomic, setter = setOtherButtonsColor:) UIColor *otherButtonsColor;
@property (nonatomic, setter = setTextColor:) UIColor *textColor;


-(id)initWithTitle:(NSString *) titleMessage message:(NSString *) message delegate:(id) delegate cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION ;


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

