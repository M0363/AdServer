//
//  GlobalData.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "GlobalData.h"
#import "AppConfig.h"
@implementation GlobalData

+(NSArray *)getBannerAds{
    NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"BannerAds"];
    return value;

}
+(NSArray *)getTextAds{
    NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"TextAds"];
    return value;

}
//+(NSString *)getAdImageUrlByKey:(NSString *)key forUserId:(NSString *)userID{
//    
//    
//    [[AppConfig sharedInstance] fetchServerByUserId:userID];
//    NSString *value = [[AppConfig sharedInstance] lookupConfigByKey:key];
//    return value;
//}
//+(NSString *)getAdClickedThroughUrl:(NSString *)urlKey forUserId:(NSString *)userID{
//     NSString *value = [[AppConfig sharedInstance] lookupConfigByKey:urlKey];
//    return value;
//}

@end
