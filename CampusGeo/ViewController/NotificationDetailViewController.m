//
//  NotificationDetailViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationDetailViewController.h"
#import "NotificationBrain.h"
#import "NotificationViewController.h"

@interface NotificationDetailViewController ()
@property (nonatomic,strong) NotificationBrain *notificationBrain;
@end

@implementation NotificationDetailViewController
@synthesize requestType = _requestType;
@synthesize requestName = _requestName;
@synthesize requestId = _requestId;
@synthesize notificationBrain = _notificationBrain;

- (NotificationBrain *)notificationBrain
{
    if(!_notificationBrain) _notificationBrain = [[NotificationBrain alloc] init];
    return _notificationBrain;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    requestnameLabel.text = self.requestName;
    NSString *type;
    if(self.requestType == 0)
    {
        type = @"dating";
    }else
    {
        type = @"friend";
    }
    
    requestTypeLabel.text = type;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)passNotification:(id)sender {
    NSString *respones = [self.notificationBrain passNotification2Server:self.requestId];
    if([respones isEqualToString:@"true"])
    {
        NSLog(@"pass notification success");
        [self performSegueWithIdentifier:@"back2Notification" sender:self];
    }else
    {
        NSLog(@"pass notification failed");
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"back2Notification"])
    {
        NSString *goaluser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *notifications = [self.notificationBrain getNotifications:goaluser];
        [segue.destinationViewController setNotifications:notifications];
    }
}

@end
