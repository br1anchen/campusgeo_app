//
//  AddFriendViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UIViewController
{
    IBOutlet UITextField *friendName;
    IBOutlet UITextField *socialType;
    IBOutlet UILabel *newFriendInfo;
}

- (IBAction)sendNotification:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)getRidOfKeyboard:(id)sender;

@end
