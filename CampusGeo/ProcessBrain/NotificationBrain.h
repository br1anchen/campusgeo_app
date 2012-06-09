//
//  NotificationBrain.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationBrain : NSObject
{
    NSArray *notificationList;
}

-(NSArray *)getNotifications:(NSString *)goalUser;

@end
