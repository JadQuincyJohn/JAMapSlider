//
//  JAObject.m
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import "JAObject.h"

@implementation JAObject

@synthesize jsonDictionary = _jsonDictionary;
- (void)setJsonDictionary:(NSDictionary *)jsonDictionary {
	if (![_jsonDictionary isEqualToDictionary:jsonDictionary]) {
		_jsonDictionary = jsonDictionary;
	}
}

#pragma mark - Initializer
- (id)initWithJsonDictionary:(NSDictionary *)jsonDictionary {
	self = [super init];
	if (self) {
		self.jsonDictionary = jsonDictionary;
	}
	return self;
}

#pragma mark - Static Initializer
+ (JAObject *)objectWithJsonDictionary:(NSDictionary *)jsonDictionary {
	return [[self alloc] initWithJsonDictionary:jsonDictionary];
}
@end
