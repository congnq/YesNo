//
//  ViewController.h
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "../Utils/Utils.h"

#import "Mediator.h"

@interface ViewController : UIViewController {
	Mediator *mediator;

    __weak IBOutlet UILabel * scoreLabel;
    __weak IBOutlet UILabel * equationLabel;
	__weak IBOutlet UIProgressView * progressView;
	__weak IBOutlet UIButton *startBtn;
}

@property (weak, readonly) UILabel *scoreLabel;
@property (weak, readonly) UILabel *equationLabel;
@property (weak, readonly) UIProgressView *progressView;
@property (weak, readonly) UIButton *startBtn;

- (IBAction)pressStartBtn:(id)sender;
- (IBAction)pressTrueBtn:(id)sender;
- (IBAction)pressFalseBtn:(id)sender;


@end

