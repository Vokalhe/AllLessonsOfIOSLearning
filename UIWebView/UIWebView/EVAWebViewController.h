//
//  EVAWebViewController.h
//  UIWebView
//
//  Created by Admin on 15.11.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVAWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ibBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ibForwardButton;
@property (weak, nonatomic) IBOutlet UIWebView *ibWebView;
@property (strong, nonatomic) NSURL *address;
- (IBAction)actionBack:(id)sender;
- (IBAction)actionForward:(id)sender;
- (IBAction)actionRefresh:(id)sender;

@end
