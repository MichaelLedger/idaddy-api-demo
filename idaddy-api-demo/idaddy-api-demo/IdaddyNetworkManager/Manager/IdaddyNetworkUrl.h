//
//  IdaddyNetworkUrl.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#ifndef IdaddyNetworkUrl_h
#define IdaddyNetworkUrl_h

#import "IdaddyServerConfig.h"

#pragma mark - 获取元数据获取接口的AppID与AppSecret
// 正式发布环境
#define IdaddyMetaDataAppID_Product      @"idaddy0000000013"
#define IdaddyMetaDataSecret_Product     @"stCcpBbJxh90XzFiUL6kW72Gog4K8ZMf"
// 测试联调环境
#define IdaddyMetaDataAppID_Develop      @"idaddy0000000013"
#define IdaddyMetaDataSecret_Develop     @"stCcpBbJxh90XzFiUL6kW72Gog4K8ZMf"
// 当前使用的AppID
static inline NSString *IDADDY_CURRENT_METADATA_APPID() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IdaddyMetaDataAppID_Product;
        case IdaddyServerTypeDevelop:
            return IdaddyMetaDataAppID_Develop;
    }
}
// 当前使用的AppSecret
static inline NSString *IDADDY_CURRENT_METADATA_APPSECRET() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IdaddyMetaDataSecret_Product;
        case IdaddyServerTypeDevelop:
            return IdaddyMetaDataSecret_Develop;
    }
}

#pragma mark - 获取口袋故事API接口与OAutho 2.0认证接口的AppID与AppSecret
// 正式发布环境
#define IdaddyAPIAppID_Product          @"idaddy013"
#define IdaddyAPISecret_Product         @"8a6d3efca75fb5df3385fc7547e6f6addd1778d1"
// 测试联调环境
#define IdaddyAPIAppID_Develop          @"idaddy013"
#define IdaddyAPISecret_Develop         @"8a6d3efca75fb5df3385fc7547e6f6addd1778d1"
// 当前使用的AppID
static inline NSString *IDADDY_CURRENT_API_APPID() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IdaddyAPIAppID_Product;
        case IdaddyServerTypeDevelop:
            return IdaddyAPIAppID_Develop;
    }
}
// 当前使用的AppSecret
static inline NSString *IDADDY_CURRENT_API_APPSECRET() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IdaddyAPISecret_Product;
        case IdaddyServerTypeDevelop:
            return IdaddyAPISecret_Develop;
    }
}

#pragma mark - 协议
static inline NSString* IDADDYHttps(NSString* url){
    return [NSString stringWithFormat:@"https://%@", url];
}

static inline NSString* IDADDYHttp(NSString* url){
    return [NSString stringWithFormat:@"http://%@", url];
}

#pragma mark - OAuth2.0登录授权域名
// OAuth2.0正式域名
#define IdaddyOAuthProductDomain @"account.idaddy.cn"
// OAuth2.0测试域名
#define IdaddyOAuthDevelopDomain @"wt2-account.idaddy.cn"

// OAuth2.0当前使用的域名
static inline NSString *IDADDY_CURRENT_OAUTH_DOMAIN() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IDADDYHttps(IdaddyOAuthProductDomain);
        case IdaddyServerTypeDevelop:
            return IDADDYHttps(IdaddyOAuthDevelopDomain);
        default:
            return IDADDYHttps(IdaddyOAuthProductDomain);
    }
}

#pragma mark - 元数据及API域名
// 正式域名
#define IdaddyProductDomain @"open.idaddy.cn"
// 测试域名
#define IdaddyDevelopDomain @"wt2-open.idaddy.cn"

// 当前使用的域名
static inline NSString *IDADDY_CURRENT_DOMAIN() {
    IdaddyServerType serverType = [IdaddyServerConfig sharedConfig].serverType;
    switch (serverType) {
        case IdaddyServerTypeProduct:
            return IDADDYHttps(IdaddyProductDomain);
        case IdaddyServerTypeDevelop:
            return IDADDYHttps(IdaddyDevelopDomain);
        default:
            return IDADDYHttps(IdaddyProductDomain);
    }
}

// 地址拼接(domain+path)
#define IdaddyURLStringJoint(_host_, _serviceurl_)     [[NSURL URLWithString:_serviceurl_ relativeToURL:[NSURL URLWithString:_host_]] absoluteString]

#pragma mark - 路径&完整的接口请求地址
#pragma mark 获取 Authorization Code
#define Idaddy_Oauth_Authorize_Suffix_URL   @"/oauth2/authorize"
#define Idaddy_Oauth_Authorize_Intact_URL   IdaddyURLStringJoint(IDADDY_CURRENT_OAUTH_DOMAIN(), Idaddy_Oauth_Authorize_Suffix_URL)

#pragma mark 获取 Access Token
#define Idaddy_Access_Token_Suffix_URL   @"/oauth2/access_token"
#define Idaddy_Access_Token_Intact_URL   IdaddyURLStringJoint(IDADDY_CURRENT_OAUTH_DOMAIN(), Idaddy_Access_Token_Suffix_URL)

#pragma mark 获取 JWT Access Token
#define Idaddy_JWT_Access_Token_Suffix_URL   @"/oauth2/jwt_access_token"
#define Idaddy_JWT_Access_Token_Intact_URL   IdaddyURLStringJoint(IDADDY_CURRENT_OAUTH_DOMAIN(), Idaddy_JWT_Access_Token_Suffix_URL)

#pragma mark 获取当前应用套餐下所有作品信息及声音信息 POST
#define Idaddy_MetaData_Suffix_URL   @"/api/v3/work/metadata"
#define Idaddy_MetaData_Intact_URL   IdaddyURLStringJoint(IDADDY_CURRENT_DOMAIN(), Idaddy_MetaData_Suffix_URL)

#pragma mark 合作方可以拉取到所有可以售卖的VIP商品信息 GET
#define Idaddy_API_V1_Outer_Goods_Vip_Suffix_URL   @"/inside/api/v1/outer/goods/vip"
#define Idaddy_API_V1_Outer_Goods_Vip_Intact_URL   IdaddyURLStringJoint(IDADDY_CURRENT_DOMAIN(), Idaddy_API_V1_Outer_Goods_Vip_Suffix_URL)

#endif /* IdaddyNetworkUrl_h */
