//
//  JAViewController.m
//  JAMapSlider
//
//  Created by Jad on 28/10/2013.
//  Copyright (c) 2013 Inertia. All rights reserved.
//

// Frameworks
#import <MapKit/MapKit.h>
#import "MKMapView+Additions.h"

// Controllers
#import "JAMapSliderViewController.h"

// Model
#import "JAEvent.h"

#import "JALocationAnnotation.h"
#import "JAEventCollectionViewCell.h"

@interface JAMapSliderViewController () <UICollectionViewDelegate, MKMapViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, weak) IBOutlet MKMapView * mapView;
@property (nonatomic, strong) NSArray * events;

@end

@implementation JAMapSliderViewController

@synthesize collectionView = _collectionView;
@synthesize mapView = _mapView;

#pragma mark Events
@synthesize events = _events;
- (NSArray *)events {
    if (_events == nil) {
        
        NSMutableDictionary * dict1 = [[NSMutableDictionary alloc] init];
        [dict1 setObject:@1 forKey:@"identifier"];
        [dict1 setObject:@"Paris" forKey:@"name"];
        [dict1 setObject:@"Salut! un peu de fromage ?" forKey:@"description"];
        [dict1 setObject:@"48.879333" forKey:@"lat"];
        [dict1 setObject:@"2.329455" forKey:@"lon"];
        
        NSMutableDictionary * dict2 = [[NSMutableDictionary alloc] init];
        [dict2 setObject:@2 forKey:@"identifier"];
        [dict2 setObject:@"London" forKey:@"name"];
        [dict2 setObject:@"Let's go to the pub!" forKey:@"description"];
        [dict2 setObject:@"51.501363" forKey:@"lat"];
        [dict2 setObject:@"-0.141879" forKey:@"lon"];
        
        NSMutableDictionary * dict3 = [[NSMutableDictionary alloc] init];
        [dict3 setObject:@3 forKey:@"identifier"];
        [dict3 setObject:@"Berlin" forKey:@"name"];
        [dict3 setObject:@"tanzen auf gute electro music!" forKey:@"description"];
        [dict3 setObject:@"52.537944" forKey:@"lat"];
        [dict3 setObject:@"13.415473" forKey:@"lon"];
        
        _events = [NSArray arrayWithObjects:[[JAEvent alloc]initWithJsonDictionary:dict1], [[JAEvent alloc]initWithJsonDictionary:dict2], [[JAEvent alloc]initWithJsonDictionary:dict3], nil];
    
    }
    return _events;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map Slider Demo";
    [self pinLocations];
    [self.mapView setShowsUserLocation:YES];
    JAEvent * event = [self eventAtIndex:0];
    [self.mapView centerToLocation:[[CLLocation alloc] initWithLatitude:event.latitude longitude:event.longitude] andVisibleRadius:kMaximumReloadBoundary];
}

#pragma mark - Pin locations
- (void) pinLocations{
    for (int i = 0; i < [self numberOfEvents]; i++) {
        JAEvent * event = [self eventAtIndex:i];
        JALocationAnnotation* annotation = [[JALocationAnnotation alloc] initWithName:event.name coordinate:CLLocationCoordinate2DMake(event.latitude,event.longitude)];
        annotation.index = i;
        if ([annotation coordinateIsValid]) {
            [self.mapView addAnnotation:annotation];
        }
        else {
            NSLog(@"Could not add annotation %@",annotation.title);
        }
    }
}

#pragma mark - MKMapView Delegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *mapPin = nil;
    if(annotation != mapView.userLocation) {
        static NSString *defaultPinID = @"defaultPin";
        mapPin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if (mapPin == nil) {
            mapPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
            mapPin.pinColor = MKPinAnnotationColorGreen;
            mapPin.canShowCallout = YES;
            mapPin.animatesDrop = YES;
            mapPin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        else {
            mapPin.annotation = annotation;
        }
    }
    return mapPin;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[JALocationAnnotation class]]) {
        JALocationAnnotation *annotation = ((JALocationAnnotation *)view.annotation);
        NSUInteger index = annotation.index;
        JAEvent * event = [self eventAtIndex:index];
        [self.collectionView scrollRectToVisible:CGRectMake(annotation.index * self.collectionView.bounds.size.width, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height) animated:YES];
        [self.mapView centerToLocation:[[CLLocation alloc] initWithLatitude:event.latitude longitude:event.longitude] andVisibleRadius:kMaximumReloadBoundary];
    }
}

- (id <MKAnnotation>) annotationForIndex:(NSInteger)index {
    NSUInteger i = [self.mapView.annotations indexOfObjectPassingTest:^BOOL(id<MKAnnotation>  annotation, NSUInteger idx, BOOL *stop) {
        return [annotation isKindOfClass:[JALocationAnnotation class]] && ((JALocationAnnotation*)annotation).index == index;
    }];
    return (i != NSNotFound) ? [self.mapView.annotations objectAtIndex:i] : nil ;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    JALocationAnnotation * annotation = [self annotationForIndex:index];
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self distanceToAnnotation:[mapView.selectedAnnotations objectAtIndex:0]];
}

#pragma mark Events access
- (JAEvent *) eventAtIndex:(NSInteger)index {
    return [self.events objectAtIndex:index];
}

- (NSInteger)numberOfEvents {
    return [self.events count];
}

- (JAEvent *) currentEvent {
    NSUInteger currentIndex = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    return [self eventAtIndex:currentIndex];
}

#pragma mark UICollectionViewDelegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfEvents];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JAEventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JAEventCollectionViewCell class]) forIndexPath:indexPath];
    JAEvent * event = [self eventAtIndex:indexPath.row];
    cell.eventNameLabel.text = event.name;
    cell.eventDescriptionLabel.text = event.description;
    cell.eventDistanceLabel.text = [self distanceToAnnotation:[self annotationForIndex:indexPath.row]];
    
    return cell;
}

#pragma mark Distance to annotation
- (NSString *)distanceToAnnotation:(id<MKAnnotation>)annotation {
    CLLocation *pinLocation = [[CLLocation alloc]
                               initWithLatitude:annotation.coordinate.latitude
                               longitude:annotation.coordinate.longitude];
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:self.mapView.userLocation.coordinate.latitude
                                longitude:self.mapView.userLocation.coordinate.longitude];
    CLLocationDistance distance = [pinLocation distanceFromLocation:userLocation];
    NSString * distanceToAnnotation = nil;
    if (distance > 1000) {
        distanceToAnnotation = [NSString stringWithFormat:@"%.2f km", distance / 1000];
    }
    else {
        distanceToAnnotation = [NSString stringWithFormat:@"%4.0f m", distance];
        
    }
    return distanceToAnnotation;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocationOverMaximumBoundary:(CLLocation *)newLocation {
    [self.mapView centerToLocation:newLocation andVisibleRadius:kVisibleRegionRadius];
}



@end
