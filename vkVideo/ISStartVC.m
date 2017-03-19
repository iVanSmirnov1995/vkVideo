//
//  ISStartVC.m
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISStartVC.h"
#import "ISLoginController.h"
#import "ISTableSearchCell.h"
#import "ISTableViewVideoCell.h"
#import "ISServerManager.h"
#import "ISVkVideoModel.h"
#import "ISPlayerVC.h"

@interface ISStartVC ()<UITableViewDataSource,UITableViewDelegate,ISLoginDelegate,UISearchBarDelegate>

@property(strong,nonatomic)NSMutableArray* videoAr;
@property(strong,nonatomic)UITableView* tableViwe;
@property(strong,nonatomic)NSString* searchText;

@end

@implementation ISStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ISLoginController* vc=[[ISLoginController alloc]init];
    vc.delegate=self;
    vc.modalPresentationStyle=UIModalPresentationPageSheet;
    vc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:vc animated:YES completion:^{
        
    } ];
    
    self.videoAr=[NSMutableArray array];
    UITableView* tableView=[[UITableView alloc]
                            initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    self.tableViwe=tableView;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1+self.videoAr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier=@"";
    
    if (indexPath.row==0) {
        identifier=@"search";
        
        ISTableSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        
        if (!cell) {
            cell = [[ISTableSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            NSLog(@"%@",cell);
            
            cell.bar.delegate=self;
        }
        
        
        
        return cell;
    }
    
    if (indexPath.row>0) {
        
        identifier=@"video";
        
        ISTableViewVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[ISTableViewVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
        }
        
        
        
        return cell;
    }

    
    
    
    
    
    
    
    return nil;
}


#pragma mark-UITableViewDelegate


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row>0) {
     
        ISVkVideoModel* video=self.videoAr[indexPath.row-1];
        ISPlayerVC* vc=[[ISPlayerVC alloc]init];
        vc.videoModel=video;
        [self.navigationController pushViewController:vc animated:NO];
        
        
        
        
    }
    
    
    return YES;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row>0) {
        
         ISVkVideoModel* video=self.videoAr[indexPath.row-1];
        
        ISTableViewVideoCell* vCell=(ISTableViewVideoCell*)cell;
        
        vCell.videoImage.image = [UIImage imageNamed:@"loading"];
        
        NSURL *url = [NSURL URLWithString:video.videoPreviewImage];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    ISTableViewVideoCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.videoImage.image = image;
                    });
                }
            }
        }];
        [task resume];
        vCell.videoLable.text=video.videoName;
        vCell.timeVLable.text=video.videoTime;
        
    }
    
    if((indexPath.row  == self.videoAr.count)&&!(self.videoAr.count==0)&&(self.videoAr.count>39)) {
        [self GETVideoFromServer];
    }
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row==0) {
         
       return 40;
         
     }
    
    if (indexPath.row>0) {
        
        return 60;
        
    }
    
    return 40;
}

#pragma mark-ISLoginDelegate

- (void) didLogin:(ISLoginController*)vc token:(ISAccessToken*)token{
    
    [[ISServerManager sharedManager] setAccessToken:token];
    [vc dismissViewControllerAnimated:YES
                             completion:nil];
    
    
}

#pragma mark-API

-(void)GETVideoFromServer{
    
    [[ISServerManager sharedManager]getVideoFromString:self.searchText
                                                offset:self.videoAr.count OnSuccess:^(NSArray *video) {
        
        [self.videoAr addObjectsFromArray:video];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableViwe reloadData];
            
        });
        
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"error %@ statusCode=%ld",error.description,(long)statusCode);
    }];
    
}

#pragma mark-UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.videoAr removeAllObjects];
    
    self.searchText=searchBar.text;
    [self GETVideoFromServer];
}


@end
