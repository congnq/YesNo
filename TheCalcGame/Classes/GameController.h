//
//  GameController.h
//  TheCalcGame
//
//  Created by Neo on 8/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../Utils/Utils.h"

#import "Mediator.h"
#import "ViewController.h"

@interface GameController : NSObject {
	float duration;
	float timePast;

	BOOL isEnd;
    int score;

	BOOL currentEquality;
    BOOL lastEquality;
    int sameEqualityCount;

    Mediator *mediator;
    ViewController *viewCtrl;

	NSTimer *timer;
}

- (GameController *)init;

- (void)start;
- (void)checkEquality:(BOOL)equality;

// Timer

- (void)startTimer;
- (void)clearTimer;


@end
