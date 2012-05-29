//
//  CampusGeoViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusGeoViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
    IBOutlet UILabel *loginInfo;
}

@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;
@property (nonatomic,retain) UILabel *loginInfo;

- (IBAction)login;
- (void)checkAndEnter;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)getRidOfKeyboard:(id)sender;
@end
