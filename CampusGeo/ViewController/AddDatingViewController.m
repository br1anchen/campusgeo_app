//
//  AddDatingViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddDatingViewController.h"
#import "AppointmentBrain.h"
#import "AppointmentViewController.h"

@interface AddDatingViewController ()
@property (nonatomic,strong) AppointmentBrain *appointmentBrain;
@end

@implementation AddDatingViewController
@synthesize mapView = _mapView;
@synthesize hostname = _hostname;
@synthesize annotationPoint = _annotationPoint;
@synthesize appointmentBrain = _appointmentBrain;

- (AppointmentBrain *)appointmentBrain
{
    if(!_appointmentBrain) _appointmentBrain = [[AppointmentBrain alloc] init];
    return _appointmentBrain;
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
	// Do any additional setup after loading the view.
    self.title = @"New Dating";
    self.mapView.showsUserLocation = YES;
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    
    self.hostname = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    
    CLLocationCoordinate2D annotationCoord;
    
    annotationCoord.latitude = 31.274337;
    annotationCoord.longitude = 121.458659;
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotationCoord, 50,50) animated:YES];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
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

- (IBAction)sendDating2Server:(id)sender {
    NSString *response = [self.appointmentBrain bookDating2Server:self.hostname :daterText.text :dateText.text :timeText.text :latitude :longitude];
    if([response isEqualToString:@"true"])
    {
        [self performSegueWithIdentifier:@"back2Datings" sender:self];
    }else
    {
        NSLog(@"booking dating failed");
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"back2Datings"])
    {
        NSString *bindUser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *datings = [self.appointmentBrain getDatings:bindUser];
        [segue.destinationViewController setDatings:datings];
    }
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.mapView removeGestureRecognizer:sender];
    }
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
        self.annotationPoint = [[MKPointAnnotation alloc] init];
        self.annotationPoint.coordinate = locCoord;
        longitude = [NSString stringWithFormat:@"%f",locCoord.longitude];
        latitude = [NSString stringWithFormat:@"%f",locCoord.latitude];
        [self.mapView addAnnotation:self.annotationPoint];
    }
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if(touch.view.tag != 1)
    {
        [daterText resignFirstResponder];
        [dateText resignFirstResponder];
        [timeText resignFirstResponder];
    }
    
}

- (IBAction)getRidOfKeyboard:(id)sender
{
    [daterText resignFirstResponder];
    [dateText resignFirstResponder];
    [timeText resignFirstResponder];
}

@end
