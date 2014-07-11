//
//  API.m
//  TwitterOauth
//
//  Created by Apple on 7/11/14.
//  Copyright (c) 2014 myself. All rights reserved.
//

#import "API.h"

static API *constant;

@implementation API

- (id) init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+ (API*)getAPI {
    if (!constant)
        constant = [API new];
    
    return constant;
}

@end
