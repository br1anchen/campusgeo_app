//
//  UserAdminViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserAdminViewController.h"
#import "SocialBrain.h"
#import "GeoBrain.h"
#import "NotificationBrain.h"
#import "AppointmentBrain.h"
#import "SocialDataViewController.h"
#import "NotificationViewController.h"
#import "AppointmentViewController.h"

@interface UserAdminViewController ()
@property (nonatomic,strong) SocialBrain *socialbrain;
@property (nonatomic,strong) GeoBrain *geobrain;
@property (nonatomic,strong) NotificationBrain *notificationBrain;
@property (nonatomic,strong) AppointmentBrain *appointmentBrain;
@end

@implementation UserAdminViewController
@synthesize socialbrain = _socialbrain;
@synthesize geobrain = _geobrain;
@synthesize notificationBrain = _notificationBrain;
@synthesize appointmentBrain = _appointmentBrain;

- (SocialBrain *)socialbrain
{
    if(!_socialbrain) _socialbrain = [[SocialBrain alloc] init];
    return _socialbrain;
}

- (GeoBrain *)geobrain
{
    if(!_geobrain) _geobrain = [[GeoBrain alloc] init];
    return _geobrain;
}

- (NotificationBrain *)notificationBrain
{
    if(!_notificationBrain) _notificationBrain = [[NotificationBrain alloc] init];
    return _notificationBrain;
}

- (AppointmentBrain *)appointmentBrain
{
    if(!_appointmentBrain) _appointmentBrain = [[AppointmentBrain alloc] init];
    return _appointmentBrain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    traking = NO;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    traking = NO;
    trakingTimer = nil;
    [trakingTimer invalidate];
    
    if([segue.identifier isEqualToString:@"ShowSocial"]){
        NSLog(@"show user social");
        NSString *hostuser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *friends = [self.socialbrain getSocialList:hostuser];
        [segue.destinationViewController setFriends:friends];
    }else if([segue.identifier isEqualToString:@"ShowNotification"])
    {
        NSLog(@"show user notification");
        NSString *goaluser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *notifications = [self.notificationBrain getNotifications:goaluser];
        [segue.destinationViewController setNotifications:notifications];
    }else if([segue.identifier isEqualToString:@"ShowDatings"])
    {
        NSLog(@"show user dating");
        NSString *bindUser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *datings = [self.appointmentBrain getDatings:bindUser];
        [segue.destinationViewController setDatings:datings];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)switchGPS:(id)sender {
    if(gpsButton.on){
        [self.geobrain setGPSSwitch:YES];
        traking = YES;
        trakingTimer = [NSTimer scheduledTimerWithTimeInterval:5 target: self selector:@selector(updateLocationToServer) userInfo:nil repeats:YES];
    }else
    {
        [self.geobrain setGPSSwitch:NO];
        traking = NO;
        trakingTimer = nil;
        [trakingTimer invalidate];
    }
}

-(void)updateLocationToServer
{
    if(traking){
        NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        [self.geobrain pushLocationToServer:username:4];
    }else
    {
        NSLog(@"stop traking location");
        trakingTimer = nil;
        [trakingTimer invalidate];
    }
}

@end
