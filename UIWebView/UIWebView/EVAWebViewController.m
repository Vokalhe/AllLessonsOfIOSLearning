//
//  EVAWebViewController.m
//  UIWebView
//
//  Created by Admin on 15.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import "EVAWebViewController.h"

@interface EVAWebViewController () <UIWebViewDelegate>
//@property (strong, nonatomic) NSArray *arrayOfPDF;
//@property (strong, nonatomic) NSArray *arrayOfURL;
@end

@implementation EVAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.arrayOfPDF = [[NSArray alloc] initWithObjects:@"iOSVidmetest.pdf", @"Lecture 6.pdf", nil];
    //self.arrayOfURL = [[NSArray alloc] initWithObjects:@"http://stackoverflow.com/questions/409259/having-a-uitextfield-in-a-uitableviewcell", @"http://www.imaladec.com/story/content-lessons", nil];
    
   // NSString *path = [[NSBundle mainBundle] pathForResource:self.address ofType:nil];//self.address;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.address];
    [self.ibWebView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self showButtons];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self showButtons];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) showButtons{
    self.ibBackButton.enabled = [self.ibWebView canGoBack];
    self.ibForwardButton.enabled = [self.ibWebView canGoForward];

}
- (IBAction)actionBack:(id)sender {
    if ([self.ibWebView canGoBack]) {
        [self.ibWebView stopLoading];
        [self.ibWebView goBack];
    }
}

- (IBAction)actionForward:(id)sender {
    if ([self.ibWebView canGoForward]) {
        [self.ibWebView stopLoading];
        [self.ibWebView goForward];
    }
}

- (IBAction)actionRefresh:(id)sender {
    [self.ibWebView stopLoading];
    [self.ibWebView reload];
}
@end
