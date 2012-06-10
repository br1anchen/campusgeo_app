//
//  Appointment.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Appointment : NSObject
{
    NSString *idname;
    NSString *host;
    NSString *dater;
    NSString *date;
    NSString *time;
}

@property (nonatomic,copy) NSString *idname;
@property (nonatomic,copy) NSString *host;
@property (nonatomic,copy) NSString *dater;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *time;
@end
