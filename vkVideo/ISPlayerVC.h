//
//  ISPlayerVC.h
//  vkVideo
//
//  Created by Smirnov Ivan on 19.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;
@import AVKit;

@class ISVkVideoModel;
@interface ISPlayerVC : UIViewController

@property(strong,nonatomic)ISVkVideoModel* videoModel;

@end
