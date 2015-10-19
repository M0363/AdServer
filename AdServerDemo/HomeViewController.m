//
//  HomeViewController.m
//  Coop
//
//  Created by Pankaj Verma on 15/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewController.h"
#import "SomeController.h"

//#import "NewsViewController.h"
//#import "HAMWeatherViewController.h"
//#import "CropPricesViewController.h"
//#import "TwitterChannelViewController.h"
//#import "GlobalVariables.h"

@interface HomeViewController ()

//@property (weak, nonatomic) IBOutlet UIView *sport;
//@property (weak, nonatomic) IBOutlet UIView *fashion;
//
//@property (weak, nonatomic) IBOutlet UIView *travel;
//@property (weak, nonatomic) IBOutlet UIView *finance;
//
//@property (weak, nonatomic) IBOutlet UIView *luxury;
//@property (weak, nonatomic) IBOutlet UIView *fitness;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;

@property (weak, nonatomic) IBOutlet UIButton *fitness;
@property (weak, nonatomic) IBOutlet UIButton *fashion;

@property (weak, nonatomic) IBOutlet UIButton *travel;
@property (weak, nonatomic) IBOutlet UIButton *kitchen;
@property (weak, nonatomic) IBOutlet UIButton *business;
@property (weak, nonatomic) IBOutlet UIButton *management;

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  //  _topSpace.constant = _bottomSpace.constant = self.view.frame.size.height/6;

    ///Disable orientation changes
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}
//-(void)viewDidLayoutSubviews{
//_topSpace.constant = _bottomSpace.constant = self.view.bounds.size.height/6;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    _topSpace.constant = _bottomSpace.constant = self.view.frame.size.height/6;
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
    UIImage *tavantLogo = [UIImage imageNamed:@"tavant.png"];
    
     UIImageView *head_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tavantLogo.size.width, tavantLogo.size.height)];
    head_imgView.image = tavantLogo;
    self.navigationItem.titleView = head_imgView;
    
//    UITapGestureRecognizer *tap_sport = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sportSelected:)];
//    UITapGestureRecognizer *tap_fashion = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fashionSelected:)];
//    UITapGestureRecognizer *tap_travel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(travelSelected:)];
//    UITapGestureRecognizer *tap_fitness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fitnessSelected:)];
//    UITapGestureRecognizer *tap_finance = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(financeSelected:)];
//    UITapGestureRecognizer *tap_luxury = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(luxurySelected:)];
//    [_sport addGestureRecognizer:tap_sport];
//    [_fashion addGestureRecognizer:tap_fashion];
//     [_travel addGestureRecognizer:tap_travel];
//     [_fitness addGestureRecognizer:tap_fitness];
//     [_finance addGestureRecognizer:tap_finance];
//     [_luxury addGestureRecognizer:tap_luxury];
//    
    // Do any additional setup after loading the view from its nib.
//    CGFloat topHeight = [[UIScreen mainScreen] bounds].size.height;
//    if(topHeight < 600)    _topSpaceL.constant =  _topSpaceR.constant = 40;

  
                                           
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//
//
//-(void)sportSelected:(UITapGestureRecognizer *)tap{
//    //printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"sport";
//    [self.navigationController pushViewController:someController animated:YES];
//    }
//
//-(void)fashionSelected:(UITapGestureRecognizer *)tap{
//   // printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"fashion";
//    [self.navigationController pushViewController:someController animated:YES];
//  
//
//}
//-(void)travelSelected:(UITapGestureRecognizer *)tap{
//   // printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    //[self.homeDelegate clickedView:@"travel"];
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"travel";
//    [self.navigationController pushViewController:someController animated:YES];
//    
//
//}
//-(void)fitnessSelected:(UITapGestureRecognizer *)tap{
//   // printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"fitness";
//    [self.navigationController pushViewController:someController animated:YES];
//  
//}
//-(void)financeSelected:(UITapGestureRecognizer *)tap{
//   // printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"finance";
//    [self.navigationController pushViewController:someController animated:YES];
// 
//}
//-(void)luxurySelected:(UITapGestureRecognizer *)tap{
//  //  printf("%d\n",[tap.view tag]);
//    printf("clicked!\n");
//    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
//    someController.viewName = @"luxury";
//    [self.navigationController pushViewController:someController animated:YES];
//   }
- (IBAction)fitnessSelected:(id)sender {
        //printf("%d\n",[tap.view tag]);
        printf("clicked!\n");
    
        SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
        someController.viewName = @"Fitness";
    someController.userID = @"f1";
    
        [self.navigationController pushViewController:someController animated:YES];
    
}
- (IBAction)fashionSelected:(id)sender {
    
       // printf("%d\n",[tap.view tag]);
        printf("clicked!\n");
        SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
        someController.viewName = @"Fashion";
    someController.userID = @"f2";
  
        [self.navigationController pushViewController:someController animated:YES];
      

    
}
- (IBAction)travelSelected:(id)sender {
       // printf("%d\n",[tap.view tag]);
        printf("clicked!\n");
        //[self.homeDelegate clickedView:@"travel"];
        SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
        someController.viewName = @"Travel";
    someController.userID = @"m1";
   
    
        [self.navigationController pushViewController:someController animated:YES];
        

}
- (IBAction)kitchenSelected:(id)sender {
      //  printf("%d\n",[tap.view tag]);
        printf("clicked!\n");
        SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
        someController.viewName = @"Pets";
    someController.userID = @"f3";
 
        [self.navigationController pushViewController:someController animated:YES];
}
- (IBAction)businessSelected:(id)sender {
       // printf("%d\n",[tap.view tag]);
        printf("clicked!\n");
        SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
        someController.viewName = @"Music";
    someController.userID = @"m2";
  
        [self.navigationController pushViewController:someController animated:YES];
     

}
- (IBAction)managementSelected:(id)sender {
    // printf("%d\n",[tap.view tag]);
    printf("clicked!\n");
    SomeController *someController=[[SomeController alloc]initWithNibName:@"SomeController" bundle:nil];
    someController.viewName = @"Finance";
    someController.userID = @"m3";
   
    [self.navigationController pushViewController:someController animated:YES];
    

}

@end
