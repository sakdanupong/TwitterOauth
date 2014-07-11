//
//  ViewTwitterOauth.m
//  TwitterOauth
//
//  Created by Apple on 7/11/14.
//  Copyright (c) 2014 myself. All rights reserved.
//

#import "ViewTwitterOauth.h"

@interface ViewTwitterOauth ()
@property (nonatomic, strong) NSString *mAPIKEY;
@property (nonatomic, strong) NSString *mSECRETKEY;
@property (nonatomic, strong) UIWebView *mWebView;
@end


@implementation ViewTwitterOauth
@synthesize mAPIKEY;
@synthesize mSECRETKEY;
@synthesize mWebView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupTwitterApiKey:(NSString*)twitter_api_key twitter_secret_key:(NSString*)twitter_secret_key {
    mAPIKEY = twitter_api_key;
    mSECRETKEY = twitter_secret_key;

    mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    [self addSubview:mWebView];
    [self requestToken];
    
}

- (void)requestToken {
    [mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
