//
//  GeoBrain.m
//  CampusGeo
//
//  Created by Brian Chen on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GeoBrain.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@implementation GeoBrain

#define HOST_DOMAIN @"59.79.8.115:8080"
-(GeoInfo *)getGeoInfoByName:(NSString *)username
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/geo/current?bindUser=%@",HOST_DOMAIN,username]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    GeoInfo *newgeo = [[GeoInfo alloc] init];
    if(json != nil){
        [newgeo setTitle:[json objectForKey:@"bindUser"]];
        [newgeo setSubtitle:[NSString stringWithFormat:@"%@ %@",[json objectForKey:@"date"],[json objectForKey:@"time"]]];
        [newgeo setLatitude:[json objectForKey:@"latitude"]];
        [newgeo setLongitude:[json objectForKey:@"longitude"]];
    }

    return newgeo;
}

-(void)pushLocationToServer:(NSString *)username:(int)geoType
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
    NSLog(@"latitude:%@",latitude);
    NSString *longitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    NSLog(@"longitude:%@",longitude);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/geo/update?username=%@&latitude=%@&longitude=%@&geoType=%d",HOST_DOMAIN,username,latitude,longitude,geoType]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    NSString *strResponse = [request responseString];
    if([strResponse isEqualToString:@"true"]){
        NSLog(@"push location success");
    }else{
        NSLog(@"push location failed");
    }
}

@end
