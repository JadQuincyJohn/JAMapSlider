//
//  JAObject.h
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JAObject : NSObject

#pragma mark Properties
@property (nonatomic, retain) NSDictionary *jsonDictionary;

/** @name Initializer */
#pragma mark Initializer
- (id)initWithJsonDictionary:(NSDictionary *)jsonDictionary;

/** @name Static Initializer */
#pragma mark Static Initializer
+ (id)objectWithJsonDictionary:(NSDictionary *)jsonDictionary;

@end
