//
//  ViewController.m
//  idaddy-api-demo
//
//  Created by MountainX on 2019/5/15.
//  Copyright © 2019 MTX Software Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "IdaddyNetworkManager.h"
#import "IdaddyServerConfig.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[IdaddyServerConfig sharedConfig] configServerType:IdaddyServerTypeProduct];
    
//    [IdaddyNetworkManager fetchMetaDataSuccess:^(id  _Nullable response) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
    
//    [IdaddyNetworkManager fetchAuthorizationCodeSuccess:^(id  _Nullable response) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
    
    [IdaddyNetworkManager fetchAccessTokenSuccess:^(id  _Nullable response) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
//    [IdaddyNetworkManager fetchAPIOuterGoodsVIPSuccess:^(id  _Nullable response) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
}

@end
