//
//  ViewController.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "ViewController.h"
#import "SomeController.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController{
 CGFloat itemWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    itemWidth = self.view.bounds.size.width;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds),0);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //return [[dict objectForKey:@"items"] count];
    return 6;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellIdentifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
       
      


    return cell;
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    return CGSizeMake(itemWidth/2.65, itemWidth/2.65);
 
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [self.collectionView.collectionViewLayout invalidateLayout];
//    UICollectionViewCell *__weak mycell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    // Avoid retain cycles
//    void (^animateChangeWidth)() = ^()
//    {
//        CGRect frame = mycell.frame;
//        frame.size = CGSizeMake(frame.size.width-50, frame.size.height-50);//mycell.intrinsicContentSize;
//        mycell.frame = frame;
//    };
//    __block UICollectionViewCell *newCell = mycell;
//    
//    void (^animateRetainWidth)() = ^(){
//     newCell.frame = CGRectMake(mycell.frame.origin.x, mycell.frame.origin.y, mycell.frame.size.width+50, mycell.frame.size.height+50);
//    };
//    
//    
//    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0  options:UIViewAnimationOptionCurveLinear animations:animateChangeWidth completion:
//   
////    [UIView transitionWithView:newCell duration:2.0f options:UIViewAnimationOptionCurveEaseInOut   animations:animateChangeWidth completion:
////     
//     ^(BOOL finished) {
//        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//         //whatever you want to do upon completion
//         
////         [UIView transitionWithView:newCell duration:2.0f options:UIViewAnimationOptionCurveEaseOut   animations:animateRetainWidth completion:nil];
//        
//         [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0  options:UIViewAnimationOptionCurveLinear animations:animateRetainWidth completion:
//          nil];
     UICollectionViewCell *__weak mycell = [self.collectionView cellForItemAtIndexPath:indexPath];
    void (^animate)() = ^()
        {
            //mycell.backgroundColor = [UIColor grayColor];
            mycell.alpha = 0.5;
        };
    [UIView animateWithDuration:0.2 animations:animate completion:
     ^(BOOL finished) {
                 [collectionView deselectItemAtIndexPath:indexPath animated:YES];
               // mycell.backgroundColor = [UIColor whiteColor];
         mycell.alpha = 1;

    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
    switch (indexPath.row) {
        case 0:{
            someController.viewName = @"Fitness";
            someController.userID = @"f1";
            break;
        }
        case 1:{
            someController.viewName = @"Fashion";
            someController.userID = @"f2";
            break;
        }
        case 2:{
            someController.viewName = @"Travel";
            someController.userID = @"m1";
            break;
        }
        case 3:{
            someController.viewName = @"Pets";
            someController.userID = @"f3";
            break;
        }
        case 4:{
            someController.viewName = @"Music";
            someController.userID = @"m2";
            break;
        }
        case 5:{
            someController.viewName = @"Finance";
            someController.userID = @"m3";
            break;
        }
        default:
            break;
            
    }
    [self.navigationController pushViewController:someController animated:YES];
    }] ;
}
     
@end
