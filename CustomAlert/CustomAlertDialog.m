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
@synthesize borderColor, backgroundColor, cancelButtonColor, otherButtonsColor, textColor;

-(id)initWithTitle:(NSString *) titleMessage message:(NSString *) message delegate:(id) delegate cancelButtonTitle:(NSString *) cancelButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ... {
    
    BORDERWIDTH = 5.0f;
    BUTTONBORDERWIDTH = 4.0f;
    
    cancelButtonColor = [UIColor redColor];
    otherButtonsColor = [UIColor orangeColor];
    
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
    TOTALNUMBEROFBUTTONS = 3;
    
    buttonList = [[NSMutableArray alloc] initWithCapacity:1];
    
    self.backgroundColor = [UIColor clearColor];
    [self finalizeBackground];
    [self prepAlertBoxWithFrame:appBounds];
    
    return self;
    
}


-(void) show {    
    [[[[[[UIApplication sharedApplication] delegate] window] subviews] lastObject] addSubview:self];
}

-(void) finalizeBackground {
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
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
    buttonView.backgroundColor = [UIColor greenColor];
    
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
    titleView.backgroundColor = [UIColor grayColor];
    titleView.layer.borderWidth = BORDERWIDTH;
    titleView.layer.borderColor = [UIColor blueColor].CGColor;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BORDERWIDTH, BORDERWIDTH, labelWidth, labelHeight)];
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [titleLabel setText:messageTitle];
    [titleLabel setTextColor:[UIColor whiteColor]];
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
    messageView.backgroundColor = [UIColor grayColor];
    messageView.layer.borderWidth = BORDERWIDTH;
    messageView.layer.borderColor = [UIColor blueColor].CGColor;
    
    
    messageText = [[UITextView alloc] initWithFrame:CGRectMake(BORDERWIDTH, yPos + BORDERWIDTH, _maxWidth - DOUBLEBORDERWIDTH, messageViewHeight - yPos - DOUBLEBORDERWIDTH - buttonBoxHeight)];
    
    [messageText setEditable:NO];
    [messageText setBackgroundColor:[UIColor clearColor]];
    [messageText setTextColor:[UIColor whiteColor]];
    
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
    
    
    [buttonView setBackgroundColor:[UIColor colorWithRed:0.0f green:1.0f blue:0.5f alpha:0.5f]];//[UIColor yellowColor]];
    
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
         
    [button setBackgroundColor:[UIColor grayColor]];
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

-(NSInteger) buttonPressed:(UIButton *) _sender {
    NSInteger index = [buttonList indexOfObject:_sender];
    
    DLog(@"Button Pressed! at index: %i", index);
    
    return index;
}


# pragma mark -
# pragma mark COLOR SETTERS

-(void) setBackgroundColor:(UIColor *)_backgroundColor {
    backgroundColor = _backgroundColor;
    
    [titleView setBackgroundColor:_backgroundColor];
    [messageView setBackgroundColor:_backgroundColor];
    
    for (int i = 0; i < [buttonList count]; ++i) {
        UIButton *btn = [buttonList objectAtIndex:i];
        [btn setBackgroundColor:_backgroundColor];
    }
}

-(void) setBorderColor:(UIColor *)_borderColor {
    borderColor = _borderColor;
    
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
