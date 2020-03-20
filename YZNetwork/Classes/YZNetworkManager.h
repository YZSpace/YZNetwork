//
//  YZNetworkManager.h
//  YZNetwork
//
//  Created by 黄亚州 on 2019/12/21.
//  Copyright © 2019 iOS开发者. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YZBaseRequest;
/**
 http网络请求管理器，处理网络接口的触发
 */
@interface YZNetworkManager : NSObject

/// 网络请求单例对象
/// @return 单例对象
+ (YZNetworkManager *)sharedManager;

#pragma mark - 添加/取消请求对象

/// 根据请求对象添加请求操作
/// @param request 请求对象
- (void)addRequest:(YZBaseRequest *)request;

/// 根据请求对象取消请求
/// @param request 请求对象
- (void)cancelRequest:(YZBaseRequest *)request;

/// 对请求池的请求对象做取消请求操作
- (void)cancelAllRequests;

@end

NS_ASSUME_NONNULL_END
