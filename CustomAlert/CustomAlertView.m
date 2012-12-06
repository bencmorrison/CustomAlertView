/*
 * CustomAlertView.m
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


#import "CustomAlertView.h"


@implementation CustomAlertView
@synthesize DelegateClass, messageTitle, dialogMessage, cancelButtonTitleString, otherButtonTitleStrings;
@synthesize alertBorderColor, alertBackgroundColor, cancelButtonColor, otherButtonsColor, textColor;


-(id)initWithTitle:(NSString *) titleMessage message:(NSString *) message delegate:(id) delegate cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ... {
    
    CGRect appBounds = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame: appBounds];
    if (self == nil) {
        return self;
    }
    
    // Constants After Init
    BORDERWIDTH = 5.0f;
    DOUBLEBORDERWIDTH = BORDERWIDTH * 2.0f;
    BUTTONBORDERWIDTH = 4.0f;
    BUTTONSPACER = 5.0f;
    DOUBLEBUTTONBORERWIDTH = BUTTONBORDERWIDTH * 2.0f;
    TOTALNUMBEROFBUTTONS = 1;
    BUTTONHEIGHT = 44.0f;
    NOMESSAGEOVERRIDE = (message == nil);
    NOTITLEGIVEN = (titleMessage == nil);
    TITLEFONTSIZE = 20.0f;
    MESSAGEFONTSIZE = 18.0f;
    
    alertBackgroundColor = [UIColor colorWithRed:0.20 green:0.20f blue:0.20f alpha:1.0f];
    alertBorderColor = [UIColor colorWithRed:0.68f green:0.15f blue:0.0f alpha:1.0f];
    cancelButtonColor = [UIColor colorWithRed:1.0f green:0.34f blue:0.0f alpha:1.0f];
    otherButtonsColor = [UIColor colorWithRed:1.0f green:0.87f blue:0.41f alpha:1.0f];
    textColor = [UIColor colorWithRed:1.0f green:1.0f blue:0.89f alpha:1.0f];
    
    // User Entered Information
    messageTitle = titleMessage;
    dialogMessage = message;
    DelegateClass = delegate;
    
    cancelButtonTitleString = cancelButtonTitle;
    otherButtonTitleStrings = [[NSMutableArray alloc] initWithCapacity:1];
    
    va_list nameArgs;
    va_start(nameArgs, otherButtonTitles);
    
    for (NSString *title = otherButtonTitles; title != nil; title = va_arg(nameArgs, NSString *)){
        [otherButtonTitleStrings addObject:[title copy]];
        TOTALNUMBEROFBUTTONS++;
    }
    
    va_end(nameArgs);
    
    buttonList = [[NSMutableArray alloc] initWithCapacity:TOTALNUMBEROFBUTTONS];
    
    // Build Dialog
    [self calculateFrames:appBounds];
    [self createContainingFrame];
    [self createMessageView];
    if (!NOMESSAGEOVERRIDE && !NOTITLEGIVEN) { [self createTitleView]; }
    [self createButtonView];
    
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    
    return self;
    
}








#pragma mark -
#pragma mark PREP ALERT BOX

-(void) calculateFrames:(CGRect) _frame {
    CGFloat height = _frame.size.height * 0.65f;
    CGFloat width = _frame.size.width * 0.9f;
    
    TitleViewFrame.origin.x = (width - (width * 0.8f)) / 2.0f;
    TitleViewFrame.origin.y = 0.0f;
    TitleViewFrame.size.width = (width * 0.8f);
    
    CGFloat titleHeight = ([messageTitle sizeWithFont:[UIFont boldSystemFontOfSize:TITLEFONTSIZE] forWidth:TitleViewFrame.size.width lineBreakMode:NSLineBreakByWordWrapping].height + (BORDERWIDTH * 2.0f));
    
    TitleViewFrame.size.height = titleHeight;
    
    MessageViewFrame.origin.x = 0.0f;
    MessageViewFrame.origin.y = (TitleViewFrame.size.height - BORDERWIDTH) / 2.0f;
    MessageViewFrame.size.width = width;
    
    CGFloat maxHeight = height - [self buttonViewHeight] - DOUBLEBORDERWIDTH - titleHeight - MessageViewFrame.origin.y;
    CGFloat minHeight = 30.f;
    CGFloat messageTextHeight = [dialogMessage sizeWithFont:[UIFont systemFontOfSize:MESSAGEFONTSIZE] constrainedToSize:CGSizeMake(width - BORDERWIDTH, maxHeight) lineBreakMode:NSLineBreakByWordWrapping].height + DOUBLEBORDERWIDTH;
    
    if (messageTextHeight < minHeight) {
        messageTextHeight = minHeight;
    }

    MessageTextFrame.origin.x = 0.0f;
    MessageTextFrame.origin.y = MessageViewFrame.origin.y + DOUBLEBORDERWIDTH;
    MessageTextFrame.size.height = messageTextHeight + BORDERWIDTH;
    MessageTextFrame.size.width = width - DOUBLEBORDERWIDTH;
    
    ButtonViewFrame.origin.x = ((width - TitleViewFrame.size.width) / 2.0f);
    ButtonViewFrame.origin.y = MessageTextFrame.size.height + MessageTextFrame.origin.y;
    ButtonViewFrame.size.height = [self buttonViewHeight];
    ButtonViewFrame.size.width = TitleViewFrame.size.width + BUTTONSPACER;
    
    MessageViewFrame.size.height = MessageTextFrame.size.height + ButtonViewFrame.size.height + TitleViewFrame.size.height;
    
    if (titleHeight < 30.0f) {
        MessageViewFrame.size.height = MessageViewFrame.size.height + 20;
    }
    
    if (dialogMessage == nil) {
        MessageTextFrame.origin.y = DOUBLEBORDERWIDTH;
    }
    
    ContainingFrame.origin.x = 0.0f;
    ContainingFrame.origin.y = 0.0f;
    ContainingFrame.size.height = MessageViewFrame.size.height + (TitleViewFrame.size.height / 2.0f);
    ContainingFrame.size.width = width;
}




-(CGFloat) buttonViewHeight {
    if (TOTALNUMBEROFBUTTONS > 1) {
        return 104.0f;
    }
    
    return 54.0f;
}








#pragma mark -
#pragma mark SHOW AND HIDE ALERT

-(void) show {
    [[[[[[UIApplication sharedApplication] delegate] window] subviews] lastObject] addSubview:self];
    
    if ([DelegateClass respondsToSelector:@selector(willPresentCustomAlertView:)]) {
        [DelegateClass willPresentCustomAlertView:self];
    }
    
    
    CGAffineTransform trans = CGAffineTransformScale(alertView.transform, 0.01, 0.01);
    alertView.transform = trans;
    
    [self addSubview:alertView];

    
    [UIView animateWithDuration:0.15f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         alertView.transform = CGAffineTransformScale(alertView.transform, 100.0, 100.0);
                     }
                     completion:^(BOOL finished){
                        if ([DelegateClass respondsToSelector:@selector(didPresentCustomAlertView:)]) {
                            [DelegateClass didPresentCustomAlertView:self];
                        }
                    }];
}




-(void) hideFromButtonPress:(NSInteger) _index {
    if ([DelegateClass respondsToSelector:@selector(CustomAlertView:willDismissWithButtonIndex:)]) {
        [DelegateClass CustomAlertView:self willDismissWithButtonIndex:_index];
    }
    
    [UIView animateWithDuration:0.15f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         alertView.transform = CGAffineTransformScale(self.transform, 0.01, 0.01);
                     }
                     completion:^(BOOL finished) {
                         [alertView removeFromSuperview];
                         if ([DelegateClass respondsToSelector:@selector(CustomAlertView:didDismissWithButtonIndex:)]) {
                             [DelegateClass CustomAlertView:self didDismissWithButtonIndex:_index];
                         }
                         
                         [self removeFromSuperview];
                     }];
}








#pragma mark -
#pragma mark CREATE VIEWS
-(void) createContainingFrame {
    alertView = [[UIView alloc] initWithFrame:ContainingFrame];
    alertView.backgroundColor = [UIColor clearColor];
    alertView.center = self.center;
}



-(void) createTitleView {
    CGFloat labelWidth = TitleViewFrame.size.width - DOUBLEBORDERWIDTH;
    
    UIView *containerView = [[UIView alloc] initWithFrame:TitleViewFrame];
    containerView.backgroundColor = alertBackgroundColor;
    containerView.layer.borderWidth = BORDERWIDTH;
    containerView.layer.borderColor = alertBorderColor.CGColor;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BORDERWIDTH, BORDERWIDTH + 1.0f, labelWidth, [messageTitle sizeWithFont:[UIFont boldSystemFontOfSize:TITLEFONTSIZE] forWidth:labelWidth lineBreakMode:NSLineBreakByTruncatingTail].height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [titleLabel setText:messageTitle];
    [titleLabel setTextColor:textColor];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:TITLEFONTSIZE]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [containerView addSubview:titleLabel];
    
    [alertView addSubview:containerView];
}




-(void) createMessageView {
    messageView = [[UIView alloc] initWithFrame:MessageViewFrame];
    messageView.backgroundColor = alertBackgroundColor;
    messageView.layer.borderWidth = BORDERWIDTH;
    messageView.layer.borderColor = alertBorderColor.CGColor;
    messageView.clipsToBounds = YES;
    
    
    messageText = [[UITextView alloc] initWithFrame:MessageTextFrame];
    
    [messageText setEditable:NO];
    [messageText setBackgroundColor:[UIColor clearColor]];
    [messageText setTextColor:textColor];
    
    if (NOMESSAGEOVERRIDE) {
        [messageText setText:messageTitle];
        [messageText setFont:[UIFont boldSystemFontOfSize:TITLEFONTSIZE]];
        [messageText setTextAlignment:NSTextAlignmentCenter];
    } else {
        [messageText setText:dialogMessage];
        [messageText setFont:[UIFont systemFontOfSize:MESSAGEFONTSIZE]];
        [messageText setTextAlignment:NSTextAlignmentCenter];
    }
    
    [messageView addSubview:messageText];
    
    [alertView addSubview:messageView];
}



-(void) createButtonView {
    buttonView = [[UIScrollView alloc] initWithFrame:ButtonViewFrame];
    buttonView.delegate = self;
    buttonView.scrollEnabled = YES;
    buttonView.bounces = NO;
    buttonView.scrollEnabled = YES;
    buttonView.minimumZoomScale = 1.0f;
    buttonView.maximumZoomScale = 1.0f;
    buttonView.pagingEnabled = YES;
    buttonView.clipsToBounds = NO;
    buttonView.showsHorizontalScrollIndicator = NO;
    buttonView.showsVerticalScrollIndicator = NO;
    buttonView.backgroundColor = [UIColor clearColor];
    
    CGPoint topButtonOrgin = CGPointMake(0, 5);
    CGPoint bottomButtonOrgin = CGPointMake(0, BUTTONHEIGHT + 10);
    
    if (TOTALNUMBEROFBUTTONS <= 1) {
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, TitleViewFrame.size.width, BUTTONHEIGHT) andIsCancelButton:YES];
        
        
        [buttonView addSubview:cancelButton];
        
    } else if (TOTALNUMBEROFBUTTONS == 2) {
        
        UIButton *otherButton = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:0] withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, TitleViewFrame.size.width, BUTTONHEIGHT) andIsCancelButton:NO];
        
        
        [buttonView addSubview:otherButton];
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, TitleViewFrame.size.width, BUTTONHEIGHT) andIsCancelButton:YES];
    
        [buttonView addSubview:cancelButton];
        
    } else if (TOTALNUMBEROFBUTTONS == 3) {
        CGFloat halfWidth = TitleViewFrame.size.width / 2;
        
        UIButton *otherButton = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:0] withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, halfWidth - 5, BUTTONHEIGHT) andIsCancelButton:NO];
        
        [buttonView addSubview:otherButton];
        
        
        UIButton *otherButton2 = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:1] withFrame:CGRectMake(topButtonOrgin.x  + halfWidth + 5, topButtonOrgin.y, halfWidth - 5, BUTTONHEIGHT) andIsCancelButton:NO];
        
        [buttonView addSubview:otherButton2];
        
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, TitleViewFrame.size.width, BUTTONHEIGHT) andIsCancelButton:YES];
        
        [buttonView addSubview:cancelButton];
        
    } else {
        
        CGFloat width = ButtonViewFrame.size.width - BUTTONSPACER;
        
        CGRect scrollTopButton = CGRectMake(topButtonOrgin.x, topButtonOrgin.y, width, BUTTONHEIGHT);
        CGRect scrollBottomButton = CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, width, BUTTONHEIGHT);
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:scrollBottomButton andIsCancelButton:YES];
        
        [buttonView addSubview:cancelButton];
        
        for (int i = 0; i < [otherButtonTitleStrings count]; ++i) {
            CGRect btnFrame = (i % 2 == 0) ? scrollTopButton : scrollBottomButton;
            
            if (i == ([otherButtonTitleStrings count] - 1) && i % 2 == 1) {
                // We want the button to be on top...
                btnFrame = scrollTopButton = CGRectMake(scrollTopButton.origin.x + width + 5, scrollTopButton.origin.y, width, BUTTONHEIGHT);
            }
            
            UIButton *btn = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:i]
                                              withFrame:btnFrame
                                      andIsCancelButton:NO];
            
            [buttonView addSubview:btn];
            
            if ( i % 2 == 1) {
                scrollTopButton = CGRectMake(scrollTopButton.origin.x + width + 5, scrollTopButton.origin.y, width, BUTTONHEIGHT);
            } else {
                scrollBottomButton = CGRectMake(scrollBottomButton.origin.x + width + 5, scrollBottomButton.origin.y, width, BUTTONHEIGHT);
            }
        }
        
        int totalColumns = (TOTALNUMBEROFBUTTONS % 2 == 0) ? (TOTALNUMBEROFBUTTONS / 2.0f) : ((TOTALNUMBEROFBUTTONS + 1) / 2.0f);
        CGFloat contentWidth = (width + 5.0f) * totalColumns;
        buttonView.contentSize = CGSizeMake(contentWidth, (BUTTONHEIGHT * 2.0));
    }
    
    
    [messageView addSubview:buttonView];
}








#pragma mark -
#pragma mark BUTTON STUFF

-(UIButton *) createButtonWithTitle:(NSString *)_title withFrame:(CGRect) _frame andIsCancelButton:(BOOL) _isCancel {
    UIButton *button = [[UIButton alloc] initWithFrame:_frame];
    
    [button setTitle:_title forState:UIControlStateNormal];
         
    [button setBackgroundColor:alertBackgroundColor];
    button.layer.borderWidth = BUTTONBORDERWIDTH;
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_isCancel) {
        button.layer.borderColor = cancelButtonColor.CGColor;
        
        [buttonList insertObject:button atIndex:0];
    } else {
        button.layer.borderColor = otherButtonsColor.CGColor;
        
        [buttonList addObject:button];
    }
    
    return button;
}








# pragma mark -
# pragma mark BUTTON STUFF

-(void) buttonPressed:(UIButton *) _sender {
    NSInteger index = [buttonList indexOfObject:_sender];
    
    if ([DelegateClass respondsToSelector:@selector(CustomAlertView:clickedButtonAtIndex:)]) {
        [DelegateClass CustomAlertView:self clickedButtonAtIndex:index];
    }
    
    [self hideFromButtonPress:index];
}








# pragma mark -
# pragma mark COLOR SETTERS

-(void) setAlertBackgroundColor:(UIColor *)_backgroundColor {
    alertBackgroundColor = _backgroundColor;
    
    [titleView setBackgroundColor:_backgroundColor];
    [messageView setBackgroundColor:_backgroundColor];
    
    for (int i = 0; i < [buttonList count]; ++i) {
        UIButton *btn = [buttonList objectAtIndex:i];
        [btn setBackgroundColor:_backgroundColor];
    }
}



-(void) setAlertBorderColor:(UIColor *)_borderColor {
    alertBorderColor = _borderColor;
    
    [titleView.layer setBorderColor:_borderColor.CGColor];
    [messageView.layer setBorderColor:_borderColor.CGColor];
}



-(void) setCancelButtonColor:(UIColor *)_cancelButtonColor {
    cancelButtonColor = _cancelButtonColor;
    
    if ([buttonList count] > 0) {
        UIButton *btn = [buttonList objectAtIndex:0];
        btn.layer.borderColor = _cancelButtonColor.CGColor;
    }
}



-(void) setOtherButtonsColor:(UIColor *)_otherButtonsColor {
    otherButtonsColor = _otherButtonsColor;
    
    for (int i = 1; i < [buttonList count]; ++i) {
        UIButton *btn = [buttonList objectAtIndex:i];
        btn.layer.borderColor = _otherButtonsColor.CGColor;
    }
}



-(void) setTextColor:(UIColor *)_textColor {
    textColor = _textColor;
    
    [messageText setTextColor:_textColor];
    [titleLabel setTextColor:_textColor];
    
    for (int i = 0; i < [buttonList count]; ++i) {
        UIButton *btn = [buttonList objectAtIndex:i];
        [btn setTitleColor:_textColor forState:UIControlStateNormal];
    }
}


@end
