//
//  YZExampleRequest.h
//  YZNetwork_Example
//
//  Created by 黄亚州 on 2020/3/20.
//  Copyright © 2020 zone1026. All rights reserved.
//

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
