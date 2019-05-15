//
//  NSString+random.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/15.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "NSString+random.h"

@implementation NSString (random)

+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

@end
