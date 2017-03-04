//
//  ViewController.m
//  APIBasics
//
//  Created by Admin on 25.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "ViewController.h"
#import "EVAServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *friendsArray;
@end

static NSInteger friendsInRequest = 20;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
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
    return [self.friendsArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
    }else{
        User *friend = [self.friendsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:friend.imageURL];
        __weak UITableViewCell *weakCell = cell;
        cell.imageView.image = nil;
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
}

@end
