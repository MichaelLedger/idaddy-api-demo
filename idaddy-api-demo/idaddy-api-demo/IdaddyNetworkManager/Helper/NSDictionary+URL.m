//
//  NSDictionary+URL.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "NSDictionary+URL.h"

@implementation NSDictionary (URL)

- (NSString *)URLRequestStringWithURLStr:(NSString *)urlstr {
    
    NSMutableString *URL = [NSMutableString stringWithFormat:@"%@",urlstr];
    //获取字典的所有keys
    NSArray * keys = [self allKeys];
    
    if (keys.count == 0) {
        return URL;
    }
    
    //拼接字符串
    for (int j = 0; j < keys.count; j ++){
        NSString *string;
        if (j == 0){
            //拼接时加？
            string = [NSString stringWithFormat:@"?%@=%@", keys[j], self[keys[j]]];
            
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", keys[j], self[keys[j]]];
        }
        //拼接字符串
        [URL appendString:string];
        
    }
    return URL;
}

@end
