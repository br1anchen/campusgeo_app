//
//  UserAdminViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAdminViewController : UIViewController
{
    IBOutlet UISwitch *gpsButton;
    BOOL traking;
    NSTimer *trakingTimer;
}

- (IBAction)switchGPS:(id)sender;

@end
