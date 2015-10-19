//
//  Entity+CoreDataProperties.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 08/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface Entity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *heading;
@property (nullable, nonatomic, retain) NSString *news_image;
@property (nullable, nonatomic, retain) NSString *article;
@property (nullable, nonatomic, retain) NSString *category;

@end

NS_ASSUME_NONNULL_END
