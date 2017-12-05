//
// Created by Neo He on 9/12/14.
// Copyright (c) 2014 Neo He. All rights reserved.
//

#import "Mediator.h"
#import "ViewController.h"
#import "GameController.h"


@implementation Mediator {

}

static Mediator *singleton = nil;

+ (Mediator *)getInstance {
    if (!singleton) {
        singleton = [[self alloc] init];
    }

    return singleton;
}

@synthesize viewCtrl;

// Action


// Game

- (void)startGame {
    NSLog(@"Game start");
	[viewCtrl.startBtn setHidden:YES];
    gameCtrl = [[GameController alloc] init];
    [gameCtrl start];
}

// UI
- (void)handlePressTrueBtn {
	[gameCtrl checkEquality:YES];
}
- (void)handlePressFalseBtn {
	[gameCtrl checkEquality:NO];
}

- (void)updateScore:(int)score {
    self.viewCtrl.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
}

- (void)updateEquation:(NSString *)equationText {
	self.viewCtrl.equationLabel.text = equationText;
}

- (void)setProgress:(float)progress {
    [self.viewCtrl.progressView setProgress:progress];
}
- (void)setProgress:(float)progress animated:(BOOL)animated {
    [self.viewCtrl.progressView setProgress:progress animated:animated];
}

// Test

- (void)test {

}

// Private Method

- (Mediator *)init {
    if (self = [super init]) {
        
    }

    return self;
}

@end