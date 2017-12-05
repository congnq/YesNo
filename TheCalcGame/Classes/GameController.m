//
//  GameController.m
//  TheCalcGame
//
//  Created by Neo on 8/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "GameController.h"

@implementation GameController

- (GameController *)init {
    if (self = [super init]) {
		isEnd = YES;

        mediator = [Mediator getInstance];
    }

    return self;
}

- (void)start {
	isEnd = NO;
	duration = 3.0;
	
    [mediator updateScore:score = 0];
	
	currentEquality = [self getEquality];
	[self process];
	
    [self startTimer];
}

- (void)end {
	isEnd = YES;
	[self clearTimer];
	[mediator updateEquation:@"Game Over"];
	[mediator.viewCtrl.startBtn setHidden:NO];
}

- (void)checkEquality:(BOOL)equality {
	if (isEnd) {
		return;
	}
	
	if (equality == currentEquality) {
		[self nextTurn];
	}
	else {
		[self end];
	}
}

- (void)nextTurn {
	if (isEnd) {
		return;
	}
	
    [mediator updateScore:++score];
	
	currentEquality = [self getEquality];
	
	if (score == 25 || score == 45 || score == 60 || score == 75 || score == 90) {
		[self speedUp];
	}
	
	[self process];
	
    [self startTimer];
}

- (void)process {
	int delta = 0;
	
	if (!currentEquality) {
		delta = [Utils randomDelta];
	}
	
	int operator = [Utils randomOperator];
	int operandLeft = [Utils randomIntFrom:3 to:9];
	int operandRight = [Utils randomIntFrom:3 to:14];
	int result = 0;
	
	NSString *equationText;
	
	switch (operator) {
		case GAME_OPERATOR_PLUS:
			result = operandLeft + operandRight + delta;
			
			equationText = [NSString stringWithFormat:@"%d ＋ %d", operandLeft, operandRight];
			
			break;
		case GAME_OPERATOR_MINUS:
			result = operandLeft;
			operandLeft = operandLeft + operandRight + delta;
			
			equationText = [NSString stringWithFormat:@"%d － %d", operandLeft, operandRight];
			
			break;
		case GAME_OPERATOR_MULTIPLY:
			result = operandLeft * operandRight + delta;
			
			equationText = [NSString stringWithFormat:@"%d × %d", operandLeft, operandRight];
			
			break;
		case GAME_OPERATOR_DIVIDE:
			result = operandLeft;
			operandLeft = operandLeft * operandRight;
			
			delta != 0 && (delta /= abs(delta));
			if ([Utils randomBool]) {
				operandRight += delta;
			}
			else {
				result += delta;
			}
			
			equationText = [NSString stringWithFormat:@"%d ÷ %d", operandLeft, operandRight];
			
			break;
		default:
			break;
	}
	
	if ([Utils randomBool]) {
		[mediator updateEquation:[NSString stringWithFormat:@"%@ ＝ %d", equationText, result]];
	}
	else {
		[mediator updateEquation:[NSString stringWithFormat:@"%d ＝ %@", result, equationText]];
	}
}

- (BOOL)getEquality {
    BOOL equality = [Utils randomBool];

    if (equality == lastEquality) {
        if (sameEqualityCount >= 2 && [Utils randomBoolWithTrue:sameEqualityCount + 1]) {
            equality = !equality;
            sameEqualityCount = 0;
        }
        else {
            ++sameEqualityCount;
        }
    }
    else {
        sameEqualityCount = 0;
    }

    return lastEquality = equality;
}

// Timer

- (void)startTimer {
    if (timer) {
        [self clearTimer];
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:duration / 100 target:self selector:@selector(updateProgressView) userInfo:nil repeats:YES];
}

- (void)speedUp {
	if (duration > 2) {
		duration -= 1;
	}
	else if (duration > 1) {
		duration -= 0.5;
	}
	else if (duration > 0.5) {
		duration -= 0.25;
	}
	else {
		duration /= 2;
	}
	
	NSLog(@"%f", duration);
}

- (void)clearTimer {
	[timer invalidate];
	timer = nil;
	timePast = 0;
	[mediator setProgress:0];
}

- (void)updateProgressView {
	if (timePast < duration) {
		timePast += duration / 100;
		[mediator setProgress:timePast / duration animated:YES];
	}
	else {
		[self end];
	}
}

- (void)dealloc {
	timer = nil;
}

@end
