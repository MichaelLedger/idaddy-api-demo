//
//  IdaddyNetworkManager.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^IdaddyNetworkSuccess)(id _Nullable response);
typedef void(^IdaddyNetworkFailure)(NSError * _Nonnull error);

NS_ASSUME_NONNULL_BEGIN

@interface IdaddyNetworkManager : NSObject

/**
 获取当前应用套餐下所有作品信息及声音信息

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)fetchMetaDataSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 获取 Authorization Code

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)fetchAuthorizationCodeSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 使用 AuthorizationCode，从工爸会员授权服务获取 AccessToken

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)fetchAccessTokenSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 刷新 AccessToken
 
 由于AccessToken拥有较短的有效期，当AccessToken超时后，可以使用RefreshToken进行刷新，RefreshToken有效期为15天，当RefreshToken失效之后，需要用户重新授权

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)refreshAccessTokenWithRefreshToken:(NSString *)refreshToken Success:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 使用 AuthorizationCode，从工爸会员授权服务获取 JWT Access Token
 
 默认格式的 AccessToken 长度较短，类似于SessionId，在服务端记录有状态，优点是易于存储和网络通讯，但是在访问工爸资源服务时需要跨服务鉴权，性能稍差。
 工爸会员授权服务还提供了 JWT 格式的 AccessToken，特点正好相反，长度较长，无状态，访问工爸资源服务只需要本地校验不用跨服务鉴权，性能优势明显。
 合作方可以根据自己的需求选择不同的格式，我们推荐采用 JWT AccessToken。
 获取和刷新 JWT AccessToken 的协议与默认格式的完全相同，只需修改接口地址即可。
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)fetchJWTAccessTokenSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 刷新 JWT Access Token
 
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)refreshJWTAccessTokenWithRefreshToken:(NSString *)refreshToken Success:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

/**
 合作方可以拉取到所有可以售卖的VIP商品信息

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)fetchAPIOuterGoodsVIPSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure;

@end

NS_ASSUME_NONNULL_END
