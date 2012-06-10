//
//  DatingDetailViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatingDetailViewController.h"
#import "GeoBrain.h"
#import "GeoInfo.h"
#import "AppointmentBrain.h"

@interface DatingDetailViewController ()
@property (nonatomic,strong) AppointmentBrain *appointmentBrain;
@property (nonatomic,strong) GeoBrain *geobrain;
@end

@implementation DatingDetailViewController
@synthesize mapView = _mapView;
@synthesize idname = _idname;
@synthesize annotationPoint = _annotationPoint;
@synthesize appointmentBrain = _appointmentBrain;
@synthesize geobrain = _geobrain;

- (AppointmentBrain *)appointmentBrain
{
    if(!_appointmentBrain) _appointmentBrain = [[AppointmentBrain alloc] init];
    return _appointmentBrain;
}

- (GeoBrain *)geobrain
{
    if(!_geobrain) _geobrain = [[GeoBrain alloc] init];
    return _geobrain;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Dating Detail";
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    
    [self populateMapWithLocation];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)populateMapWithLocation
{
    GeoInfo *geoinfo = [self.appointmentBrain getDatingDetailById:self.idname];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = [geoinfo.latitude doubleValue];
    annotationCoord.longitude = [geoinfo.longitude doubleValue];
    
    self.annotationPoint = [[MKPointAnnotation alloc] init];
    self.annotationPoint.coordinate = annotationCoord;
    self.annotationPoint.title = geoinfo.title;
    self.annotationPoint.subtitle = geoinfo.subtitle;
    
    [self.mapView addAnnotation:self.annotationPoint];
    [self.mapView selectAnnotation:self.annotationPoint animated:YES];
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.annotationPoint.coordinate, 50,50) animated:YES];
}

- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation

{
    NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.longitude];
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    NSString *name = [userPrefs stringForKey:@"username"];
    
    [self.geobrain pushData2Server:name :4 :latitude :longitude];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {	
	if (annotation == mapView.userLocation) { //returning nil means 'use built in location view'
		return nil;
	}
	
	MKPinAnnotationView *pinAnnotation = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
	if (pinAnnotation == nil) {
		pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
	} else {
		pinAnnotation.annotation = annotation;
	}
	
    pinAnnotation.canShowCallout = YES;
	pinAnnotation.pinColor = MKPinAnnotationColorRed;
	pinAnnotation.animatesDrop = YES;
	
	return pinAnnotation;
}
@end
