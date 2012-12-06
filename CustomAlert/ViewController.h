/*
 * ViewController.h
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
#import "CustomAlertView.h"

@interface ViewController : UIViewController <CustomAlertViewDelgate>

@property (nonatomic) IBOutlet UIButton *AlertWithOneButton;
@property (nonatomic) IBOutlet UIButton *AlertWithTwoButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithThreeButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithFourButtons;
@property (nonatomic) IBOutlet UIButton *AlertWithFiveButtons;
@property (nonatomic) IBOutlet UIButton *AlertTitleOnly;
@property (nonatomic) IBOutlet UIButton *AlertMessageOnly;
@property (nonatomic) IBOutlet UIButton *StandardUIAlert;

@end
