//
//  AppointmentBrain.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppointmentBrain.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "Appointment.h"

@implementation AppointmentBrain

#define HOST_DOMAIN @"192.168.1.6:8080"
-(NSArray *)getDatings:(NSString *)bindUser
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/dating/future?bindUser=%@",HOST_DOMAIN,bindUser]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSMutableArray *json2Datings =[[NSMutableArray alloc] init];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(json != nil){
        for(NSDictionary *dating in json){
            Appointment *ap = [[Appointment alloc] init];
            ap.idname = [dating objectForKey:@"id"];
            ap.host = [dating objectForKey:@"host"];
            ap.dater = [dating objectForKey:@"dater"];
            ap.date = [dating objectForKey:@"date"];
            ap.time = [dating objectForKey:@"time"];
            [json2Datings addObject:ap];
        }
        NSLog(@"friendList:%@",json2Datings);
        datingList = (NSArray *)json2Datings;
    }
    return datingList;
}

-(GeoInfo *)getDatingDetailById:(NSString *)idname{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/dating/detail?id=%@",HOST_DOMAIN,idname]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    GeoInfo *newgeo = [[GeoInfo alloc] init];
    if(json != nil){
        [newgeo setTitle:[NSString stringWithFormat:@"Dating:%@ and %@",[json objectForKey:@"host"],[json objectForKey:@"dater"]]];
        [newgeo setSubtitle:[NSString stringWithFormat:@"%@ %@",[json objectForKey:@"date"],[json objectForKey:@"time"]]];
        [newgeo setLatitude:[json objectForKey:@"latitude"]];
        [newgeo setLongitude:[json objectForKey:@"longitude"]];
    }
    
    return newgeo;
}

-(NSString *)bookDating2Server:(NSString *)host:(NSString *)dater:(NSString *)date:(NSString *)time:(NSString *)latitude:(NSString *)longitude{}
@end
