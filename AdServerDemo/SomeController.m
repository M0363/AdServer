//
//  SomeController.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 22/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "SomeController.h"
#import "otherCell.h"
#import "GlobalData.h"
#import "AppConfig.h"
#import "MBProgressHUD.h"
#import "UIKit+AFNetworking.h"
#import "HomeViewController.h"
#import "WebViewController.h"
#import "NewsDataStatic.h"
#import "AppDelegate.h"
@interface SomeController ()<NewsProtocol,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *otherTable;

@property (weak, nonatomic) IBOutlet UIImageView *footerBannerView;

@end

@implementation SomeController{
    MBProgressHUD *HUD;
    CGFloat itemWidth;
    CGFloat itemHeight;
    NSURL *url;
//     NSMutableArray *imageUrlStringArray ;
//    NSMutableArray *newsTitleArray ;
//    NSMutableArray *linkStringArray ;
//   NSMutableArray *descriptionArray ;
    NSArray *itemArray;
    NSMutableArray *dataArray;
    NSMutableArray *newsImageArray;
   NSInteger constant;   
   NSString *viewTitle ;
   NSMutableArray *adArray;
    NSMutableArray *adBannerarray;
    UIWebView *webView;
    UIView *backView;
    UIButton *backButton ;
    UIButton *forwardButton;
    NSTimer *t ;
    NSString * clickThroughUrlForSection;
    NSDictionary *AdServerData ;
    NSString *myUrl;
   // AdServerHTTPClient *client;
    UIImageView *imageView ;
    NSArray *static_ad;
}
static int count = 0;
static AdServerHTTPClient *client;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:self.viewName];
    _otherTable.backgroundColor = [UIColor lightGrayColor];
       webView.delegate = self;
    
    [AppConfig sharedInstance].NewsDelegate = self;
    [ self clickedView:self.viewName];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Downloading...";
  
   
//    imageUrlStringArray =  [[NSMutableArray alloc] init];
//    newsTitleArray =  [[NSMutableArray alloc] init];
//    linkStringArray = [[NSMutableArray alloc] init];
//    descriptionArray = [[NSMutableArray alloc] init];
    newsImageArray = [[NSMutableArray alloc] init];
    adBannerarray = [[NSMutableArray alloc] init];
    constant = 1;
    
    client = [[AdServerHTTPClient alloc]init];
    client.delegate = self;
     imageView = [[UIImageView alloc] init];
    //[GlobalData fetchServerByUserId:_userID];
 
   // adArray = [[GlobalData getBannerAds] mutableCopy];
   // [adArray addObject:[[GlobalData getTextAds]mutableCopy]];
    
//    static_ad = [[[AppConfig sharedInstance] lookupConfigByKey:@"userID"] valueForKey:_userID];
    

    
    [self.otherTable registerNib:[UINib nibWithNibName:@"otherCell"  bundle:nil] forCellReuseIdentifier:@"OTH_CELL"];
      [HUD show:YES];
    
    
    
    //NSDictionary *theAd = [GlobalData getAdsByUserId:@"m2"];
    //for (NSMutableArray *ad in adArray) {
    
    

    //}
    
//    
//    _footerBannerView.animationImages= adBannerarray;
//    [_footerBannerView setAnimationRepeatCount:102];
//    _footerBannerView.animationDuration=3;
//    
//    
//    [_footerBannerView startAnimating];
    }
-(void)loadAdInFooter:(NSTimer *)timer{
    printf("timer\n");
    [client getAdFromServer:@"footer" forCategory:_userID];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    #pragma mark - Retriving data fom the database
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"category == %@", viewTitle];
    [request setPredicate:p];
    NSMutableArray * result =  [[context executeFetchRequest:request error:NULL] mutableCopy];
    if (result) {
        dataArray = result;
    }
    else
        printf("couldn't fetch request");
     //[context executeRequest:delete withContext:context error:&deleteError];

    
    _footerBannerView.image = [UIImage imageNamed:[static_ad[0] valueForKey:@"imageSrc"]];
    t = [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(loadAdInFooter:)
                                   userInfo:nil
                                    repeats:YES];
    NSRunLoop *runner = [NSRunLoop currentRunLoop];
    [runner addTimer:t forMode: NSDefaultRunLoopMode];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillLayoutSubviews{
    itemWidth = self.view.bounds.size.width;
    itemHeight = self.view.bounds.size.height;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//[t dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CGFloat)getSizeOfText:theText{
    
    CGSize constraint = CGSizeMake(itemWidth, MAXFLOAT);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14.0] forKey:NSFontAttributeName];
    CGRect frameOfText = [theText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    return frameOfText.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat width = self.view.frame.size.width;
    UIView *adView = [[UIView alloc]initWithFrame:CGRectMake(0,0,width,itemWidth/6)];
    adView.backgroundColor = [UIColor blackColor];
    adView.tag = section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickThroughUrl:)];
    [adView addGestureRecognizer:tap];
   [client getAdFromServer:@"section" forCategory:_userID];
    imageView.frame = CGRectMake(8,8,width-16,itemWidth/6 - 16);
    [adView addSubview:imageView];
    
    return adView;
    

          // NSDictionary *theAd = [GlobalData getAdsByUserId:@"m2"];
        //for (NSMutableArray *ad in adArray) {
   // NSString *imageSrcWeb = [GlobalData getAdImageUrlByKey:@"imageSrcWeb" forUserId:_userID];
    
   
    
    //client = [AdServerHTTPClient sharedAdServerHTTPClient];
