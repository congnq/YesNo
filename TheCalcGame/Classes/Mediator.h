//
// Created by Neo He on 9/12/14.
// Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewController;
@class GameController;

@interface Mediator : NSObject {
    ViewController *viewCtrl;
    GameController *gameCtrl;
}

+ (Mediator *)getInstance;

@property ViewController *viewCtrl;

// Game

- (void)startGame;


// UI

- (void)handlePressTrueBtn;
- (void)handlePressFalseBtn;

- (void)updateScore:(int)score;
- (void)updateEquation:(NSString *)equationText;

- (void)setProgress:(float)progress;
- (void)setProgress:(float)progress animated:(BOOL)animated;

// Test

- (void)test;


@end