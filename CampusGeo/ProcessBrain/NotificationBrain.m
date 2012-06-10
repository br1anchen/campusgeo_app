//
//  NotificationBrain.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationBrain.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import "Notification.h"

@implementation NotificationBrain

#define HOST_DOMAIN @"59.79.8.115:8080"

-(NSArray *)getNotifications:(NSString *)goalUser
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/request/all?goalUser=%@",HOST_DOMAIN,goalUser]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSMutableArray *json2notifications =[[NSMutableArray alloc] init];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(json != nil){
        for(NSDictionary *notification in json){
            Notification *noti = [[Notification alloc] init];
            noti.idname = [notification objectForKey:@"id"];
            noti.requestUser = [notification objectForKey:@"requestUser"];
            noti.requestType = [notification objectForKey:@"reqType"];
            [json2notifications addObject:noti];
        }
        NSLog(@"friendList:%@",json2notifications);
        notificationList = (NSArray *)json2notifications;
    }
    return notificationList;

}

-(NSString *)passNotification2Server:(NSString *)requestId
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/request/pass?requestId=%@",HOST_DOMAIN,requestId]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSString *strResponse;
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(jsonData != nil){
        NSLog(@"push social notification success");
        strResponse = [jsonData objectForKey:@"status"];
    }else{
        NSLog(@"push social notification failed");
        strResponse = @"false";
    }
    
    return strResponse;
}

@end
