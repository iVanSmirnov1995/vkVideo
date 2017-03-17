//
//  ISTableViewVideoCell.m
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISTableViewVideoCell.h"

@implementation ISTableViewVideoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect r=CGRectMake(10, 0, 60, 60);
        self.videoImage=[[UIImageView alloc]initWithFrame:r];
        [self.contentView addSubview:self.videoImage];
        
        CGRect lableR=CGRectMake(CGRectGetMaxX(self.videoImage.frame)+10, 0,
                                 CGRectGetMaxX(self.contentView.frame)-160, 60);
        self.videoLable=[[UILabel alloc]initWithFrame:lableR];
        [self.contentView addSubview:self.videoLable];
        
        CGRect lableTimeR=CGRectMake(CGRectGetMaxX(self.videoLable.frame)+10, 0,
                                 CGRectGetMaxX(self.contentView.frame)-10, 60);
        self.timeVLable=[[UILabel alloc]initWithFrame:lableTimeR];
        [self.contentView addSubview:self.timeVLable];
        
        
    }
    
    return self;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}


@end
