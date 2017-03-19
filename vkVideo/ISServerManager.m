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
     @"",           @"User-Agent",
     self.accessToken.token,@"access_token",
     @"5.62",@"v",nil];
    
    NSString* urlStr=@"https://api.vk.com/method/video.search?";
    
    NSString* paramSt=[NSString stringWithFormat:@"adult=0&count=%@&sort=%@&q=%@&offset=%@&User-Agent=%@&access_token=%@&v=%@"
            ,params[@"count"],params[@"sort"],params[@"q"],params[@"offset"],params[@"User-Agent"],params[@"access_token"],params[@"v"]];
    
    NSString* finSt=[NSString stringWithFormat:@"%@%@",urlStr,paramSt];
    
    NSURL *url = [NSURL URLWithString:[finSt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sharedSession];

    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSDictionary * json  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@",json);
                NSDictionary* d=json[@"response"];
                NSArray* ar=d[@"items"];
                NSMutableArray* videoModArr=[NSMutableArray array];
                                                
            for (NSDictionary* d in ar) {
                
                ISVkVideoModel* vModel=[[ISVkVideoModel alloc]init];
                vModel.videoName=d[@"title"];
                vModel.videoURL=d[@"player"];
                vModel.videoTime=[self timeStringFromSeconds:[d[@"duration"]doubleValue]];
                vModel.videoPreviewImage=d[@"photo_130"];
                vModel.height=[d[@"height"] integerValue];
                vModel.width=[d[@"width"] integerValue];
                if (!(vModel.height==0)) {
                    vModel.isVK=YES;
                }else vModel.isVK=NO;
                
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

-(void)getVideo:(NSString*)st h:(NSInteger)h OnSuccess:(void(^)(NSURL* url,bool isAccess)) success
      onFailure:(void(^)(NSError* error,NSInteger statusCode))failure{
    
    
    NSURL *baseUrl = [NSURL URLWithString:[st stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Asynchronously API is hit here
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:baseUrl
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                            
                                                
        NSDataDetector *detect = [[NSDataDetector alloc]
                                  initWithTypes:NSTextCheckingTypeLink error:nil];
        NSArray *matches = [detect matchesInString:s options:0 range:NSMakeRange(0, [s length])];

               NSInteger i=0;
            for (NSTextCheckingResult *match in matches) {
                
                if ([match resultType] == NSTextCheckingTypeLink) {
                                                    
                        NSString* sSt=[[match URL] absoluteString];
                    NSString* chSt=[NSString stringWithFormat:@"%ld.mp4?",(long)h];
                    NSRange ran=[sSt rangeOfString:chSt];
                    
                    if (!(ran.location==NSNotFound)) {
                        i++;
                         [match resultType];
                         NSURL *url = [match URL];
                        [self setURL:url];
                        }
                        
                                }
                            }
                                                
                        if (i>0) {
                            
                        NSURL *url = [self URL];
                        if (success) {
                          success(url,YES);
                            }
                            
                            }else{
                        if (success) {
                        NSURL *url = [self URL];
                        success(url,NO);
                        }
                                                    
                    }
                                                
                                                
                                                    //https// 720.mp4
                                                
                                                
                                                
                                                
                              }];
    [dataTask resume];
    
    
    
}

@end
