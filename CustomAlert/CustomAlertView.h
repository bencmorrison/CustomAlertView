/*
 * CustomAlertView.h
 *
 * Created by Ben Morrison on 11/16/12.
 * Copyright (c) 2011, Ben Morrison. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of Ben Morrison nor the names of its contributors may
 *    be used to endorse or promote products derived from this software without
 *    specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL BEN MORRISON BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@protocol CustomAlertViewDelgate;


@interface CustomAlertView : UIView <UIScrollViewDelegate> {
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
    BOOL NOTITLEGIVEN;              // If not title is given this will be NO
    CGFloat TITLEFONTSIZE;          // Font size of the title
    CGFloat MESSAGEFONTSIZE;        // Font size of the message
    
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





@protocol CustomAlertViewDelgate <NSObject>
@optional

// Called when a button is clicked. CustomAlertView will be automatically dismissed upon return.
- (void)CustomAlertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

// Called before the CustomAlertView animates in.
- (void)willPresentCustomAlertView:(CustomAlertView *)alertView;
// Called after the CustomAlertView is done animating.
- (void)didPresentCustomAlertView:(CustomAlertView *)alertView;

// Called before animating out and hiding the view.
- (void)CustomAlertView:(CustomAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
// Called after animating out and hiding the view. Opaque background is not removed till call is finished.
- (void)CustomAlertView:(CustomAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

// TODO: Create the ability for these to be called to match the Apple call.
//- (void)CustomAlertViewCancel:(CustomAlertView *)alertView;
// Called after edits in any of the default fields added by the style
//- (BOOL)CustomAlertViewShouldEnableFirstOtherButton:(CustomAlertView *)alertView;

@end