//
//  MT_Rand.h
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MT_Rand : NSObject

+ (MT_Rand *) getInstance;

- (int) rand;

@end
