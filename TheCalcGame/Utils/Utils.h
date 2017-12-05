//
//  Utils.h
//  TheCalcGame
//
//  Created by Neo on 8/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MT_Rand.h"

#ifndef GAME_OPERATOR

#define GAME_OPERATOR
#define GAME_OPERATOR_PLUS 0
#define GAME_OPERATOR_MINUS 1
#define GAME_OPERATOR_MULTIPLY 2
#define GAME_OPERATOR_DIVIDE 3

#endif

@interface Utils : NSObject

+ (int)randomIntFrom:(int)min to:(int)max;
+ (BOOL)randomBool;
+ (BOOL)randomBoolWithTrue:(int)pTrue;
+ (BOOL)randomBoolWithTrue:(int)pTrue andFalse:(int)pFalse;
+ (int)randomDelta;
+ (int)randomOperator;

@end
