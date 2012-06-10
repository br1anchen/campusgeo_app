//
//  RegisterViewController.m
//  CampusGeo
//
//  Created by Brian Chen on 6/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegisterViewController.h"
#import "ASIFormDataRequest.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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

- (IBAction)registerUser:(id)sender {
    NSString *respone = [self registerInfo2Server];
    if([respone isEqualToString:@"true"])
    {
        [self performSegueWithIdentifier:@"back2MainView" sender:self];
    }else
    {
        NSLog(@"something wrong with input or internet");
    }
}

#define HOST_DOMAIN @"192.168.1.6:8080"
-(NSString *)registerInfo2Server
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/user/new?username=%@&password=%@&role=%@",HOST_DOMAIN,usernameText.text,passwordText.text,roleText.text]];//set the url of server
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url]; //make a ASIHTTP request 
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request startSynchronous]; //start to send the message
    
    NSString *strResponse;
    NSError *error;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:&error];
    if(jsonData != nil){
        NSLog(@"push social notification success");
        strResponse = [jsonData objectForKey:@"status"];
    }else{
        NSLog(@"push social notification failed");
        strResponse = @"false";
    }
    
    return strResponse;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if(touch.view.tag != 1)
    {
        [usernameText resignFirstResponder];
        [passwordText resignFirstResponder];
        [roleText resignFirstResponder];
    }
    
}

- (IBAction)getRidOfKeyboard:(id)sender
{
    [usernameText resignFirstResponder];
    [usernameText resignFirstResponder];
    [roleText resignFirstResponder];
}

@end
