//
//  EVAFriendsViewController.h
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EVAFriendsViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) NSNumber *userID;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@end
