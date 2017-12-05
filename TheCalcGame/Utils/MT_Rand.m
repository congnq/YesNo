//
//  MT_Rand.m
//  TheCalcGame
//
//  Created by Neo on 7/12/14.
//  Copyright (c) 2014 Neo He. All rights reserved.
//

#import "MT_Rand.h"

@implementation MT_Rand {
	int MT[624];
	int index;
}

static MT_Rand *singleton = nil;

+ (MT_Rand *) getInstance {
	if (!singleton) {
		singleton = [[MT_Rand alloc] init];
	}
	
	return singleton;
}

- (int) rand {
	NSLog(@"index: %d", index);
	if (index == 0) {
		[self generateNumbers];
	}
	
	int y = MT[index];
	y = y ^ y >> 11;
	y = y ^ y << 7 & 2636928640;
	y = y ^ y << 15 & 4022730752;
	y = y ^ y >> 18;
	
	index = (index + 1) % 624;
	
	return y;
}


// Private method below

- (MT_Rand *) init {
	if (self = [super init]) {
		index = 0;
		[self generateSeed];
	}
	
	return self;
}

- (void) generateSeed {
	int i;
	
	MT[0] = time(NULL);

	for (i = 1; i < 624; i++) {
		MT[i] = 1812433253 * (MT[i - 1] ^ MT[i - 1] >> 30) + i & 0xffffffff;
	}
}

- (void) generateNumbers {
	int i;
	
	for (i = 0; i < 624; i++) {
		int y = (MT[i] & 0x80000000) + (MT[(i + 1) % 624] & 0x7fffffff);
		MT[i] = MT[(i + 397) % 624] ^ y >> 1;
		if (y % 2 != 0) {
			MT[i] ^= 2567483615;
		}
	}
}

@end
