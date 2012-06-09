//
//  AddFriendViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddFriendViewController.h"
#import "SocialDataViewController.h"
#import "SocialBrain.h"

@interface AddFriendViewController ()
@property (nonatomic,strong) SocialBrain *socialbrain;
@end

@implementation AddFriendViewController
@synthesize socialbrain = _socialbrain;

- (SocialBrain *)socialbrain
{
    if(!_socialbrain) _socialbrain = [[SocialBrain alloc] init];
    return _socialbrain;
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
    
    newFriendInfo.text = @"Add your new friend";
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

- (IBAction)sendNotification:(id)sender {
    if([self.socialbrain sendSocialNoti:friendName.text :socialType.text])
    {
        [self performSegueWithIdentifier:@"back2SocialData" sender:self];
        newFriendInfo.text = @"Wait your new friend permission";
    }else
    {
        newFriendInfo.text = @"Something wrong with your input or network.";
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"back2SocialData"])
    {
        NSLog(@"show user social");
        NSString *hostuser = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        NSArray *friends = [self.socialbrain getSocialList:hostuser];
        [segue.destinationViewController setFriends:friends];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if(touch.view.tag != 1)
    {
        [friendName resignFirstResponder];
        [socialType resignFirstResponder];
    }
    
}

- (IBAction)getRidOfKeyboard:(id)sender
{
    [friendName resignFirstResponder];
    [socialType resignFirstResponder];
}

@end
