//
//  API.h
//  TwitterOauth
//
//  Created by Apple on 7/11/14.
//  Copyright (c) 2014 myself. All rights reserved.
//

#import <Foundation/Foundation.h>


// Twitter
#define API_KEY @"Hc10d6mhAKS2o7Upq5zFPkeIQ"
#define SECRET_KEY @"RnpDJSG5GiSx1kUcwlkoOkofMjxV5VaQcZy2a0irQoQejYa9Ll"

@interface API : NSObject {
    @public
}

+ (API*)getAPI;

@end
