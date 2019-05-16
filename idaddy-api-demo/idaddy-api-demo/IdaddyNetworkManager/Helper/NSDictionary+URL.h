//
//  NSDictionary+URL.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (URL)

/**
 将请求参数字典转换为参数字符串
 
 @param urlstr 请求地址
 @return 拼接了字典所有参数的地址
 */
- (NSString *)URLRequestStringWithURLStr:(NSString *)urlstr;

@end

NS_ASSUME_NONNULL_END
