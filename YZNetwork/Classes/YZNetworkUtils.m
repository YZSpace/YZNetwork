//
//  YZNetworkUtils.m
//  YZNetwork
//
//  Created by 黄亚州 on 2020/3/10.
//  Copyright © 2020 iOS开发者. All rights reserved.
//

#import "YZNetworkUtils.h"
#import "YZBaseRequest.h"

@implementation YZNetworkUtils

+ (NSStringEncoding)stringEncodingWithRequest:(YZBaseRequest *)request {
    NSStringEncoding stringEncoding = NSUTF8StringEncoding;
    if (request.response.textEncodingName != nil) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)request.response.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            stringEncoding = CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    
    return stringEncoding;
}

@end
