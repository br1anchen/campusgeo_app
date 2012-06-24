//
//  GeoBrain.h
//  CampusGeo
//
//  Created by Brian Chen on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GeoInfo.h"

@interface GeoBrain : NSObject <CLLocationManagerDelegate>
{
    NSString *bindname;
    int pushGeoType;
    BOOL gpsSwitch;
    CLLocationManager *locationManager;
}
@property (nonatomic,retain)CLLocationManager *locationManager;

-(GeoInfo *)getGeoInfoByName:(NSString *)username;
-(void)setGPSSwitch:(BOOL)value;
-(BOOL)getGPSSwitch;

-(void)pushLocationToServer:(NSString *)username:(int)geoType:(NSString *)area;
-(void)pushData2Server:(NSString *)username:(int)geoType:(NSString *)latitude:(NSString *)longitude:(NSString *)area;
@end
