//
//  RegisterViewController.h
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
{
    IBOutlet UITextField *usernameText;
    IBOutlet UITextField *passwordText;
    IBOutlet UITextField *roleText;
}

- (IBAction)registerUser:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (IBAction)getRidOfKeyboard:(id)sender;
@end
