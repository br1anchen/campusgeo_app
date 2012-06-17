//
//  LoginBrain.h
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginBrain : NSObject
{
    NSString *username;
    NSString *password;
    NSString *hostaddress;
}

-(void)setUserName:(NSString *)aName;
-(void)setPassword:(NSString *)aKey;
-(NSString *)getUserName;
-(NSString *)getPassword;
-(NSString *)getHostAddress;

@end
