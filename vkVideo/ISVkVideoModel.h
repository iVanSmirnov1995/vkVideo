//
//  ISVkVideoModel.h
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISVkVideoModel : NSObject

@property(strong,nonatomic)NSString* videoURL;
@property(strong,nonatomic)NSString* videoPreviewImage;
@property(strong,nonatomic)NSString* videoName;
@property(strong,nonatomic)NSString* videoTime;
@property(assign,nonatomic)NSInteger height;
@property(assign,nonatomic)NSInteger width;
@property(assign,nonatomic)bool isVK;

@end
