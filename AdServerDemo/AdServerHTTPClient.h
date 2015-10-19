//
//  AdServerHTTPClient.h
//  Coop
//
//  Created by Pankaj Verma on 18/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@protocol AdServerHTTPClientDelegate;

@interface AdServerHTTPClient : AFHTTPSessionManager
@property (nonatomic, weak) id<AdServerHTTPClientDelegate>delegate;

+ (AdServerHTTPClient *)sharedAdServerHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
- (void)getAdFromServer:(NSString *)headerOrFooter forCategory: (NSString *)category ;

@end
//@protocol HAMAdServerProtocol <NSObject>
//@optional
//-(void)AdServerHTTPClient:(AdServerHTTPClient *)client
//
//@end
@protocol AdServerHTTPClientDelegate <NSObject>
@optional
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didUpdateWithAdServer_footer:(id)AdServer;
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didFailWithError_footer:(NSError *)error;
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didUpdateWithAdServer_section:(id)AdServer;
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didFailWithError_section:(NSError *)error;
@end
