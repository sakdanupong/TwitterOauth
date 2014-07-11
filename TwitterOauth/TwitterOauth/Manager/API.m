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

+ (NSDictionary*)parsParamForURL:(NSString*)url WithFirstSeparated:(NSString*)separated {
    NSMutableDictionary *save_dict = [[NSMutableDictionary alloc] init];
    
    NSArray *comp1 = [url componentsSeparatedByString:separated];
    if (comp1 && [comp1 count] > 0) {
        NSString *query = [comp1 lastObject];
        NSArray *queryElements = [query componentsSeparatedByString:@"&"];
        if (queryElements && [queryElements count] > 0) {
            for (NSString *element in queryElements) {
                NSArray *keyVal = [element componentsSeparatedByString:@"="];
                if (keyVal && [keyVal count] > 0) {
                    NSString *key = [keyVal objectAtIndex:0];
                    NSString *val = [keyVal objectAtIndex:1];
                    
                    [save_dict setObject:val forKey:key];
                }
            }
        }
    }
    return save_dict;
}

@end
