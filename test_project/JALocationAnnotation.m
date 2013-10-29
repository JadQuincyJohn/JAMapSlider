//
//  JALocationAnnotation.m
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import "JALocationAnnotation.h"
#import <MapKit/MapKit.h>

@interface JALocationAnnotation ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end


@implementation JALocationAnnotation

#pragma mark LifeCycle
- (id)initWithName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        self.name = name;
        self.coordinate = coordinate;
        self.index = NSNotFound;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return nil;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (NSUInteger)index {
    return _index;
}

#pragma mark - Coordinate validity
- (BOOL)coordinateIsValid {
    return CLLocationCoordinate2DIsValid(CLLocationCoordinate2DMake(self.coordinate.latitude,self.coordinate.longitude));
}

@end