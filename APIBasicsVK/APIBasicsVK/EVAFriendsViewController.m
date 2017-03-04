//
//  EVAFriendsViewController.m
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAFriendsViewController.h"
#import "EVAServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "EVASubscriptionsTableViewController.h"
#import "EVAFollowersTableViewController.h"
#import "EVAWallTableViewController.h"

@interface EVAFriendsViewController ()
@property (strong, nonatomic) User* user;
@end

@implementation EVAFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getFriendFromServer];
    //self.navigationItem.title =
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        EVASubscriptionsTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EVASubscriptionsTableViewController"];
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4) {
        EVAFollowersTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAFollowersTableViewController"];
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        EVAWallTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAWallTableViewController"];
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
    
}

#pragma mark - API
-(void) getFriendFromServer{
    [[EVAServerManager sharedManager] getFriendWithUserID:self.userID onSuccess:^(User *user) {
        self.user = user;
        self.user.vc = self;

        self.sexLabel.text = user.sex;
        self.onlineLabel.text = user.isOnline;
        self.birthDateLabel.text = user.birthDay;
        self.followersLabel.text = user.followersCount;
        
        NSData *data = [NSData dataWithContentsOfURL:user.imageURL];
        self.photoImageView.image = [UIImage imageWithData:data];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", user.lastName, user.firstName];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"Error = %@, code = %ld", error.localizedDescription, statusCode);
    }];
    
}


@end
