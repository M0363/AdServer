//
//  otherCell.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "otherCell.h"

@implementation otherCell

- (void)awakeFromNib {
    // Initialization code
    self.news_head.layer.cornerRadius = 10.0f;
    self.containerView.layer.cornerRadius = 10.0f;
    self.containerView.layer.borderWidth = 1.0f;
    self.containerView.layer.borderColor = [UIColor redColor].CGColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (void)layoutSubviews
//{
//    self.news_article.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds);
//    [super layoutSubviews];
//}
@end
