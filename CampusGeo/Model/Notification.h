//
//  Notification.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
{
    NSString *idname;
    NSString *requestUser;
    NSNumber *requestType;
}

@property (nonatomic,copy) NSString *idname;
@property (nonatomic,copy) NSString *requestUser;
@property (nonatomic,copy) NSNumber *requestType;

@end
