//
//  EVAWallTableViewController.m
//  APIBasicsVK
//
//  Created by Admin on 04.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAWallTableViewController.h"
#import "EVAServerManager.h"
#import "Wall.h"
#import "PostWallTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface EVAWallTableViewController ()

@property (strong, nonatomic) NSMutableArray* wallArray;
@property (assign, nonatomic) BOOL wallIsEmty;

@end

@implementation EVAWallTableViewController

static NSInteger postsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wallArray = [NSMutableArray array];
    [self getWallFromServer];
    
    UIRefreshControl* refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Server Manager Methods
- (void) refreshWall {
    
    [[EVAServerManager sharedManager]
     getWallWithOwnerId:self.userID
     offset:0
     count:MAX(postsInRequest, self.wallArray.count)
     onSuccess:^(NSArray *wallPosts) {
         
         if (wallPosts) {
             [self.wallArray removeAllObjects];
             [self.wallArray addObjectsFromArray:wallPosts];
             [self.tableView reloadData];
         }
         
         [self.refreshControl endRefreshing];
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"Error = %@, code = %ld", error.localizedDescription, statusCode);
         [self.refreshControl endRefreshing];
     }];
}

- (void) getWallFromServer {
    
    [[EVAServerManager sharedManager]
     getWallWithOwnerId:self.userID
     offset:self.wallArray.count
     count:postsInRequest
     onSuccess:^(NSArray *wallPosts) {
         
         if (wallPosts) {
             [self.wallArray addObjectsFromArray:wallPosts];
             NSMutableArray* newPaths = [NSMutableArray array];
             
             for (int i = (int) self.wallArray.count - (int) wallPosts.count; i < self.wallArray.count; i += 1) {
                 [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
             }
             
             [self.tableView beginUpdates];
             [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
             [self.tableView endUpdates];
             
         } else {
             
             if (self.wallArray.count == 0) {
                 self.wallIsEmty = YES;
                 [self.tableView reloadData];
             }
         }
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"Error = %@, code = %ld", error.localizedDescription, statusCode);
     }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.wallIsEmty) {
        return 1;
    } else {
        return self.wallArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString* identifier = @"WallCell";
    static NSString* cellForEmtyTableIdentifier = @"CellForEmtyTable";

    
    if (self.wallIsEmty) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellForEmtyTableIdentifier];
        cell.textLabel.text = @"User hid his wall, or wall is empty";
        cell.textLabel.font = [cell.textLabel.font fontWithSize:20];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
    if (indexPath.row == self.wallArray.count - 1) {
        [self getWallFromServer];
    }
    
    
    
    PostWallTableViewCell *cell = [[PostWallTableViewCell alloc] init];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    Wall* postOnWall = [self.wallArray objectAtIndex:indexPath.row];
    
    postOnWall.vc = self;
    
    [cell configureCellWithPostOnWall:postOnWall viewController:self];
    
    // set post image
    if (postOnWall.postImageURL) {
        
        NSURLRequest* postImageRequest = [NSURLRequest requestWithURL:postOnWall.postImageURL];
        __weak PostWallTableViewCell* weakCell = cell;
        cell.imageViewInPost.image = nil;
        
        [cell.imageViewInPost setImageWithURLRequest:postImageRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.imageViewInPost.contentMode = UIViewContentModeScaleAspectFit;
            weakCell.imageViewInPost.image = image;
            [weakCell layoutSubviews];

       } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
           
       }];
    }
    
    if (postOnWall.ownerUserPostPhotoURL) {
        
        // set owner photo
        NSURLRequest* ownerPostPhotoRequest = [NSURLRequest requestWithURL:postOnWall.ownerUserPostPhotoURL];
        __weak PostWallTableViewCell* weakCell = cell;
        
        [cell.ownerImageView setImageWithURLRequest:ownerPostPhotoRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.ownerImageView.image = image;
            [weakCell layoutSubviews];
            
            weakCell.ownerImageView.layer.cornerRadius = CGRectGetWidth(weakCell.ownerImageView.bounds) / 2;
            weakCell.ownerImageView.layer.masksToBounds = YES;
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    
    if (postOnWall.postTypeIsCopy) {
        
        // set owner copy post photo
        NSURLRequest* ownerCopyPhotoRequest = [NSURLRequest requestWithURL:postOnWall.ownerCopyPhotoURL];
        __weak PostWallTableViewCell* weakCell = cell;
        
        [cell.ownerCopyImageView setImageWithURLRequest:ownerCopyPhotoRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.ownerCopyImageView.image = image;
            [weakCell layoutSubviews];
            
            weakCell.ownerCopyImageView.layer.cornerRadius = CGRectGetWidth(weakCell.ownerCopyImageView.bounds) / 2;
            weakCell.ownerCopyImageView.layer.masksToBounds = YES;
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
        
        cell.ownerCopyNameLabel.text = postOnWall.ownerCopyName;
        cell.ownerCopyDateLabel.text = postOnWall.postCopydate;
        cell.ownerCopyDateLabel.font = [cell.ownerCopyDateLabel.font fontWithSize:12];
    }
    
    cell.ownerNameLabel.text = postOnWall.ownerUserPostName;
    cell.textInPostTextView.text = postOnWall.text;
    cell.dateLabel.text = postOnWall.date;
    cell.dateLabel.font = [cell.dateLabel.font fontWithSize:12];
    
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", postOnWall.likesCount];
    cell.repostLabel.text = [NSString stringWithFormat:@"Reposts: %@", postOnWall.repostCount];
    
    return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.wallIsEmty) {
        return 44.0f;
    } else {
        Wall* wallPost = [self.wallArray objectAtIndex:indexPath.row];
        return [PostWallTableViewCell heightForPostOnWall:wallPost viewController:self];
    }
}
@end
