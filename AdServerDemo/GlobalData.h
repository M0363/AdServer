//
//  GlobalData.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
//@import UIKit;
@interface GlobalData : NSObject
+(NSArray *)getBannerAds;
+(NSArray *)getTextAds;


//+(NSString *)getAdImageUrlByKey:(NSString *)key forUserId:(NSString *)userID;
//+(NSString *)getAdClickedThroughUrl:(NSString *)urlKey forUserId:(NSString *)userID;
//+(UIColor *)getBGCOLOR;
@end
