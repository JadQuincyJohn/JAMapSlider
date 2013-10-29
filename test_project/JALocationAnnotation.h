//
//  JALocationAnnotation.h
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface JALocationAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) NSUInteger index;

#pragma mark LifeCycle
- (id)initWithName:(NSString*)name coordinate:(CLLocationCoordinate2D)coordinate;
#pragma mark - Coordinate validity
- (BOOL)coordinateIsValid;

@end
