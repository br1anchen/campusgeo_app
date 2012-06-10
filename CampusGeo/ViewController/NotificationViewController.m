//
//  NotificationViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NotificationViewController.h"
#import "Notification.h"
#import "NotificationDetailViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController
@synthesize notifications = _notifications;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Notifications";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Friend Description";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Notification *notification = [self.notifications objectAtIndex:indexPath.row];
    NSString *type;
    if(notification.requestType == 0)
    {
        type = @"dating";
    }else
    {
        type = @"friend";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",notification.requestUser,type];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notification *notification = [self.notifications objectAtIndex:indexPath.row];
    NotificationDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"notificationDetail"];
    detailView.requestName = notification.requestUser;
    detailView.requestType = notification.requestType;
    detailView.requestId = notification.idname;
    [self.navigationController pushViewController:detailView animated:YES];
}

@end
