//
//  AdServerHTTPClient.m
//  Coop
//
//  Created by Pankaj Verma on 18/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
#import "AdServerHTTPClient.h"
#import "AppConfig.h"

static NSString * const WorldAdServerOnlineURLString1 = @"http://10.193.66.132:9090/tavantAds/api/";
@implementation AdServerHTTPClient


+ (AdServerHTTPClient *)sharedAdServerHTTPClient
{
    static AdServerHTTPClient *_sharedAdServerHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       // _sharedAdServerHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WorldAdServerOnlineURLString1]];
        _sharedAdServerHTTPClient = [[self alloc]init];
    });
    
    return _sharedAdServerHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}


- (void)getAdFromServer:(NSString *)headerOrFooter forCategory: (NSString *)category
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *url = [[AppConfig sharedInstance] lookupConfigByKey:@"CONFIG_URL"];

    parameters[@"id"] = category;
    parameters[@"size"] = @"728x90";
    parameters[@"page"] = @"home";
    parameters[@"loc"] = @"";
    if ([headerOrFooter isEqualToString:@"section"]) {
    
    [manager GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didUpdateWithAdServer_section:)]) {
            [self.delegate AdServerHTTPClient:self didUpdateWithAdServer_section:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didFailWithError_section:)]) {
            [self.delegate AdServerHTTPClient:self didFailWithError_section:error];
        }
    }];
    }
    else{
        [manager GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didUpdateWithAdServer_footer:)]) {
                [self.delegate AdServerHTTPClient:self didUpdateWithAdServer_footer:responseObject];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didFailWithError_footer:)]) {
                [self.delegate AdServerHTTPClient:self didFailWithError_footer:error];
            }
        }];

    }
}


 @end
