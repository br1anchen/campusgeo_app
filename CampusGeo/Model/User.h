//
//  User.h
//  CampusGeo
//
//  Created by Brian Chen on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *username;
    NSString *role;
    NSString *status;
}

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *role;
@property (nonatomic,strong) NSString *status;

@end
