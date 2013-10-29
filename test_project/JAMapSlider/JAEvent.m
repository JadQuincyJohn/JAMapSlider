//
//  JAEvent.m
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import "JAEvent.h"

@implementation JAEvent


- (NSNumber *)identifier {
    return (NSNumber *)[self.jsonDictionary objectForKey:@"identifier"];
}

- (NSString *)description {
    return (NSString *)[self.jsonDictionary objectForKey:@"description"];
}

- (NSString *)name {
    return (NSString *)[self.jsonDictionary objectForKey:@"name"];
}

- (CGFloat)latitude {
    return [[self.jsonDictionary objectForKey:@"lat"] floatValue];
}

- (CGFloat)longitude {
    return [[self.jsonDictionary objectForKey:@"lon"] floatValue];
}


@end
