//
//  ViewController.m
//  TwitterOauth
//
//  Created by Apple on 7/11/14.
//  Copyright (c) 2014 myself. All rights reserved.
//

#import "ViewController.h"
#import "FHSTwitterEngine.h"
#import "API.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[FHSTwitterEngine sharedEngine] permanentlySetConsumerKey:API_KEY andSecret:SECRET_KEY];
    [[FHSTwitterEngine sharedEngine] loadAccessToken];
    
    if ([[FHSTwitterEngine sharedEngine]isAuthorized]) {
        //[self postToTwitter];
        NSLog(@"isAuthorized");
    } else {
        UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
            if (success)
                [self postToTwitter];
        } showNavBar:YES];
        [self presentViewController:loginController animated:YES completion:nil];
    }
 
    
    
}

- (void)postToTwitter {
    UIImage *image = [UIImage imageNamed:@"quote1.jpg"];
    NSData *data = UIImagePNGRepresentation(image);
    [[FHSTwitterEngine sharedEngine] postTweet:@"Test image from thai quote" withImageData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"success");
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
