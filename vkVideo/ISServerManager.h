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
@property(strong,nonatomic)NSURL* URL;

+(ISServerManager*) sharedManager;


-(void)getVideoFromString:(NSString*)string offset:(NSInteger)offset OnSuccess:(void(^)(NSArray* video)) success
                 onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;


-(void)getVideo:(NSString*)st h:(NSInteger)h OnSuccess:(void(^)(NSURL* url,bool isAccess)) success
      onFailure:(void(^)(NSError* error,NSInteger statusCode))failure;







@end