//      imageView.image = [UIImage imageNamed:@"AdImage1.gif"];
        //  NSString *imageSrcWeb = [AdServerData objectForKey:@"imageSrcWeb"];
// NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
//        imageView = [[UIImageView alloc] init];
//
//        //  UIImage *image = [UIImage imageNamed:imageSrc];
//        
//        __weak UIImageView *weakimgView = imageView;
//   
//        [imageView setImageWithURLRequest:request
//                                 placeholderImage:[UIImage imageNamed:@"placeholder"]
//                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                              
//                                              weakimgView.image = image;
//                                                //clickThroughUrlForSection = [GlobalData getAdClickedThroughUrl:@"clickThroughUrl"];
//                                              // [adBannerarray addObject:image];
//                                             // [adView addSubview:weakimgView];
//                                          } failure:nil];
//
//
  
    
  
    
    //showing animation for first session
//        if (section == 0) {
//            imageView.animationImages=[NSArray arrayWithObjects:
//                                       
//                                      
//                                       [UIImage imageNamed :@"AdImage.jpg"],
//                                       [UIImage imageNamed :@"AdImage1.gif"],
//                                       
//                                       nil];
//            [imageView setAnimationRepeatCount:12];
//            imageView.animationDuration=3;
//            
//            
//            [imageView startAnimating];
//
//        }
    
       }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return itemWidth/6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return dataArray.count/constant;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return constant;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellIdentifier = @"OTH_CELL";
    otherCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSInteger index = constant*indexPath.section + indexPath.row;
    printf("row =%ld\n",(long)index);
    
    cell.news_head.text = [dataArray[index] valueForKey:@"heading"];
           cell.news_article.text = [dataArray[index] valueForKey:@"article"];
    
        cell.news_article.textColor = [UIColor darkGrayColor];
        cell.news_article.font = [UIFont systemFontOfSize:14];
    
        if (cell.news_head.text.length > 30) {
            cell.news_head.font = [UIFont systemFontOfSize:16];
        }

    

    NSURL * imgUrl = [NSURL URLWithString:[dataArray[index] valueForKey:@"news_image"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
    [cell.news_image setImageWithURLRequest:request
                placeholderImage:[UIImage imageNamed:@"placeholder"]
                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                           cell.news_image.image = image;
                             printf("success download image\n");
                         } failure:failDownload];
    

    
  
    
//
//
//    if ([newsTitleArray[index] length] > 30) {
//        cell.news_head.font = [UIFont systemFontOfSize:16];
//    }
//    cell.news_head.text = newsTitleArray[index];
//    cell.news_article.text = descriptionArray[index];
//    cell.news_article.textColor = [UIColor darkGrayColor];
//    cell.news_article.font = [UIFont systemFontOfSize:14];
//    
//    
//    
//    if (imageUrlStringArray.count > 0) {
//    __weak otherCell *weakCell = cell;
//    NSURL * imgUrl = [NSURL URLWithString:imageUrlStringArray[index]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
//    [cell.news_image setImageWithURLRequest:request
//                           placeholderImage:[UIImage imageNamed:@"placeholder"]
//                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                        
//                                        weakCell.news_image.image = image;
//                                        [weakCell setNeedsLayout];
//                                        
//                                    } failure:nil];
//    }
//    else{
//        cell.news_image.image = [UIImage imageNamed:newsImageArray[index]];
//    }
        return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSInteger index = constant*indexPath.section + indexPath.row;
//    CGFloat articleSize = [self getSizeOfText:descriptionArray[index]];
//    CGFloat imageHeight = itemWidth*103/152;
//    return 100+articleSize+imageHeight;
//    
    
    static UITableViewCell* cell;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        cell = [_otherTable dequeueReusableCellWithIdentifier: @"OTH_CELL"];
    });
          //cell = [_otherTable dequeueReusableCellWithIdentifier: @"OTH_CELL"];

    // size the cell for the current orientation.  assume's we're full screen width:
    cell.frame = CGRectMake(0, 0, tableView.bounds.size.width, cell.frame.size.height );
    
    // perform a cell layout - this runs autolayout and also updates any preferredMaxLayoutWidths via layoutSubviews in our subclassed UILabels
    [cell layoutIfNeeded];
    
    // finally calculate the required height:
    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    
    return s.height + 1;
}


