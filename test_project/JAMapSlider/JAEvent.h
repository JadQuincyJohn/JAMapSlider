//
//  JAEvent.h
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import "JAObject.h"

#define kEventIdentifierKey @"identifier"
#define kEventNameKey @"name"
#define kEventDescriptionKey @"description"
#define kEventLatKey @"lat"
#define kEventLonKey @"lon"

@interface JAEvent : JAObject

@property (nonatomic, readonly) NSNumber *identifier;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) CGFloat longitude;
@property (nonatomic, readonly) CGFloat latitude;

@end
