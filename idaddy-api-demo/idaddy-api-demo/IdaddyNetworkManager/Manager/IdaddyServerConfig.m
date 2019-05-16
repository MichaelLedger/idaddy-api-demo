//
//  IdaddyServerConfig.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/16.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "IdaddyServerConfig.h"

@implementation IdaddyServerConfig

static IdaddyServerConfig *_shared = nil;
+ (instancetype)sharedConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[IdaddyServerConfig alloc] init];
    });
    return _shared;
}

- (void)configServerType:(IdaddyServerType)serverType {
    _serverType = serverType;
}

@end
