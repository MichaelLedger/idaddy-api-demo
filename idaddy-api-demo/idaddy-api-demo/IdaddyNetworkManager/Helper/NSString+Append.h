//
//  NSString+Append.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Append)

/**
 URL字符串添加参数
 
 @param key 参数键
 @param value 参数值
 @return 拼接了参数的URL字符串
 */
- (NSString *)urlAppendCompnentWithKey:(NSString *)key value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
