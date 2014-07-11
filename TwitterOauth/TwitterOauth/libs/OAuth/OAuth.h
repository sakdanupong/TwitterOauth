//
//  OAuth.h
//  Molome
//
//  Created by Apple on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuth : NSObject {

}

+ (NSString*)generate_nonce;
+ (NSString*)generate_time;
+ (NSString*)hmac_sha1:(NSString*)str key:(NSString*)key;

+ (NSString*)do_signature_with_postdata:(NSString*)method
                                    url:(NSString*)url
                           consumer_key:(NSString*)consumer_key
                        consumer_secret:(NSString*)consumer_secret
                                  nonce:(NSString*)nonce
                              timestamp:(NSString*)timestamp
                              post_data:(NSMutableDictionary*)arr;

+ (NSString*)do_signature_with_token_and_postdata:(NSString*)method
                                              url:(NSString*)url
                                     consumer_key:(NSString*)consumer_key
                                  consumer_secret:(NSString*)consumer_secret
                                            nonce:(NSString*)nonce
                                        timestamp:(NSString*)timestamp
                                            token:(NSString*)token
                                     token_secret:(NSString*)token_secret
                                        post_data:(NSMutableDictionary*)arr
                                   already_encode:(BOOL)already_encode;

+ (NSString*)dictToString:(NSDictionary*)dict;

@end
