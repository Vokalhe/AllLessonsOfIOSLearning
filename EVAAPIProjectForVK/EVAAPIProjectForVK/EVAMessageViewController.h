//
//  EVAMessageViewController.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 02.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EVAUser;

@interface EVAMessageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textOfMessageTextField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) EVAUser *user;

- (IBAction)sendMessageButton:(id)sender;

@end
