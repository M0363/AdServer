//
//  NewsDataStatic.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 06/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDataStatic : NSObject
+ (NewsDataStatic *)sharedInstance;
- (NSDictionary *) getConfigData;

-(id) lookupConfigByKey:(NSString *)key;
@end
