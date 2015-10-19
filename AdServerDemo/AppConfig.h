//
//  AppConfig.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "AFHTTPSessionManager.h"
#import "AdServerHTTPClient.h"
@protocol NewsProtocol
@optional
-(void)getNewsData:(GDataXMLElement *)newsArray;
-(void)ErrorNewsData;
@end
@interface AppConfig : NSObject<AdServerHTTPClientDelegate>
@property (nonatomic, weak) id<NewsProtocol>  NewsDelegate;
+ (AppConfig *)sharedInstance;
- (NSDictionary *) getConfigData;

-(id) lookupConfigByKey:(NSString *)key;
-(void)downloadFeed:(NSURL *)url;

@end
