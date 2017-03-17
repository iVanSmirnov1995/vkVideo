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

@interface ISStartVC ()<UITableViewDataSource,UITableViewDelegate,ISLoginDelegate>

@property(strong,nonatomic)NSArray* videoAr;
@property(strong,nonatomic)UITableView* tableViwe;

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
    
    return self.videoAr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier=@"";
    
    if (indexPath.row==0) {
        identifier=@"search";
        
        ISTableSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[ISTableSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ISVkVideoModel* video=self.videoAr[indexPath.row];
    
    if (indexPath.row>0) {
        
        
        ISTableViewVideoCell* vCell=(ISTableViewVideoCell*)cell;
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLRequest* request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:video.videoPreviewImage]];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            
            vCell.videoImage.image=[UIImage imageWithData:data];
            
            
        }];
        [task resume];
        
        vCell.videoLable.text=video.videoName;
        vCell.timeVLable.text=@"01:45";
        
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
    
    [[ISServerManager sharedManager]getVideoFromString:@"100500" OnSuccess:^(NSArray *video) {
        
        self.videoAr=video;
        [self.tableViwe reloadData];
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"error %@ statusCode=%ld",error.description,(long)statusCode);
    }];
    
    
}


@end
