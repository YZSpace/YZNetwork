//
//  YZLoginRequest.m
//  YZNetwork_Example
//
//  Created by 黄亚州 on 2020/3/20.
//  Copyright © 2020 zone1026. All rights reserved.
//

#import "YZLoginRequest.h"

@interface YZLoginRequest ()
/// 账户名
@property (nonatomic, strong) NSString *userName;
/// 账户密码
@property (nonatomic, strong) NSString *password;

@end


@implementation YZLoginRequest

#pragma mark - init

- (instancetype)init {
    return [self initUserName:@"xxx" withPassword:@"xxx"];
}

- (instancetype)initUserName:(NSString *)userName withPassword:(NSString *)password {
    if (self = [super init]) {
        self.userName = userName;
        self.password = password;
    }
    
    return self;
}


#pragma mark - 请求配置

/// 登录接口 HTTP 请求方式
/// @return 请求方式
- (YZRequestMethod)requestMethod {
    return YZRequestMethodPOST;
}

/// 登录接口请求scheme协议类型
/// @return scheme协议类型
- (YZSchemeProtocolType)requestSchemeProtocolType {
    return YZSchemeProtocolTypeHttp;
}

/// 登录接口地址路径（/api/v1/login）
/// @return 请求地址
- (NSString *)requestInterfaceURLString {
    return @"/api/v1/login";
}

/// 登录接口请求参数
/// @return 请求参数
- (id)requestParam {
    return @{
        @"user_name":self.userName,
        @"password":self.password,
        @"device_id":@"f9a9b953527df49e",
        @"offcn-dateTime":@"2020-03-18 19:11:21",
        @"appsystem":@"iOS",
        @"device_type":@"iphone 6s",
        @"appversion":@"1.0.0"
    };
}

@end
