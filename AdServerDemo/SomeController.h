//
//  SomeController.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdServerHTTPClient.h"
@interface SomeController : UIViewController<UITabBarControllerDelegate,UITableViewDataSource,UITableViewDelegate,AdServerHTTPClientDelegate>
@property (nonatomic,strong) NSString * viewName;
@property NSString * userID;

@end
