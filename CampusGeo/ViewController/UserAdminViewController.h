//
//  UserAdminViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface UserAdminViewController : UIViewController<GKSessionDelegate,GKPeerPickerControllerDelegate>
{
    GKSession *connectionSession;
    GKPeerPickerController *connectionPicker;
    NSMutableArray *connectionPeers;
    
    IBOutlet UISwitch *gpsButton;
    BOOL traking;
    BOOL indoorStatus;
    NSTimer *trakingTimer;
    IBOutlet UIButton *indoorButton;
}

@property (retain) GKSession *connectionSession;
@property (nonatomic,retain) NSMutableArray *connectionPeers;
@property (nonatomic,retain) GKPeerPickerController *connectionPicker;

- (IBAction)switchGPS:(id)sender;
- (IBAction)switchIndoor:(id)sender;

@end
