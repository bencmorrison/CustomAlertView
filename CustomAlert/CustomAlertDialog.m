//
//  CustomAlertDialog.m
//  CustomAlert
//
//  Created by Ben Morrison on 11/16/12.
//  Copyright (c) 2012 Ben Morrison. All rights reserved.
//


#import "CustomAlertDialog.h"

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

typedef NS_ENUM(NSInteger, CustomAlertDialogStyle) {
    CustomAlertDialogStyleDefault = 0,
    CustomAlertDialogStyleLight,
    CustomAlertDialogStyleDark
};

@implementation CustomAlertDialog
@synthesize DelegateClass, messageTitle, dialogMessage, cancelButtonTitleString, otherButtonTitleStrings;
@synthesize alertBorderColor, alertBackgroundColor, cancelButtonColor, otherButtonsColor, textColor;

-(id)initWithTitle:(NSString *) titleMessage message:(NSString *) message delegate:(id) delegate cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ... {
    
    BORDERWIDTH = 5.0f;
    BUTTONBORDERWIDTH = 4.0f;
    
    cancelButtonColor = [UIColor redColor];
    otherButtonsColor = [UIColor orangeColor];
    alertBorderColor = [UIColor blueColor];
    textColor = [UIColor whiteColor];
    alertBackgroundColor = [UIColor grayColor];
    
    CGRect appBounds = [[UIScreen mainScreen] bounds];
    
    self = [super initWithFrame: appBounds];
    
    if (self == nil) {
        return self;
    }
    
    
    messageTitle = titleMessage;
    dialogMessage = message;
    DelegateClass = delegate;
    
    cancelButtonTitleString = cancelButtonTitle;
    TOTALNUMBEROFBUTTONS = 1;
    otherButtonTitleStrings = [[NSMutableArray alloc] initWithCapacity:1];
    
    va_list nameArgs;
    va_start(nameArgs, otherButtonTitles);
    
    for (NSString *title = otherButtonTitles; title != nil; title = va_arg(nameArgs, NSString *)){
        [otherButtonTitleStrings addObject:[title copy]];
        TOTALNUMBEROFBUTTONS++;
    }
    
    va_end(nameArgs);
    
    buttonList = [[NSMutableArray alloc] initWithCapacity:1];
    
    [self prepAlertBoxWithFrame:appBounds];
    
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    
    return self;
    
}

-(void) show {
    
    if ([DelegateClass respondsToSelector:@selector(willPresentCustomAlertDialog:)]) {
        [DelegateClass willPresentCustomAlertDialog:self];
    }
    
    [[[[[[UIApplication sharedApplication] delegate] window] subviews] lastObject] addSubview:self];
    
    if ([DelegateClass respondsToSelector:@selector(didPresentCustomAlertDialog:)]) {
        [DelegateClass didPresentCustomAlertDialog:self];
    }
}

-(void) hideFromButtonPress:(NSInteger) _index {
    if ([DelegateClass respondsToSelector:@selector(customAlertDialog:willDismissWithButtonIndex:)]) {
        [DelegateClass customAlertDialog:self willDismissWithButtonIndex:_index];
    }
    
    [self setAlpha:0.0f];
    
    if ([DelegateClass respondsToSelector:@selector(customAlertDialog:didDismissWithButtonIndex:)]) {
        [DelegateClass customAlertDialog:self didDismissWithButtonIndex:_index];
    }
    
    [self removeFromSuperview];
}


