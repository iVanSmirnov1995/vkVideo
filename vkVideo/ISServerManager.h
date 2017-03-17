//
//  ISServerManager.h
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ISVkVideoModel,ISAccessToken;
@interface ISServerManager : NSObject

@property(strong,nonatomic)ISAccessToken* accessToken;
@property(strong,nonatomic)NSURL* baseURL;
@property(strong,nonatomic)ISVkVideoModel* videoModel;
@property(assign,nonatomic)NSInteger userID;


+(ISServerManager*) sharedManager;


-(void)getVideoFromString:(NSString*)string OnSuccess:(void(^)(NSArray* video)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;


@end
