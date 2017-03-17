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
        
        CGRect r=CGRectMake(10, 0, 40, 40);
        self.videoImage=[[UIImageView alloc]initWithFrame:r];
        [self.contentView addSubview:self.videoImage];
        
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
