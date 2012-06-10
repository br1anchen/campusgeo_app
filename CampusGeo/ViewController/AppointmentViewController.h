//
//  AppointmentViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentViewController : UITableViewController
{
    IBOutlet UIBarButtonItem *addDatingButton;
}

@property (nonatomic,strong) NSArray *datings;

@end
