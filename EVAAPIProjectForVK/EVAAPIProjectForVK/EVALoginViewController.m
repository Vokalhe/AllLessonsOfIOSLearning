//
//  EVALoginViewController.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 11.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVALoginViewController.h"
#import "EVAAccessToken.h"

@interface EVALoginViewController () <UIWebViewDelegate>
@property (copy, nonatomic) LoginCompletionBlock completionBlock;
@property (weak, nonatomic) UIWebView *webView;
@end

@implementation EVALoginViewController 
- (id)initWithCompletionBlock:(LoginCompletionBlock) completionBlock
{
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect r = self.view.bounds;
    r.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:r];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:webView];
    self.webView = webView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:item];
    self.navigationItem.title = @"Login";
    
   /* NSString* urlString =
    @"https://oauth.vk.com/authorize?"
    "client_id=4199692&"
    "scope=139286&" // + 2 + 4 + 16 + 131072 + 8192
    "redirect_uri=https://oauth.vk.com/blank.html&"
    "display=mobile&"
    "v=5.11&"
    "response_type=token";
     */
    NSString *urlString = @"https://oauth.vk.com/authorize?"
    "client_id=5874204&"
    "display=mobile&"
    "redirect_uri=https://oauth.vk.com/blank.html&"
    "scope=143382&"//2+4+16+8192+131072+4096
    "response_type=token&"
    "v=5.62&"
    "state=good";
    
    NSURL* url = [NSURL URLWithString: urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    
    [webView loadRequest:request];

}

- (void)dealloc
{
    self.webView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
-(void) actionCancel:(UIBarButtonItem*) item{
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //if ([[request.URL host] isEqualToString:@"oauth.vk.com"]) {
        if ([[[request URL] description] rangeOfString:@"#access_token="].location != NSNotFound) {
            EVAAccessToken *token = [[EVAAccessToken alloc] init];
            NSString *query = [[request URL] description];
            NSArray *array = [query componentsSeparatedByString:@"#"];
            
            if ([array count] > 1) {
                query = [array lastObject];
            }
            
            NSArray *pairs = [query componentsSeparatedByString:@"&"];
            
            for(NSString *pair in pairs){
                NSArray *values = [pair componentsSeparatedByString:@"="];
                
                if ([values count] == 2) {
                    NSString *key = [values firstObject];
                    
                    if ([key isEqualToString:@"access_token"]) {
                        token.token = [values lastObject];
                    }else if ([key isEqualToString:@"expires_in"]){
                        NSTimeInterval interval = [[values lastObject] doubleValue];
                        token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    }else if ([key isEqualToString:@"user_id"]){
                        token.userID = [values lastObject];
                    }
                    
                }
            }
            
            self.webView.delegate = nil;
            if (self.completionBlock) {
                self.completionBlock(token);
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
            return NO;
        }
    
    //}
    
    return YES;
}

@end
