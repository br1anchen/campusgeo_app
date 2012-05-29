//
//  LoginBrain.m
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginBrain.h"

@implementation LoginBrain

-(void)setUserName:(NSString *)aName
{
    username = aName;
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setValue:username forKey:@"username"];
}

-(void)setPassword:(NSString *)aKey
{
    password = aKey;
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setValue:password forKey:@"password"];
}

-(NSString *)getUserName
{
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    NSString *name = [userPrefs stringForKey:@"username"];
    return name;
}

-(NSString *)getPassword
{
    NSUserDefaults *userPrefs = [NSUserDefaults standardUserDefaults];
    NSString *pwd = [userPrefs stringForKey:@"password"];
    return pwd;
}

@end
