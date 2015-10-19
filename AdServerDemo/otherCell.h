//
//  otherCell.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface otherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *news_head;
@property (weak, nonatomic) IBOutlet UIImageView *news_image;
@property (weak, nonatomic) IBOutlet UILabel *news_article;

@end
