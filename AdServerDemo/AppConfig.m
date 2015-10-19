//
//  AppConfig.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "AppConfig.h"
#include "AFNetworking.h"
#import "GDataXMLNode.h"


@implementation AppConfig



+( AppConfig *) sharedInstance{
    
    static dispatch_once_t shared_initialized;
    static  AppConfig *shared_instance = nil;
    
    dispatch_once(&shared_initialized, ^ {
        shared_instance = [[AppConfig alloc] init];
    
    });
    return shared_instance;

}

-(NSDictionary *)getConfigData{
    
    
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    id Keys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
       return Keys;
}

-(id) lookupConfigByKey:(NSString *)key{
    
//    client = [AdServerHTTPClient sharedAdServerHTTPClient];
//    client.delegate = self;
//    [client updateAdServerAtLocation:nil forCategory:key];
    NSDictionary *result = [self getConfigData];
   // [self getConfigDataFromBaseUrlString:nil andParameters:nil];
    return [result objectForKey:key];
}
//-(void)fetchServerByUserId:(NSString *)userID{
////    client = [AdServerHTTPClient sharedAdServerHTTPClient];
// client = [[AdServerHTTPClient alloc]init];
//    client.delegate = self;
//    [client updateAdServerAtLocation:nil forCategory:userID];
//}
//-(void)getConfigDataFromBaseUrlString:(NSString *)urlString andParameters :(NSMutableDictionary *)param
//{
//       NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
//    //    parameters[@"num_of_days"] = @(number);
//    //    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",-33.7969235,150.9224326];
//    //    parameters[@"format"] = @"json";
//    //    parameters[@"key"] = WorldAdServerOnlineAPIKey;
//    parameters[@"id"] = @"f2";
//    parameters[@"size"] = @"728x90";
//    parameters[@"page"] = @"home";
//    parameters[@"loc"] = @"E";
//
//    [manager GET:@"http://10.193.66.132:9090/tavantAds/api/getAdResponse" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        resultLive = responseObject;
////        if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didUpdateWithAdServer:)]) {
////            [self.delegate AdServerHTTPClient:self didUpdateWithAdServer:responseObject];
//        //}
//        printf("%ld\n",resultLive.count);
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
////        if ([self.delegate respondsToSelector:@selector(AdServerHTTPClient:didFailWithError:)]) {
////            [self.delegate AdServerHTTPClient:self didFailWithError:error];
////        }
//        resultLive = nil;
//    }];
//   
//}

#pragma mark - News Download

-(void)downloadFeed:(NSURL *)url{
   // NSError *error;

    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        printf("successed\n");
        NSData *data = (NSData *)responseObject;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data                                                       options:0 error:nil];
        GDataXMLElement *channel = [[doc.rootElement elementsForName:@"channel"] lastObject];
        [[self NewsDelegate] getNewsData:channel];
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         [[self NewsDelegate] ErrorNewsData];
                                         
                                     }];
    
    [operation start];
    
       }
#pragma mark - AdServerHTTPClientDelegate


@end
