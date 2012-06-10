//
//  AddDatingViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddDatingViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet UITextField *daterText;
    IBOutlet UITextField *dateText;
    IBOutlet UITextField *timeText;
    NSString *latitude;
    NSString *longitude;
}
- (IBAction)sendDating2Server:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)getRidOfKeyboard:(id)sender;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSString *hostname;
@property (nonatomic,strong) MKPointAnnotation *annotationPoint;

@end
