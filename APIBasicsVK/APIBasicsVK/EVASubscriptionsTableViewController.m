//
//  EVASubscriptionsTableViewController.m
//  APIBasicsVK
//
//  Created by Admin on 02.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVASubscriptionsTableViewController.h"
#import "EVAServerManager.h"
#import "Subscribers.h"
#import "UIImageView+AFNetworking.h"
@interface EVASubscriptionsTableViewController ()
@property (strong, nonatomic) NSMutableArray *subscriptionsArray;
@end

static NSInteger subscriptionsInRequest = 20;

@implementation EVASubscriptionsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.subscriptionsArray = [NSMutableArray array];
    [self getSubscriptionsFromServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - API
-(void) getSubscriptionsFromServer{
    [[EVAServerManager sharedManager] getSubscriptionsWithOffset:[self.subscriptionsArray count] count:subscriptionsInRequest userID:self.userID onSuccess:^(NSArray *array) {
        
        [self.subscriptionsArray addObjectsFromArray:array];
        NSMutableArray *newPaths = [NSMutableArray array];
        
        for (int i = (int)[self.subscriptionsArray count]-(int)[array count]; i < [self.subscriptionsArray count]; i++) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.subscriptionsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (indexPath.row == self.subscriptionsArray.count - 1) {
        [self getSubscriptionsFromServer];
    }
    
    Subscribers *subscribers = [self.subscriptionsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", subscribers.name];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:subscribers.imageURL];
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
