//
//  Utils.m
//  TheCalcGame
//
//  Created by Neo on 8/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (int)randomIntFrom:(int)min to:(int)max {
    return [[MT_Rand getInstance] rand] % (max - min + 1) + min;
}

+ (BOOL)randomBool {
    return [[MT_Rand getInstance] rand] % 2 < 1;
}

+ (BOOL)randomBoolWithTrue:(int)pTrue {
    return [Utils randomBoolWithTrue:pTrue andFalse:10 - pTrue];
}

+ (BOOL)randomBoolWithTrue:(int)pTrue andFalse:(int)pFalse {
    return [[MT_Rand getInstance] rand] % (pTrue + pFalse) < pTrue;
}

+ (int)randomDelta {
     return [Utils randomIntFrom:1 to:3] * ([Utils randomBool] ? -1 : 1);
}

+ (int)randomOperator {
    return [Utils randomIntFrom:GAME_OPERATOR_PLUS to:GAME_OPERATOR_DIVIDE];
}

@end
