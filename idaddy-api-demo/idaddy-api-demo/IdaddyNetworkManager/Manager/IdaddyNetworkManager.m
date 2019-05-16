//
//  IdaddyNetworkManager.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "IdaddyNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "IdaddyNetworkUrl.h"
#import "NSString+random.h"
#import "NSString+SHA1.h"
#import "NSMutableDictionary+Merge.h"
#import "NSDictionary+URL.h"
#import "SignTool.h"

#define kTimeOutInterval    30

@implementation IdaddyNetworkManager

+ (void)fetchMetaDataSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:UUID, @"device_id", nil];
    [params mergingWithDictionary:[self communalRequestParamForMetaData]];
    NSLog(@"param: %@", params);
    
    [[self sessionManagerForMetaData] POST:Idaddy_MetaData_Intact_URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)fetchAuthorizationCodeSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    NSDictionary *params = @{@"client_id" : @"idaddy999",
                             @"response_type" : @"code",
                             @"redirect_uri" : @"https://m.idaddy.cn",
                             @"state" : @"12345"
                             };
    [[self sessionManagerForAPI] GET:Idaddy_Oauth_Authorize_Intact_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)fetchAccessTokenSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    //MARK: - 从上一个接口中获取AuthorizationCode
    NSString *authorizationCode = @"42a1ae2884ee29ec826522e26e7c8e9bcb7015bb";
    NSString *clientID = @"idadd999";
    NSString *clientSecret = @"XXXXXX";
    NSString *redirectUri = @"https://m.idaddy.cn";
    NSDictionary *params = @{@"grant_type" : @"authorization_code",
                             @"code" : authorizationCode,
                             @"client_id" : clientID,
                             @"client_secret" : clientSecret,
                             @"redirect_uri" : redirectUri
                             };
    [[self sessionManagerForAPI] POST:Idaddy_Access_Token_Intact_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)refreshAccessTokenWithRefreshToken:(NSString *)refreshToken Success:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    //MARK: - 从上一个接口中获取刷新码 RefreshToken
    NSString *clientID = @"idadd999";
    NSString *clientSecret = @"XXXXXX";
    NSDictionary *params = @{@"grant_type" : @"refresh_token",
                             @"refresh_token" : refreshToken,
                             @"client_id" : clientID,
                             @"client_secret" : clientSecret
                             };
    [[self sessionManagerForAPI] POST:Idaddy_Access_Token_Intact_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)fetchJWTAccessTokenSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    //MARK: - 从上一个接口中获取AuthorizationCode
    NSString *authorizationCode = @"42a1ae2884ee29ec826522e26e7c8e9bcb7015bb";
    NSString *clientID = @"idadd999";
    NSString *clientSecret = @"XXXXXX";
    NSString *redirectUri = @"https://m.idaddy.cn";
    NSDictionary *params = @{@"grant_type" : @"authorization_code",
                             @"code" : authorizationCode,
                             @"client_id" : clientID,
                             @"client_secret" : clientSecret,
                             @"redirect_uri" : redirectUri
                             };
    [[self sessionManagerForAPI] POST:Idaddy_JWT_Access_Token_Intact_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)refreshJWTAccessTokenWithRefreshToken:(NSString *)refreshToken Success:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    //MARK: - 从上一个接口中获取刷新码 RefreshToken
    NSString *clientID = @"idadd999";
    NSString *clientSecret = @"XXXXXX";
    NSDictionary *params = @{@"grant_type" : @"refresh_token",
                             @"refresh_token" : refreshToken,
                             @"client_id" : clientID,
                             @"client_secret" : clientSecret
                             };
    [[self sessionManagerForAPI] POST:Idaddy_JWT_Access_Token_Intact_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)fetchAPIOuterGoodsVIPSuccess:(IdaddyNetworkSuccess)success failure:(IdaddyNetworkFailure)failure {
    NSDictionary *params = [self communalRequestParamForAPI];
    [[self sessionManagerForAPI] GET:Idaddy_API_V1_Outer_Goods_Vip_Intact_URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - Private Methods
+ (AFHTTPSessionManager *)sessionManagerForMetaData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

+ (AFHTTPSessionManager *)sessionManagerForAPI {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //MARK: - 用户AccessToken
    NSString *accessToken = @"";
    [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

+ (NSDictionary *)communalRequestParamForMetaData {
    // 获取自1970年毫秒数
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    NSString *nonce = [NSString ret32bitString];
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@", IDADDY_CURRENT_METADATA_APPID(), IDADDY_CURRENT_METADATA_APPSECRET(), curTime] sha1];
    NSDictionary *param = @{@"app_id" : IDADDY_CURRENT_METADATA_APPID(),
                            @"timestamp" : curTime,
                            @"nonce" : nonce,
                            @"sign_type" : @"sha1",
                            @"signature" : signature};
    return param;
}

+ (NSDictionary *)communalRequestParamForAPI {
    // 获取自1970年秒数
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    NSString *UUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *channel = @"";
    NSString *appSecret = @"";
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"appId" : IDADDY_CURRENT_API_APPID(),
                                                                                 @"deviceId" : UUID,
                                                                                 @"channel" : channel,
                                                                                 @"ts" : curTime,
                                                                                 @"signType" : @"MD5"} ];
    // 根据param和签名密钥AppSecret加密生成签名Signature
    NSString *signature = [SignTool signStr:param appSecret:appSecret];
    [param setValue:signature forKey:@"sign"];
    return param;
}

@end
