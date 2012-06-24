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

-(GeoInfo *)getGeoInfoByName:(NSString *)username
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/geo/current?bindUser=%@",[self getHostAddress],username]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    GeoInfo *newgeo = [[GeoInfo alloc] init];
    if(json != nil){
        [newgeo setTitle:[NSString stringWithFormat:@"%@(%@)",[json objectForKey:@"bindUser"],[json objectForKey:@"area"]]];
        [newgeo setSubtitle:[NSString stringWithFormat:@"%@ %@",[json objectForKey:@"date"],[json objectForKey:@"time"]]];
        [newgeo setLatitude:[json objectForKey:@"latitude"]];
        [newgeo setLongitude:[json objectForKey:@"longitude"]];
    }

    return newgeo;
}

-(void)pushLocationToServer:(NSString *)username:(int)geoType:(NSString *)area
{
    bindname = username;
    pushGeoType = geoType;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.delegate = self;
    [locationManager startMonitoringSignificantLocationChanges];
    NSString *latitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",locationManager.location.coordinate.longitude];
    [self pushData2Server:username :geoType :latitude :longitude:area];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSString *latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
    
    [self pushData2Server:bindname :pushGeoType :latitude :longitude:@"outdoor"];
    
}

-(void)pushData2Server:(NSString *)username:(int)geoType:(NSString *)latitude:(NSString *)longitude:(NSString *)area
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/geo/update?username=%@&latitude=%@&longitude=%@&geoType=%d&area=%@",[self getHostAddress],username,latitude,longitude,geoType,area]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    NSString *strResponse = [request responseString];
    if([strResponse isEqualToString:@"\"create\""]){
        NSLog(@"create location success");
        NSLog(@"user:%@",username);
        NSLog(@"latitude:%@",latitude);
        NSLog(@"longitude:%@",longitude);
        NSLog(@"area:%@",area);
    }else if( [strResponse isEqualToString:@"\"update\""]){
        NSLog(@"update location success");
        NSLog(@"user:%@",username);
        NSLog(@"latitude:%@",latitude);
        NSLog(@"longitude:%@",longitude);
        NSLog(@"area:%@",area);
    }else
    {
        NSLog(@"push location failed");
    }

}

-(void)setGPSSwitch:(BOOL)value
{
    gpsSwitch = value;
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setBool:gpsSwitch forKey:@"trackButton"];
    [userPref synchronize];
}

-(BOOL)getGPSSwitch
{
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    BOOL gps = [userPrefs boolForKey:@"trackButton"];
    return gps;
}

-(NSString *)getHostAddress
{
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    return [userPrefs stringForKey:@"hostaddress"];
}
@end
