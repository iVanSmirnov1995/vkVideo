//
//  ISTableViewVideoCell.h
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISTableViewVideoCell : UITableViewCell

@property(strong,atomic)UIImageView* videoImage;
@property(strong,nonatomic)UILabel* videoLable;
@property(strong,nonatomic)UILabel* timeVLable;



@end
