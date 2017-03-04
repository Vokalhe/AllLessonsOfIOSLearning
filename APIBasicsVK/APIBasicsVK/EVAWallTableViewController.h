//
//  EVAWallTableViewController.h
//  APIBasicsVK
//
//  Created by Admin on 04.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVAWallTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) NSNumber* userID;
@end
