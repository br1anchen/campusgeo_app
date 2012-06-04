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

#define HOST_DOMAIN @"59.79.8.115:8080"

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

@end
