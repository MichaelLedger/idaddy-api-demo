//
//  SignTool.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "SignTool.h"
#import <CommonCrypto/CommonDigest.h>

#define APPSECRET @""

@implementation SignTool

//签名算法
//签名生成的通用步骤如下：
//第一步，设所有发送或者接收到的数据为集合M，将集合M内非空参数值的参数按照参数名ASCII码从小到大排序（字典序），使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串stringA。
//特别注意以下重要规则：
//◆ 参数名ASCII码从小到大排序（字典序）；
//◆ 如果参数的值为空不参与签名；
//◆ 参数名区分大小写；
+(NSString *)signStr:(NSMutableDictionary*)dict appSecret:(NSString *)appSecret
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"signType"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //HMACMD5
    NSString *signStr = [self HMACMD5WithString:contentString WithKey:appSecret];
    return signStr;
}

/*
 规则：
 
 双方约定与AppId绑定的签名密钥AppSecret；
 生成参数键值对数组｛参数名 ： 参数值｝，签名时不含 sign 和 signType 参数；
 用参数名对数组按ASCII码升序排序；
 每个参数用“=”字符连接键值，参数之间以“&”字符连接，得到待签名字符串；
 在待签名字符串后面直接拼接 AppSecret，再做MD5等hash计算，得到全小写签名字符串 sign。
 注意：
 
 连接时参数值不能做任何编码，要使用原值；
 空值参数也要参与签名（null、nil等空值在签名时要使用空字符串）；
 除了 sign 和 signType，所有请求体中的参数都要参与签名计算，而不仅限于协议中约定的参数。
 */
+ (NSString *)HMACMD5WithString:(NSString *)toEncryptStr WithKey:(NSString *)keyStr
{
    const char *cKey  = [keyStr cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [toEncryptStr cStringUsingEncoding:NSUTF8StringEncoding];
    const unsigned int blockSize = 64;
    char ipad[blockSize];
    char opad[blockSize];
    char keypad[blockSize];
    
    unsigned int keyLen = strlen(cKey);
    CC_MD5_CTX ctxt;
    if (keyLen > blockSize) {
        CC_MD5_Init(&ctxt);
        CC_MD5_Update(&ctxt, cKey, keyLen);
        CC_MD5_Final((unsigned char *)keypad, &ctxt);
        keyLen = CC_MD5_DIGEST_LENGTH;
    }
    else {
        memcpy(keypad, cKey, keyLen);
    }
    
    memset(ipad, 0x36, blockSize);
    memset(opad, 0x5c, blockSize);
    
    int i;
    for (i = 0; i < keyLen; i++) {
        ipad[i] ^= keypad[i];
        opad[i] ^= keypad[i];
    }
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, ipad, blockSize);
    CC_MD5_Update(&ctxt, cData, strlen(cData));
    unsigned char md5[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(md5, &ctxt);
    
    CC_MD5_Init(&ctxt);
    CC_MD5_Update(&ctxt, opad, blockSize);
    CC_MD5_Update(&ctxt, md5, CC_MD5_DIGEST_LENGTH);
    CC_MD5_Final(md5, &ctxt);
    
    const unsigned int hex_len = CC_MD5_DIGEST_LENGTH*2+2;
    char hex[hex_len];
    for(i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        snprintf(&hex[i*2], hex_len-i*2, "%02x", md5[i]);
    }
    
    NSData *HMAC = [[NSData alloc] initWithBytes:hex length:strlen(hex)];
    NSString *hashStr = [[NSString alloc] initWithData:HMAC encoding:NSUTF8StringEncoding] ;
    NSString *hash= [hashStr uppercaseString];
    
    return hash;
}

/*
 范例（PHP）：
 
 function createSign($params, $secret)
 {
 unset($params['sign'], $params['signType']);
 ksort($params);
 $items = array();
 foreach($params as $k => $v){
 $items[] = $k.'='.$v;
 }
 return md5(implode('&', $items).$secret);
 }
 $params = array(
 'appId' => 'idaddy999',
 'deviceId' => 'f3ec367b-9277-4583-9915-93e7e6b37194',
 'channel' => '',
 'mobileNo' => '11024681379',
 'uniqueId' => '1793268',
 'ts' => 1532767454,
 );
 $secret = '123456';
 $params['sign'] = createSign($params, $secret); //d5717f6568feda6e4e69630a4305775b
 */

@end
