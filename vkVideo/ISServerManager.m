//
//  ISServerManager.m
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISServerManager.h"
#import "ISAccessToken.h"
#import "ISVkVideoModel.h"

@implementation ISServerManager


+(ISServerManager*) sharedManager{
    
    static ISServerManager* manager=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager=[[ISServerManager alloc]init];
        
        
    });
    
    return manager;
}


-(void)getVideoFromString:(NSString*)string offset:(NSInteger)offset OnSuccess:(void(^)(NSArray* video)) success
                onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{
    
  //  NSURLSession *session = [NSURLSession sharedSession];
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     string,        @"q",
     @(2),          @"sort",
     @(40),        @"count",
     @(offset),     @"offset",
     self.accessToken.token,@"access_token",
     @"5.62",@"v",nil];
    
    NSString* urlStr=@"https://api.vk.com/method/video.search?";
    
    NSString* paramSt=[NSString stringWithFormat:@"count=%@&sort=%@&q=%@&offset=%@&access_token=%@&v=%@"
            ,params[@"count"],params[@"sort"],params[@"q"],params[@"offset"],params[@"access_token"],params[@"v"]];
    
    NSString* finSt=[NSString stringWithFormat:@"%@%@",urlStr,paramSt];
    
    NSURL *url = [NSURL URLWithString:[finSt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sharedSession];

    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSDictionary* d=json[@"response"];
                NSArray* ar=d[@"items"];
                NSMutableArray* videoModArr=[NSMutableArray array];
                                                
            for (NSDictionary* d in ar) {
                
               // NSLog(@"%@",d);
                ISVkVideoModel* vModel=[[ISVkVideoModel alloc]init];
                vModel.videoName=d[@"title"];
                vModel.videoURL=d[@"player"];
                vModel.videoTime=[self timeStringFromSeconds:[d[@"duration"]doubleValue]];
                vModel.videoPreviewImage=d[@"photo_130"];
                [videoModArr addObject:vModel];
                
                }
            if(success) {
              success(videoModArr);
                     }
            if(success) {
              failure(error,error.code);
                     }
                                                
                                                
                                                
                    }];
       [dataTask resume];  
    
    
}



- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.baseURL=url;
        
        
        
    }
    return self;
}


#pragma mark-helpMetods

-(NSString *)timeStringFromSeconds:(double)seconds
{
    NSDateComponentsFormatter *dcFormatter = [[NSDateComponentsFormatter alloc] init];
    dcFormatter.zeroFormattingBehavior = NSDateComponentsFormatterZeroFormattingBehaviorPad;
    if (seconds>3600) {
        dcFormatter.allowedUnits = NSCalendarUnitHour | NSCalendarUnitMinute|NSCalendarUnitSecond;
    }else
        dcFormatter.allowedUnits = NSCalendarUnitMinute|NSCalendarUnitSecond;
        
    dcFormatter.unitsStyle = NSDateComponentsFormatterUnitsStylePositional;
    return [dcFormatter stringFromTimeInterval:seconds];
}



@end
