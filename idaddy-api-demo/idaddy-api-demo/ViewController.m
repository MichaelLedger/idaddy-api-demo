//
//  ViewController.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/15.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#define iDaddyMetaDataAppId     @"idaddy0000000013"
#define iDaddyMetaDataSecret    @"stCcpBbJxh90XzFiUL6kW72Gog4K8ZMf"
#define iDaddyAPIAppId          @"idaddy013"
#define iDaddyAPISecret         @"8a6d3efca75fb5df3385fc7547e6f6addd1778d1"

#define kTimeOutInterval        30

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+random.h"
#import "NSString+SHA1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchMetaData];
}

- (void)fetchMetaData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *strIDFV = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    // 获取自1970年毫秒数
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    NSString *nonce = [NSString ret32bitString];
    NSString *signature = [[NSString stringWithFormat:@"%@%@%@", iDaddyMetaDataAppId, iDaddyMetaDataSecret, curTime] sha1];
    NSDictionary *param = @{@"app_id" : iDaddyMetaDataAppId,
                            @"timestamp" : curTime,
                            @"nonce" : nonce,
                            @"sign_type" : @"sha1",
                            @"signature" : signature,
                            @"device_id" : strIDFV};
    NSLog(@"param: %@", param);
    
    /*
     正式域名：open.idaddy.cn
     测试域名：wt2-open.idaddy.cn
     */
    [manager POST:@"https://wt2-open.idaddy.cn/api/v3/work/metadata" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSError *jsonSerializationError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonSerializationError];
            if (!jsonSerializationError) {
                NSLog(@"responseSuccess:%@", dict);
            } else {
                NSLog(@"%@", jsonSerializationError.localizedDescription);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}


@end
