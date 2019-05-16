//
//  NSString+Append.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "NSString+Append.h"

@implementation NSString (Append)

- (NSString *)urlAppendCompnentWithKey:(NSString *)key value:(NSString *)value {
    /*
     http://192.168.0.125:10122/html/user_Bill.html?uid=KAoAAAB2TXVxdg==&v=5.9.4&t=ios&appId=10000000000000000000000000000001&culture=zh-cn
     特别注意：该方法对进行Base64加密后参数value不能准确读取 (uid = nil)
     */
    NSDictionary *params = [self getURLParameters:self];
    if (params && [params.allKeys containsObject:key]) {
        //已经拼接了参数
        NSLog(@"%@====无需重复拼接参数:%@,%@", self, key, value);
        return self;
    }
    
    NSMutableString *string = [[NSMutableString alloc]initWithString:self];
    @try {
        NSRange range = [string rangeOfString:@"?"];
        if (range.location != NSNotFound) {//找到了
            //如果?是最后一个直接拼接参数
            if (string.length == (range.location + range.length)) {
                string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
            }else{//如果不是最后一个需要加&
                if([string hasSuffix:@"&"]){//如果最后一个是&,直接拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,value]];
                }else{//如果最后不是&,需要加&后拼接
                    string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,value]];
                }
            }
        }else{//没找到
            if([string hasSuffix:@"&"]){//如果最后一个是&,去掉&后拼接
                string = (NSMutableString *)[string substringToIndex:string.length-1];
            }
            string = (NSMutableString *)[string stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",key,value]];
        }
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    
    return string.copy;
}


/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            
            NSString *value;
            if (key) {
                // 进行优化，处理value中含有'='的情况
                if (keyValuePair.length > key.length + 1) {
                    value = [[keyValuePair substringFromIndex:key.length+1] stringByRemovingPercentEncoding];
                } else {
                    value = [pairComponents.lastObject stringByRemovingPercentEncoding];
                }
            } else {
                value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            }
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

@end
