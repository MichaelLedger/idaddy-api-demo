//
//  NSMutableDictionary+Merge.h
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (Merge)

/**
 合并两个字典
 
 @param dict 被合并的字典
 */
- (void)mergingWithDictionary:(NSDictionary *)dict;

/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKey 忽略的Key
 */
- (void)mergingWithDictionary:(NSDictionary *)dict ignoredDictKey:(NSString *)ignoredKey;

@end

NS_ASSUME_NONNULL_END
