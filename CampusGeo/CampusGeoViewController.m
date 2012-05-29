//
//  CampusGeoViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CampusGeoViewController.h"
#import "LoginBrain.h"

@interface CampusGeoViewController ()
@property (nonatomic,strong) LoginBrain *loginbrain;
@end

@implementation CampusGeoViewController
@synthesize username,password,loginInfo;
@synthesize loginbrain = _loginbrain;

- (LoginBrain *)loginbrain
{
    if(!_loginbrain) _loginbrain = [[LoginBrain alloc] init];
    return _loginbrain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)checkAndEnter
{
    [self performSegueWithIdentifier:@"EnterUserAdmin" sender:self];
}

- (IBAction)login {
    [self checkAndEnter];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EnterUserAdmin"]){
        NSLog(@"save username and password");
        [self.loginbrain setUserName:username.text];
        [self.loginbrain setPassword:password.text];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if(touch.view.tag != 1)
    {
        [username resignFirstResponder];
        [password resignFirstResponder];
    }

}

- (IBAction)getRidOfKeyboard:(id)sender
{
    [username resignFirstResponder];
    [password resignFirstResponder];
}

@end
