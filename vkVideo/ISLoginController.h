//
//  ISLoginController.h
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ISAccessToken;

@protocol ISLoginDelegate;

@interface ISLoginController : UIViewController

@property (weak, nonatomic) id <ISLoginDelegate> delegate;

@end

@protocol ISLoginDelegate

- (void) didLogin:(ISLoginController*)vc token:(ISAccessToken*)token;

@end
