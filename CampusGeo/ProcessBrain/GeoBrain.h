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

@interface GeoBrain : NSObject

-(GeoInfo *)getGeoInfoByName:(NSString *)username;

-(void)pushLocationToServer:(NSString *)username:(int)geoType;

@end
