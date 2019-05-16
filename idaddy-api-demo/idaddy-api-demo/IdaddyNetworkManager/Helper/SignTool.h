//
//  SignTool.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignTool : NSObject

/**
 签名算法

 @param dict 参数
 @param appSecret APP秘钥
 @return 加密后的签名
 */
+(NSString *)signStr:(NSMutableDictionary*)dict appSecret:(NSString *)appSecret;

@end

NS_ASSUME_NONNULL_END