#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    NSURL *detailedUrl = [NSURL URLWithString:linkStringArray[constant*indexPath.section + indexPath.row]];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:detailedUrl];
//    
//    WebViewController *webViewController=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
//    webViewController.theTitle = viewTitle;
//     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    webViewController.requestObject = requestObj;
//    [self presentViewController:webViewController
//                       animated:YES
//                     completion:nil];
//        
//    
//   
//
//   }

-(void)clickThroughUrl:(UITapGestureRecognizer *)tap{
    printf("%ld\n",[tap.view tag]);
    printf("clicked!\n");
    NSString *clickThroughUrl = clickThroughUrlForSection;
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:clickThroughUrl]];
}

#pragma mark - NewsDataDelegate

-(void)getNewsData:(GDataXMLElement *)newsData{
    printf("in News\n");
    [HUD hide:YES];
   /*deleting data of the database */
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"category == %@", viewTitle];
    [request setPredicate:p];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
  

    NSError *deleteError = [[NSError alloc]init];
  
    [context executeRequest:delete error:&deleteError];
       itemArray = [newsData elementsForName:@"item"];
    
//    Saving data to the database
  
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];
   
    
    for ( GDataXMLElement *item in itemArray) {
         NSManagedObject *obj = [[NSManagedObject alloc]initWithEntity:description insertIntoManagedObjectContext:context];
    GDataXMLElement *media = [[item elementsForName:@"media:thumbnail"] lastObject];
    [obj setValue:[[[item elementsForName:@"title"] lastObject] stringValue] forKey:@"heading"];
     [obj setValue:[[media attributeForName:@"url"] stringValue] forKey:@"news_image"];
    [obj setValue:[[[item elementsForName:@"description"] lastObject] stringValue] forKey:@"article"];
        [obj setValue:viewTitle forKey:@"category"];
        NSError *err = nil;
    if (![context save:&err]) {
        printf("could not save.")   ;
    }
    }
    
//Retriving data from the database

    NSMutableArray * result =  [[context executeFetchRequest:request error:NULL] mutableCopy];
 
    if (result.count > 0) {
        dataArray = result;
    }
    else
        printf("couldn't fetch request");
     [self.otherTable reloadData];
    
        /*
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:context];
    NSManagedObject *obj = [[NSManagedObject alloc]initWithEntity:description insertIntoManagedObjectContext:context];
    
    for (GDataXMLElement *item  in itemArray) {
        GDataXMLElement *media = [[item elementsForName:@"media:thumbnail"] lastObject];
    [obj setValue:[[[item elementsForName:@"title"] lastObject] stringValue] forKey:@"heading"];
    [obj setValue:[[media attributeForName:@"url"] stringValue] forKey:@"news_image"];
    [obj setValue:[[[item elementsForName:@"description"] lastObject] stringValue] forKey:@"article"];
    }
  


    
    itemArray = [newsData elementsForName:@"item"];
    for (GDataXMLElement *item  in itemArray) {
        GDataXMLElement *media = [[item elementsForName:@"media:thumbnail"] lastObject];
        [imageUrlStringArray addObject:[[media attributeForName:@"url"] stringValue]];
        [newsTitleArray addObject: [[[item elementsForName:@"title"] lastObject] stringValue]];
        [linkStringArray addObject:[[[item elementsForName:@"link"] lastObject] stringValue]];
        [descriptionArray addObject:[[[item elementsForName:@"description"] lastObject] stringValue]];
    }
     */
   
}
-(void)ErrorNewsData{
 [HUD hide:YES];
//    NSDictionary *newsArray = [[NewsDataStatic sharedInstance] lookupConfigByKey:@"NEWS"];
//    for (NSDictionary *news  in newsArray) {
//        
//    
//   // [imageUrlStringArray addObject:@"http://stackoverflow.com/questions/25824908/xcode-process-launch-failed-security"];
//        [newsImageArray addObject:[news valueForKey:@"NEWS_IMAGE"]];
//    [newsTitleArray addObject: [news valueForKey:@"NEWS_TITLE"]];
//    [linkStringArray addObject:@"https://en.wikipedia.org/wiki/Rahul_Dravid"];
//    [descriptionArray addObject:[news valueForKey:@"NEWS_ARTICLE"]];
//    }
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Entity"];
    NSPredicate *p=[NSPredicate predicateWithFormat:@"category == %@", viewTitle];
    [request setPredicate:p];
    NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *deleteError = nil;
    
    [context executeRequest:delete error:&deleteError];
    
    NSMutableArray * result =  [[context executeFetchRequest:request error:NULL] mutableCopy];
    
    if (result) {
        dataArray = result;
    }
    else
        printf("couldn't fetch request");
        [self.otherTable reloadData];
}

