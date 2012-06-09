//
//  SocialBrain.h
//  CampusGeo
//
//  Created by Brian Chen on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocialBrain : NSObject
{
    NSArray *friendList;
}

-(NSArray *)getSocialList:(NSString *)hostUser;

-(BOOL)sendSocialNoti:(NSString *)friendname:(NSString *)socialType;

@end
