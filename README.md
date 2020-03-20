# YZNetwork

[![CI Status](https://img.shields.io/travis/zone1026/YZNetwork.svg?style=flat)](https://travis-ci.org/zone1026/YZNetwork)
[![Version](https://img.shields.io/cocoapods/v/YZNetwork.svg?style=flat)](https://cocoapods.org/pods/YZNetwork)
[![License](https://img.shields.io/cocoapods/l/YZNetwork.svg?style=flat)](https://cocoapods.org/pods/YZNetwork)
[![Platform](https://img.shields.io/cocoapods/p/YZNetwork.svg?style=flat)](https://cocoapods.org/pods/YZNetwork)

## YZNetwork 是什么

YZNetwork 是基于 [AFNetworking][AFNetworking] 封装的iOS端简易网络库，通过创建请求对象的方式处理网络接口

## YZNetwork 的基本思路

YZNetwork的基本思想是参考[YTKNetwork](https://github.com/yuantiku/YTKNetwork.git)的思路，把每一个网络请求封装成对象，与第三方网络库剥离，使第三方库类文件不必散落在各个业务模块中。

目前YZNetwork的功能相对比较单一，比如接口数据存储功能还没实现，在后期迭代中会开发。

## 安装

你可以在 Podfile 中加入下面一行代码来使用 YZNetwork

```ruby
pod 'YZNetwork'
```

## 安装要求

YZNetwork 依赖于 AFNetworking ~>3.2版本进行的封装，可以在 [AFNetworking README](https://github.com/AFNetworking/AFNetworking) 中找到更多关于依赖版本有关的信息。

## 相关的使用说明

YZNetwork 的思路是把每一个网络请求封装成对象。目前只开放了YZBaseRequest，建议根据自己的项目需求再次封装YZBaseRequest。

### YZBaseRequest 类

 YZBaseRequest是请求对象基类，通过对父类的封装重写以适应自己的项目。比如Example项目中的YZExampleRequest，统一配置有关网络请求的参数，请求超时时间、请求方式、请求域名等等。

 ```objectivec
 
 // YZExampleRequest.h
 
 #import <YZNetwork/YZNetwork.h>

 NS_ASSUME_NONNULL_BEGIN

 @class YZExampleResponseModel;

 /// 请求结果回调
 /// @param responseModel 请求返回数据模型
 typedef void (^YZExampleResponseBlock)(__kindof YZExampleResponseModel *responseModel);

 /**
  * 根据自己的项目重构请求对象
  *
  * 配置请求超时时间、请求方式、请求域名等等
  */
 @interface YZExampleRequest : YZBaseRequest

 /// 开始请求接口
 /// @param block 请求完成后的回调
 - (void)startExampleRequestWithCompletionBlock:(YZExampleResponseBlock)block;

 @end

 @interface YZExampleResponseModel : NSObject
 /// 请求code码，后台返回的
 @property (nonatomic, assign) NSInteger code;
 /// 请求成功或者失败的描述信息，后台返回的
 @property (nonatomic, strong) NSString *msg;
 /// 请求拿到的数据
 @property (nonatomic, strong) id responseData;

 @end

 NS_ASSUME_NONNULL_END

// YZExampleRequest.m

#import "YZExampleRequest.h"

@interface YZExampleRequest ()

/// 请求返回数据回调
@property (nonatomic, copy) YZExampleResponseBlock responseBlock;
@end

@implementation YZExampleRequest

#pragma mark - Public

- (void)startExampleRequestWithCompletionBlock:(YZExampleResponseBlock)block {
    self.responseBlock = block;
    
    __weak typeof(self) weakSelf = self;
    [self startRequestWithCompletionBlock:^(__kindof YZBaseRequest * _Nonnull request) {
        [weakSelf handleRequestCompletion:request];
    }];
}

#pragma mark - Private

/// 请求完成后的处理
/// @param request 请求对象
- (void)handleRequestCompletion:(YZBaseRequest *)request {
    YZExampleResponseModel *model = [[YZExampleResponseModel alloc] init];
    model.code = request.responseStatusCode;
    if (request.error != nil) {
        model.msg = request.error.localizedDescription;
    }
    
    if (request.responseObject != nil &&
        [request.responseObject isKindOfClass:[NSDictionary class]]) {
        model.code = [[request.responseObject objectForKey:@"msg"] integerValue];
        model.msg = [request.responseObject objectForKey:@"msg"];
        model.responseData = [request.responseObject objectForKey:@"data"];
    }
    
    if (self.responseBlock != nil) {
        self.responseBlock(model);
    }
}

#pragma mark - YZNetwork 配置

/// 请求超时时间
/// @return 超时时间
- (NSTimeInterval)requestTimeoutInterval {
    return 30.0f;
}

/// 请求时是否允许使用蜂窝网络
/// @return 是否允许使用蜂窝网络
- (BOOL)allowsCellularAccess {
    return YES;
}

/// 请求域名（example.com）
/// @return 请求域名
- (NSString *)requestRealmNameString {
    return @"xxx.example.com";
}

/// http请求的编码格式
/// @return 编码格式
- (YZRequestSerializerType)requestSerializerType {
    return YZRequestSerializerTypeJSON;
}

/// http请求返回结果的编码格式
/// @return 编码格式
- (YZResponseSerializerType)responseSerializerType {
    return YZResponseSerializerTypeJSON;
}

/// http请求头所携带的app用户账号和密码数据
/// 数组包含了2个元素，第一个元素是账号，最后一个元素是密码
/// @return 用户账号和密码组成的数组
- (NSArray <NSString *> *)requestAuthorizationHeaderFieldArray {
    return nil;
}

/// http请求头中包含的请求参数数据
/// 格式为Key-Value方式
/// @return http请求头中的参数
- (NSDictionary <NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    return @{@"Content-Type":@"application/json; charset=utf-8",@"token":@"xxxxxx",@"dateTime":[NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]]};
}

/// 多媒体上传，文件构建回调
/// @return 多媒体上传回调
- (YZConstructingBlock)constructingBodyBlock {
    return nil;
}

/// 检查responseStatusCode是否有效
/// @return responseStatusCode是否有效
- (BOOL)statusCodeValidator {
    return [super statusCodeValidator];
}

@end

@implementation YZExampleResponseModel

@end

```
每个网络请求继承 YZExampleRequest 类后，需要用方法重写的方式，来指定网络请求的具体信息，比如我们要做一个登录接口。那么应该这么写，如下所示：

```objectivec
// YZLoginRequest.h

#import "YZExampleRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
* 具体某个请求对象，比如登录
*/
@interface YZLoginRequest : YZExampleRequest
/// 初始化登陆接口对象
/// @param userName 账户名
/// @param password 账户密码
- (instancetype)initUserName:(nonnull NSString *)userName withPassword:(nonnull NSString *)password NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

// YZLoginRequest.m

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

```

通过这个示例中，我们可以看到：

 * 通过重写requestTimeoutInterval、requestRealmNameString、requestSerializerType、responseSerializerType、requestHeaderFieldValueDictionary等方法YZExampleRequest类完善了网络接口的超时时间、接口域名、请求头等数据。
 * YZExampleRequest也重写了自己项目所需的开始请求方法、请求返回block等方法
 * 通过重写requestMethod、requestSchemeProtocolType、requestInterfaceURLString、requestParam方法YZLoginRequest类完善了登录接口所需参数。
 
## YZLoginRequest 使用

在构造完成 YZLoginRequest 之后，在项目中如何使用呢？我们在YZViewController页面中调用 YZLoginRequest，并使用block 的方式来取得网络请求结果：

```objectivec
- (IBAction)btnLoginClick:(UIButton *)sender {
    YZLoginRequest *request = [[YZLoginRequest alloc] initUserName:@"131xxxx1234" withPassword:@"123"];
    [request startExampleRequestWithCompletionBlock:^(__kindof YZExampleResponseModel * _Nonnull responseModel) {
        
    }];
}

```

## 感谢

YZNetwork 基于 [YTKNetwork][YTKNetwork] 和 [AFNetworking][AFNetworking]进行开发，感谢他们对开源社区做出的贡献。

## 联系方式

zone1026, 1024105345@qq.com

## 协议

YZNetwork 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

<!-- external links -->
[AFNetworking]:https://github.com/AFNetworking/AFNetworking
[YTKNetwork]:https://github.com/yuantiku/YTKNetwork.git
