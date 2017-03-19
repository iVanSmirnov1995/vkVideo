//
//  ISTableSearchCell.m
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISTableSearchCell.h"

@implementation ISTableSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
        NSLog(@"%@",self);
        UISearchBar* bar=[[UISearchBar alloc]initWithFrame:self.frame];
        bar.searchBarStyle=UISearchBarStyleMinimal;
        self.bar=bar;
        [self.contentView addSubview:bar];
        
    }
    
    return self;
}


//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//    
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

    NSLog(@"fhgjkl");
}

@end
