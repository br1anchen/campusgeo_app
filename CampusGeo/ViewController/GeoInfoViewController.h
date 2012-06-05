//
//  GeoInfoViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GeoInfoViewController : UIViewController <MKMapViewDelegate>
{

}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) MKPointAnnotation *annotationPoint;

@end
