//
//  NotificationDetailViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationDetailViewController : UIViewController
{
    IBOutlet UILabel *requestnameLabel;
    IBOutlet UILabel *requestTypeLabel;
}

@property (nonatomic,strong) NSString *requestName;
@property int requestType;
@property (nonatomic,strong) NSString *requestId;

- (IBAction)passNotification:(id)sender;

@end