-(void) prepAlertBoxWithFrame:(CGRect) frame {
    
    CGRect newFrame = frame;
    
    CGFloat height = frame.size.height * 0.65f;
    CGFloat width = frame.size.width * 0.9f;
    
    CGFloat heightDifference = frame.size.height - height;
    CGFloat widthDifference = frame.size.width - width;
    
    newFrame.origin.x = widthDifference / 2.0f;
    newFrame.origin.y = (heightDifference / 2.0f) - 10.0f;
    newFrame.size.height = height;
    newFrame.size.width = width;
    
    
    alertView = [[UIView alloc] initWithFrame:newFrame];
    alertView.backgroundColor = [UIColor clearColor];
    
    [self createTitleViewWithMaxWidth: width];
    
    [self createMessageViewWithMaxWidth: width andHeight: height];
    
    
    buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    buttonView.backgroundColor = [UIColor clearColor];
    
    [alertView addSubview:messageView];
    [alertView addSubview:titleView];
    
    
    [self addSubview:alertView];
}

-(void) createTitleViewWithMaxWidth:(CGFloat) _maxWidth {
    CGFloat widthOfTitleLabel = _maxWidth * 0.8f;
    CGFloat xPos = (_maxWidth - widthOfTitleLabel) / 2.0f;
    
    CGFloat DOUBLEBORDERWIDTH = (BORDERWIDTH * 2);
    CGFloat fontSize = 20.0f;
    CGFloat labelHeight = 20.0f;
    CGFloat labelWidth = widthOfTitleLabel - DOUBLEBORDERWIDTH;
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(xPos, 0, widthOfTitleLabel, labelHeight + DOUBLEBORDERWIDTH)];
    titleView.backgroundColor = alertBackgroundColor;
    titleView.layer.borderWidth = BORDERWIDTH;
    titleView.layer.borderColor = alertBorderColor.CGColor;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BORDERWIDTH, BORDERWIDTH, labelWidth, labelHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [titleLabel setText:messageTitle];
    [titleLabel setTextColor:textColor];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    
    [titleView addSubview:titleLabel];
}

-(void) createMessageViewWithMaxWidth:(CGFloat) _maxWidth andHeight:(CGFloat) _maxHeight {
    CGRect titleViewFrame = titleView.frame;
    CGFloat DOUBLEBORDERWIDTH = (BORDERWIDTH * 2);
    
    CGFloat yPos = (titleViewFrame.size.height - BORDERWIDTH) / 2;
    CGFloat messageViewHeight = _maxHeight - yPos;
    
    CGFloat buttonBoxHeight = [self buttonViewHeight];
    
    messageView = [[UIView alloc] initWithFrame:CGRectMake(0, yPos, _maxWidth, messageViewHeight)];
    messageView.backgroundColor = alertBackgroundColor;
    messageView.layer.borderWidth = BORDERWIDTH;
    messageView.layer.borderColor = alertBorderColor.CGColor;
    
    
    messageText = [[UITextView alloc] initWithFrame:CGRectMake(BORDERWIDTH, yPos + BORDERWIDTH, _maxWidth - DOUBLEBORDERWIDTH, messageViewHeight - yPos - DOUBLEBORDERWIDTH - buttonBoxHeight)];
    
    [messageText setEditable:NO];
    [messageText setBackgroundColor:[UIColor clearColor]];
    [messageText setTextColor:textColor];
    
    [messageText setText:dialogMessage];
    
    [messageView addSubview:messageText];
    
    [self createButtonsWithMaxWidth:_maxWidth andMessageBottom:(messageText.frame.size.height + yPos + BORDERWIDTH)];
}

