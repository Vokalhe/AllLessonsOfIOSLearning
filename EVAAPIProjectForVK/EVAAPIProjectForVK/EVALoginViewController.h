//
//  EVALoginViewController.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 11.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVAAccessToken;

typedef void(^LoginCompletionBlock)(EVAAccessToken *token);

@interface EVALoginViewController : UIViewController
- (id)initWithCompletionBlock:(LoginCompletionBlock) completionBlock;

@end
