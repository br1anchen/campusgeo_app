//
//  AppointmentBrain.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppointmentBrain : NSObject
{
    NSArray *datingList;
}

-(NSArray *)getDatings:(NSString *)bindUser;
-(NSString *)bookDating2Server:(NSString *)host:(NSString *)dater:(NSString *)date:(NSString *)time:(NSString *)latitude:(NSString *)longitude;
@end