-(void)backAction{
    if (webView.canGoBack) {
        [webView goBack];
    }
    
        
    
    printf("backword\n");
}
-(void)forwardAction{
    if (webView.canGoForward) {
        [webView goForward];
    }
}
-(void)clickedView:(NSString *)str{
    printf("observed pankaj\n");
    viewTitle = str;
    if ([viewTitle isEqualToString:@"Fitness"]) {
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/sportsheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];
       
    }
    else if ([viewTitle isEqualToString:@"Fashion"]){
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/gmaheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];
        
    }
    else if ([viewTitle isEqualToString:@"Travel"]){
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/travelheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];
          }
    else if ([viewTitle isEqualToString:@"Pets"]){
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/politicsheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];

    }
    else if ([viewTitle isEqualToString:@"Music"]){
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/healthheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];
     
    }
    else if ([viewTitle isEqualToString:@"Finance"]){
        url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/moneyheadlines"];
        [[AppConfig sharedInstance] downloadFeed:url];
     
    }
    
}

- (IBAction)footerAdTapped:(id)sender {
    
    printf("footerAdTapped\n");
}


#pragma mark - AdServerHTTPClientDelegate

-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didUpdateWithAdServer_footer:(id)AdServer{
    AdServerData = AdServer;
   // NSLog(@"%@",AdServerData);
    myUrl = [AdServerData objectForKey:@"imageSrcWeb"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
    
    
        __weak UIImageView *weakimgView = _footerBannerView;
        [_footerBannerView setImageWithURLRequest:request
                                 placeholderImage:[UIImage imageNamed:@"placeholder"]
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    
                                              weakimgView.image = image;
                                              // [adBannerarray addObject:image];
    
                                          } failure:nil];
        

}
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didFailWithError_footer:(NSError *)error{
    
    _footerBannerView.image = [UIImage imageNamed:[static_ad[count%3] valueForKey:@"imageSrc"]];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving AdServer"
//                                                        message:[NSString stringWithFormat:@"%@",error]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
}
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didUpdateWithAdServer_section:(id)AdServer{
    
    AdServerData = AdServer;
   // NSLog(@"%@",AdServerData);
    myUrl = [AdServerData objectForKey:@"imageSrcWeb"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
    
    imageView = [[UIImageView alloc] init];

    __weak UIImageView *weakimgView = imageView;
    
    [imageView setImageWithURLRequest:request
                     placeholderImage:[UIImage imageNamed:@"placeholder"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  
                                  weakimgView.image = image;
                                  //clickThroughUrlForSection = [GlobalData getAdClickedThroughUrl:@"clickThroughUrl"];
                                  // [adBannerarray addObject:image];
                                  // [adView addSubview:weakimgView];
                              } failure:failDownload];
//    
//    NSRange range = NSMakeRange(0, 1);
//    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
//    [self.otherTable reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
//    
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
//    
//    [self.otherTable beginUpdates];
//    [self.otherTable deleteSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//    [self.otherTable insertSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//    [self.otherTable endUpdates];

}
void (^failDownload)() = ^()
{
    printf("couldn't download image\n");
};
-(void)AdServerHTTPClient:(AdServerHTTPClient *)client didFailWithError_section:(NSError *)error{
    static_ad = [[[AppConfig sharedInstance] lookupConfigByKey:@"userID"] valueForKey:_userID];
    
        imageView.image = [UIImage imageNamed:[static_ad[(count++)%3] valueForKey:@"imageSrc"]];
    
    
        
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving AdServer"
//                                                        message:[NSString stringWithFormat:@"%@",error]
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
}

@end
