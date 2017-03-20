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
        
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        CGRect r=CGRectMake(10, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
        self.videoImage=[[UIImageView alloc]initWithFrame:r];
        [self.contentView addSubview:self.videoImage];
        
        CGRect lableTimeR=CGRectMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-40, 0,
                                     30,
                                     CGRectGetHeight(self.frame));
        
        CGRect lableR=CGRectMake(CGRectGetMaxX(self.videoImage.frame)+10, 0,
                        CGRectGetMinX(lableTimeR)-(CGRectGetMaxX(self.videoImage.frame)+20),CGRectGetHeight(self.frame));
        
        
        self.videoLable=[[UILabel alloc]initWithFrame:lableR];
        [self.contentView addSubview:self.videoLable];
        
        UIFont* nameVidFont=[UIFont systemFontOfSize:12];
        self.videoLable.font=nameVidFont;
        
        
        
        self.timeVLable=[[UILabel alloc]initWithFrame:lableTimeR];
        [self.contentView addSubview:self.timeVLable];
        
        UIFont* timeFont=[UIFont fontWithName:@"HelveticaNeue-UltraLightItalic" size:12];
        self.timeVLable.font=timeFont;
      //  self.timeVLable.textAlignment=NSTextAlignmentRight;
        
        
        
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
