//
//  EVAFollowersTableViewController.m
//  APIBasicsVK
//
//  Created by Admin on 03.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAFollowersTableViewController.h"
#import "EVAServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface EVAFollowersTableViewController ()
@property (strong, nonatomic) NSMutableArray *followersArray;
@end

static NSInteger followersInRequest = 20;

@implementation EVAFollowersTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.followersArray = [NSMutableArray array];
    [self getFollowersFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - API
-(void) getFollowersFromServer{
    [[EVAServerManager sharedManager] getFollowersWithOffset:self.followersArray.count count:followersInRequest userID:self.userID onSuccess:^(NSMutableArray *array) {
        
        [self.followersArray addObjectsFromArray:array];
        NSMutableArray *newPaths = [NSMutableArray array];
        
        for (int i = (int)[self.followersArray count]-(int)[array count]; i < [self.followersArray count]; i++) {
            [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
     
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error=%@, code=%ld", [error localizedDescription], statusCode);
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.followersArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (indexPath.row == self.followersArray.count - 1) {
        [self getFollowersFromServer];
    }
    
    User *followers = [self.followersArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", followers.firstName, followers.lastName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:followers.imageURL];
    __weak UITableViewCell *weakCell = cell;
    cell.imageView.image = nil;
    [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        weakCell.imageView.image = image;
        [weakCell layoutSubviews];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];

return cell;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
