//
//  OAuth.m
//  Molome
//
//  Created by Apple on 1/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "OAuth.h"
#import "StringUtil.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"

@implementation OAuth

+ (NSString*)generate_nonce {
    NSString *mt = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString *rand = [NSString stringWithFormat:@"%d",arc4random()];
    NSString *for_md5 = [NSString stringWithFormat:@"%@%@", mt, rand];
    return [for_md5 md5]; // md5s look nicer than numbers
}

+ (NSString*)generate_time {
    return [NSString stringWithFormat:@"%ld",(time_t)[[NSDate date] timeIntervalSince1970]];
}


//http://www.iphonedevsdk.com/forum/iphone-sdk-development/15821-sha1.html
+ (NSString*)hmac_sha1:(NSString*)str key:(NSString*)key {
	const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
	const char *cData = [str cStringUsingEncoding:NSUTF8StringEncoding];
	unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
	CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
	NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
	return [HMAC base64EncodedString];
}


+ (NSString*)do_signature_with_postdata:(NSString*)method
                                    url:(NSString*)url
                           consumer_key:(NSString*)consumer_key
                        consumer_secret:(NSString*)consumer_secret
                                  nonce:(NSString*)nonce
                              timestamp:(NSString*)timestamp
                              post_data:(NSMutableDictionary*)arr {

	NSArray *keys = [arr allKeys];
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	NSString *encoded_parameters = @"";
	for (NSString* key in sortedKeys) {
		if([encoded_parameters compare:@""] == NSOrderedSame)
			encoded_parameters = [NSString stringWithFormat:@"%@=%@", key, [[arr objectForKey:key] urlencode]];
		else
			encoded_parameters = [NSString stringWithFormat:@"%@&%@=%@", encoded_parameters, key, [[arr objectForKey:key] urlencode]];
	}
	encoded_parameters = [encoded_parameters urlencode];
	
	
	NSString *str = [NSString stringWithFormat:@"%@&%@&%@", method, [url urlencode], encoded_parameters];
	NSString *key = [NSString stringWithFormat:@"%@&", consumer_secret];
	
	//NSLog(@"key=%@--", key);
	//NSLog(@"base64=%@--", [self hmac_sha1:str key:key]);
	
	//[arr release];
	return [[self hmac_sha1:str key:key] urlencode];
}



+ (NSString*)do_signature_with_token_and_postdata:(NSString*)method
                                              url:(NSString*)url
                                     consumer_key:(NSString*)consumer_key
                                  consumer_secret:(NSString*)consumer_secret
                                            nonce:(NSString*)nonce
                                        timestamp:(NSString*)timestamp
                                            token:(NSString*)token
                                     token_secret:(NSString*)token_secret
                                        post_data:(NSMutableDictionary*)arr
                                   already_encode:(BOOL)already_encode {
	
	[arr setObject:consumer_key forKey:@"oauth_consumer_key"];
	[arr setObject:nonce forKey:@"oauth_nonce"];
	[arr setObject:@"HMAC-SHA1" forKey:@"oauth_signature_method"];
	[arr setObject:timestamp forKey:@"oauth_timestamp"];
    if (token != nil && token.length > 0)
        [arr setObject:token forKey:@"oauth_token"];
	[arr setObject:@"1.0" forKey:@"oauth_version"];
	
	NSDictionary *arr_dict = (NSDictionary*)arr;
	
	NSArray *keys = [arr_dict allKeys];
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	
	NSString *encoded_parameters = @"";
	for (NSString* key in sortedKeys) {
		if(already_encode){
			if([encoded_parameters compare:@""] == NSOrderedSame)
				encoded_parameters = [NSString stringWithFormat:@"%@=%@", key, [arr_dict objectForKey:key]];
			else
				encoded_parameters = [NSString stringWithFormat:@"%@&%@=%@", encoded_parameters, key, [arr_dict objectForKey:key]];
		}else{
			if([encoded_parameters compare:@""] == NSOrderedSame)
				encoded_parameters = [NSString stringWithFormat:@"%@=%@", key, [[arr_dict objectForKey:key] urlencode]];
			else
				encoded_parameters = [NSString stringWithFormat:@"%@&%@=%@", encoded_parameters, key, [[arr_dict objectForKey:key] urlencode]];
		}
	}
	encoded_parameters = [encoded_parameters urlencode];
	
	
	NSString *str = [NSString stringWithFormat:@"%@&%@&%@", method, [url urlencode], encoded_parameters];
	NSString *key = [NSString stringWithFormat:@"%@&%@", consumer_secret, token_secret];
	
//	NSLog(@"str=%@--", str);
//	NSLog(@"key=%@--", key);
	//NSLog(@"base64=%@--", [self hmac_sha1:str key:key]);
	
	//xx [post_data_dict release];
	return [[self hmac_sha1:str key:key] urlencode];
}



+ (NSString*)dictToString:(NSDictionary*)dict {
	NSString *ret = [NSString stringWithFormat:@""];
	for (NSString *key in [dict allKeys]){
		NSString *value = [dict valueForKey:key];
		ret = [ret stringByAppendingFormat:@"&%@=%@",[key urlencode],[value urlencode]];
	}
	return [ret substringFromIndex:1];
}




@end