-(void) createButtonsWithMaxWidth:(CGFloat) _maxWidth andMessageBottom:(CGFloat) _messageHeight {
    CGFloat DOUBLEBORDERWIDTH = (BORDERWIDTH * 2);
    CGFloat viewHeight = [self buttonViewHeight];
    CGFloat buttonHeight = 44.0f;
    
    CGRect titleViewFrame = titleView.frame;
    
    buttonView = [[UIScrollView alloc] initWithFrame:CGRectMake(BORDERWIDTH, _messageHeight, _maxWidth - DOUBLEBORDERWIDTH, viewHeight)];
    buttonView.delegate = self;
    buttonView.pagingEnabled = YES;
    
    
    [buttonView setBackgroundColor:[UIColor colorWithRed:0.0f green:1.0f blue:0.5f alpha:0.5f]];//[UIColor clearColor]];
    
    CGPoint topButtonOrgin = CGPointMake(titleViewFrame.origin.x - BORDERWIDTH, 5);
    CGPoint bottomButtonOrgin = CGPointMake(titleViewFrame.origin.x - BORDERWIDTH, buttonHeight + 10);
    
    if (TOTALNUMBEROFBUTTONS <= 1) {
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, titleViewFrame.size.width, buttonHeight) andIsCancelButton:YES];
        
        
        [buttonView addSubview:cancelButton];
        
    } else if (TOTALNUMBEROFBUTTONS == 2) {
        
        UIButton *otherButton = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:0] withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, titleViewFrame.size.width, buttonHeight) andIsCancelButton:NO];
        
        
        [buttonView addSubview:otherButton];
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, titleViewFrame.size.width, buttonHeight) andIsCancelButton:YES];
    
        [buttonView addSubview:cancelButton];
        
    } else if (TOTALNUMBEROFBUTTONS == 3) {
        CGFloat halfWidth = titleViewFrame.size.width / 2;
        
        UIButton *otherButton = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:0] withFrame:CGRectMake(topButtonOrgin.x, topButtonOrgin.y, halfWidth - 5, buttonHeight) andIsCancelButton:NO];
        
        [buttonView addSubview:otherButton];
        
        
        UIButton *otherButton2 = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:1] withFrame:CGRectMake(topButtonOrgin.x  + halfWidth + 5, topButtonOrgin.y, halfWidth - 5, buttonHeight) andIsCancelButton:NO];
        
        [buttonView addSubview:otherButton2];
        
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, titleViewFrame.size.width, buttonHeight) andIsCancelButton:YES];
        
        [buttonView addSubview:cancelButton];
        
    } else {
        
        CGFloat width = titleViewFrame.size.width - 10;
        
        CGRect scrollTopButton = CGRectMake(topButtonOrgin.x, topButtonOrgin.y, width, buttonHeight);
        CGRect scrollBottomButton = CGRectMake(bottomButtonOrgin.x, bottomButtonOrgin.y, width, buttonHeight);
        
        UIButton *cancelButton = [self createButtonWithTitle:cancelButtonTitleString withFrame:scrollBottomButton andIsCancelButton:YES];
        
        
        [buttonView addSubview:cancelButton];
        
        for (int i = 0; i < [otherButtonTitleStrings count]; ++i) {
            UIButton *btn = [self createButtonWithTitle:[otherButtonTitleStrings objectAtIndex:i]
                                              withFrame:(i % 2 == 0) ? scrollTopButton : scrollBottomButton
                                      andIsCancelButton:NO];
            
            [buttonView addSubview:btn];
            
            if ( i % 2 == 1) {
                scrollTopButton = CGRectMake(scrollTopButton.origin.x + width + 5, scrollTopButton.origin.y, width, buttonHeight);
            } else {
                scrollBottomButton = CGRectMake(scrollBottomButton.origin.x + width + 5, scrollBottomButton.origin.y, width, buttonHeight);
            }
        }
    }
    
    
    [messageView addSubview:buttonView];
    
    
}

-(CGFloat) buttonViewHeight {
    if (TOTALNUMBEROFBUTTONS > 1) {
        return 104.0f;
    }
    
    return 54.0f;
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
# pragma mark BUTTON WORK

-(void) buttonPressed:(UIButton *) _sender {
    NSInteger index = [buttonList indexOfObject:_sender];
    
    DLog(@"Button Pressed! at index: %i", index);
    
    if ([DelegateClass respondsToSelector:@selector(customAlertDialog:clickedButtonAtIndex:)]) {
        [DelegateClass customAlertDialog:self clickedButtonAtIndex:index];
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



#pragma mark -
#pragma mark EXTRAS

@end
