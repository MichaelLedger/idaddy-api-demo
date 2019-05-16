//
//  IdaddyServerConfig.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 工程师爸爸环境配置

 - IdaddyServerTypeProduct: 正式发布环境
 - IdaddyServerTypeDevelop: 测试联调环境
 */
typedef NS_ENUM(NSUInteger, IdaddyServerType) {
    IdaddyServerTypeProduct,
    IdaddyServerTypeDevelop
};

NS_ASSUME_NONNULL_BEGIN

@interface IdaddyServerConfig : NSObject

/**
 Singleton

 @return 单例
 */
+ (instancetype)sharedConfig;

/**
 当前的环境配置类型
 */
@property (nonatomic, readonly, assign) IdaddyServerType serverType;

/**
 设置工程师爸爸环境配置

 @param serverType 环境类型
 */
- (void)configServerType:(IdaddyServerType)serverType;

@end

NS_ASSUME_NONNULL_END
