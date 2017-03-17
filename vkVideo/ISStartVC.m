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

@interface ISStartVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ISStartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ISLoginController* vc=[[ISLoginController alloc]init];
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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 40;
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
    
    
    if (indexPath.row>0) {
        
        ISTableViewVideoCell* vCell=(ISTableViewVideoCell*)cell;
        vCell.videoImage.image=[UIImage imageNamed:@"test.jpg"];
        vCell.videoLable.text=@"котэ аспмриотльдлорпавпролодрпа";
        vCell.timeVLable.text=@"01:45";
        
        UIFont* timeFont=[UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:14];
        vCell.timeVLable.font=timeFont;
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


@end
