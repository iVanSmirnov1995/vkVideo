//
//  ISPlayerVC.m
//  vkVideo
//
//  Created by Smirnov Ivan on 19.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISPlayerVC.h"
#import "ISVkVideoModel.h"
#import "ISServerManager.h"

@interface ISPlayerVC ()

@property(assign,nonatomic)CGFloat indent;
@property(strong,nonatomic)AVPlayer* player;
@property(assign,nonatomic)BOOL isPlay;
@property(strong,nonatomic)UIButton* play;

@end

@implementation ISPlayerVC

-(void)loadView{
    
    [super loadView];
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"%@",self.view.backgroundColor);
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat h= self.navigationController.navigationBar.frame.size.height;
    CGRect frSB=[[UIApplication sharedApplication] statusBarFrame];
    CGFloat h2=CGRectGetHeight(frSB);
    self.indent=h+h2;
    
    
    if (self.videoModel.isVK) {
        
        [[ISServerManager sharedManager] getVideo:self.videoModel.videoURL h:self.videoModel.height OnSuccess:^(NSURL* url,bool isAccess) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (isAccess) {
                    [self addPlayer:url];
                    NSLog(@"%@",url);
                }else{
                    
                    [self addWebView];
                    
                }
                
            });
            
        } onFailure:^(NSError *error, NSInteger statusCode) {
            
            
        }];
        
    }else{
        
        [self addWebView];
        
        
    }
    
    
    
    
}



-(void)addPlayer:(NSURL*)url{
    
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    self.player=player;
    
    
    CGRect viewFr=CGRectMake(0, self.indent,CGRectGetWidth(self.view.frame),
                             ((CGFloat)self.videoModel.height/(CGFloat)self.videoModel.width)*
                             CGRectGetWidth(self.view.frame));
    UIView* playerView=[[UIView alloc]initWithFrame:viewFr];
   // playerView.center=self.view.center;
    [self.view addSubview:playerView];
    CALayer *superlayer = playerView.layer;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    [playerLayer setFrame:playerView.bounds];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [superlayer addSublayer:playerLayer];
    
    
    
    [player seekToTime:kCMTimeZero];
    [player play];
    self.isPlay=YES;
    
    CGRect stopR=CGRectMake(CGRectGetMaxX(self.view.frame)-50-50,CGRectGetMaxY(viewFr)+50, 50, 50);
    UIButton* stop=[[UIButton alloc]initWithFrame:stopR];
    CGRect playR=CGRectMake(50, CGRectGetMaxY(viewFr)+50, 50, 50);
    UIButton* play=[[UIButton alloc]initWithFrame:playR];
    
    [stop addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    [play addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [stop setImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [play setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    self.play=play;
    
    [self.view addSubview:stop];
    [self.view addSubview:play];
    
    
}


-(void)addWebView{
    
    CGRect viewFr=CGRectMake(0,0,CGRectGetWidth(self.view.frame),
                                 (3.f/4.f)*CGRectGetWidth(self.view.frame));
    
     UIWebView* wv=[[UIWebView alloc]initWithFrame:viewFr];
        [self.view addSubview:wv];
        NSString* urlString =self.videoModel.videoURL;
        NSURL* url = [NSURL URLWithString:urlString];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [wv loadRequest:request];
    
        [wv loadRequest:request];
        wv.scrollView.scrollEnabled = NO;
    
    
}

#pragma mark-Action

-(void)stopAction:(UIButton*)b{
    
        
    [self.player pause];
    self.isPlay=NO;
    [self.player seekToTime:kCMTimeZero];
    [self.play setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    
}

-(void)playAction:(UIButton*)b{
    
    if (self.isPlay) {
        [self.player pause];
        self.isPlay=NO;
        [b setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        
        [self.player play];
         self.isPlay=YES;
        [b setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
    }
}



@end
