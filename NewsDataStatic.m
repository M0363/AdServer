//
//  NewsDataStatic.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 06/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "NewsDataStatic.h"

@implementation NewsDataStatic

+( NewsDataStatic *) sharedInstance{
    
    static dispatch_once_t shared_initialized;
    static  NewsDataStatic *shared_instance = nil;
    
    dispatch_once(&shared_initialized, ^ {
        shared_instance = [[NewsDataStatic alloc] init];
        
    });
    return shared_instance;
    
}

-(NSDictionary *)getConfigData{
    
    
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"newsData" ofType:@"json"];
    
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    id Keys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    return Keys;
}

-(id) lookupConfigByKey:(NSString *)key{

    NSDictionary *result = [self getConfigData];

    return [result objectForKey:key];
}
@end
