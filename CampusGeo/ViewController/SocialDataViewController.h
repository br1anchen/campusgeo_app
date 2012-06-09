//
//  SocialDataViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SocialDataViewController;

@protocol SocialDataViewControllerDelegate
@optional
-(void)socialDataViewController:(SocialDataViewController *)sender choseFriend:(id)friend;
@end

@interface SocialDataViewController : UITableViewController
{
    IBOutlet UIBarButtonItem *addFriendButton;
}

@property (nonatomic,strong) NSArray *friends;
@property (nonatomic,weak) id <SocialDataViewControllerDelegate> delegate;

@end
