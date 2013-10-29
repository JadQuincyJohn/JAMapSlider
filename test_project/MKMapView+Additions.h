//
//  MKMapView+Additions.h
//  JAMapSlider
//
//  Created by Jad on 29/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

#import <MapKit/MapKit.h>

#define kVisibleRegionRadius 1000000
#define kMaximumReloadBoundary 500000
#define kFocusedVisibleRegionRadius 500000

@interface MKMapView (Additions)

- (void)centerToLocation:(CLLocation *)location andVisibleRadius:(CLLocationDistance)radius;

@end

