//
//  MKMapView+Additions.m
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import "MKMapView+Additions.h"

@implementation MKMapView (Additions)

- (void)centerToLocation:(CLLocation *)location andVisibleRadius:(CLLocationDistance)radius {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius);
    [self setRegion:viewRegion animated:YES];
}

@end


