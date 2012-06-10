//
//  SocialBrain.m
//  CampusGeo
//
//  Created by Brian Chen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialBrain.h"
#import "User.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@implementation SocialBrain

#define HOST_DOMAIN @"192.168.1.6:8080"

-(NSArray *)getSocialList:(NSString *)hostUser
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/social/friendList?hostuser=%@",HOST_DOMAIN,hostUser]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSMutableArray *json2friends =[[NSMutableArray alloc] init];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(json != nil){
        for(NSDictionary *friend in json){
            [json2friends addObject:[friend objectForKey:@"friend"]];
        }
        NSLog(@"friendList:%@",json2friends);
        friendList = (NSArray *)json2friends;
    }
    return friendList;
}

-(BOOL)sendSocialNoti:(NSString *)friendname:(NSString *)socialType
{
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    NSString *requestUser = [userPrefs stringForKey:@"username"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/request/social?requestUser=%@&goalUser=%@&reqType=%@",HOST_DOMAIN,requestUser,friendname,socialType]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(jsonData != nil){
        NSLog(@"push social notification success");
        return true;
    }else{
        NSLog(@"push social notification failed");
        return false;
    }
}

@end
