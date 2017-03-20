//
//  ISLoginController.m
//  vkVideo
//
//  Created by Smirnov Ivan on 17.03.17.
//  Copyright © 2017 Smirnov Ivan. All rights reserved.
//

#import "ISLoginController.h"
#import "ISAccessToken.h"

@interface ISLoginController ()<UIWebViewDelegate>

@property(strong,nonatomic)UIWebView* webView;

@end

@implementation ISLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    self.webView=[[UIWebView alloc]initWithFrame:r];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.webView];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                          action:@selector(actionCancel:)];
    
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    self.navigationItem.title = @"Login";
    
    NSString* urlString =
    @"https://oauth.vk.com/authorize?"
    "client_id=5929937&"
    "client_secret=8pN6fdrM5kOkp3BwWe5q&"
    "grant_type=client_credentials&"
    "scope=16&"
    "v=5.62&"
    "response_type=token&";
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    _webView.delegate = self;
    
    [_webView loadRequest:request];
    
    
}


- (void) actionCancel:(UIBarButtonItem*) item {
    
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
 
    
    if ([[[request URL] description] rangeOfString:@"#access_token="].location != NSNotFound){
        
        
      NSLog(@"%@",[[request URL] description]);
        
        ISAccessToken* token = [[ISAccessToken alloc] init];
        
        NSString* query = [[request URL] description];
        
        NSArray* array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray* pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString* pair in pairs) {
            
            NSArray* values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                
                NSString* key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    token.token = [values lastObject];
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    token.userID = [values lastObject];
                }
            }
        }
    
        if (token.token) {
            
            self.webView.delegate = nil;
            [self.delegate didLogin:self token:token];
            
        }
        
        
    }
    
    
    return YES;
}



@end
