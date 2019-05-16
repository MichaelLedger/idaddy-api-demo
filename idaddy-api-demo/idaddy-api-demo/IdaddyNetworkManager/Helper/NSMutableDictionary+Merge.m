//
//  NSMutableDictionary+Merge.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "NSMutableDictionary+Merge.h"

@implementation NSMutableDictionary (Merge)

- (id)mutableDictionaryCopyIfNeeded:(id)dictObj
{
    if ([dictObj isKindOfClass:[NSDictionary class]] &&
        ![dictObj isKindOfClass:[NSMutableDictionary class]]) {
        dictObj = [dictObj mutableCopy];
    }
    return dictObj;
}

/**
 合并两个字典
 
 @param dict 被合并的字典
 */
- (void)mergingWithDictionary:(NSDictionary *)dict
{
    for (id key in [dict allKeys]) {
        id obj = [self mutableDictionaryCopyIfNeeded:[dict objectForKey:key]];
        id localObj = [self mutableDictionaryCopyIfNeeded:[self objectForKey:key]];
        if ([obj isKindOfClass:[NSDictionary class]] &&
            [localObj isKindOfClass:[NSMutableDictionary class]]) {
            // Recursive merge for NSDictionary
            [localObj mergingWithDictionary:obj];
        } else if (obj) {
            [self setObject:obj forKey:key];
        }
    }
}

/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKey 忽略的Key
 */
- (void)mergingWithDictionary:(NSDictionary *)dict ignoredDictKey:(NSString *)ignoredKey
{
    for (id key in [dict allKeys]) {
        if ([key isEqualToString:ignoredKey]) {
            continue;
        }
        id obj = [self mutableDictionaryCopyIfNeeded:[dict objectForKey:key]];
        id localObj = [self mutableDictionaryCopyIfNeeded:[self objectForKey:key]];
        if ([obj isKindOfClass:[NSDictionary class]] &&
            [localObj isKindOfClass:[NSMutableDictionary class]]) {
            // Recursive merge for NSDictionary
            [localObj mergingWithDictionary:obj];
        } else if (obj) {
            [self setObject:obj forKey:key];
        }
    }
}

@end
