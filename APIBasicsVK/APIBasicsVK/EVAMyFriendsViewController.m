//
//  ViewController.m
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAMyFriendsViewController.h"
#import "EVAServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "EVAFriendsViewController.h"

@interface EVAMyFriendsViewController ()
@property (strong, nonatomic) NSMutableArray *friendsArray;
@end

static NSInteger friendsInRequest = 20;

@implementation EVAMyFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
    self.navigationItem.title = @"My Friends";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - API
-(void) getFriendsFromServer{
    [[EVAServerManager sharedManager] getFriendsWithOffset:[self.friendsArray count] count:friendsInRequest onSuccess:^(NSArray *array) {
        
        [self.friendsArray addObjectsFromArray:array];
        NSMutableArray *newPaths = [NSMutableArray array];
        
        for (int i = (int)[self.friendsArray count]-(int)[array count]; i < [self.friendsArray count]; i++) {
            [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (indexPath.row == self.friendsArray.count - 1) {
        [self getFriendsFromServer];
    }

    User *friend = [self.friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
    //cell.detailTextLabel.text = friend.isOnline ? @"online" : @"";
   // NSLog(@"%@ %@", cell.textLabel.text, cell.detailTextLabel.text);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", friend.isOnline];
    if ([friend.isOnline isEqualToString:@"online"]) {
        cell.detailTextLabel.textColor = [UIColor greenColor];

    } else {
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageURL];
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

    User *friend = [self.friendsArray objectAtIndex:indexPath.row];
    EVAFriendsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAFriendsViewController"];
    vc.userID = friend.userID;
    [self.navigationController pushViewController:vc animated:YES];
   
}

@end
