//
//  YZViewController.m
//  YZNetwork
//
//  Created by zone1026 on 03/20/2020.
//  Copyright (c) 2020 zone1026. All rights reserved.
//

#import "YZViewController.h"
#import "YZLoginRequest.h"

@interface YZViewController ()

@end

@implementation YZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginClick:(UIButton *)sender {
    YZLoginRequest *request = [[YZLoginRequest alloc] initUserName:@"131xxxx1234" withPassword:@"123"];
    [request startExampleRequestWithCompletionBlock:^(__kindof YZExampleResponseModel * _Nonnull responseModel) {
        
    }];
}

@end
