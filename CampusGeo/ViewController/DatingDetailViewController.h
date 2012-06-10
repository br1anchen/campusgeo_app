//
//  DatingDetailViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DatingDetailViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) NSString *idname;
@property (nonatomic,strong) MKPointAnnotation *annotationPoint;

@end
