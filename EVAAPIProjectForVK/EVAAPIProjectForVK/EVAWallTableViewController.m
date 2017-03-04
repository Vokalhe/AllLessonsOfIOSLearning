//
//  EVAWallTableViewController.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAWallTableViewController.h"
#import "EVAMessageViewController.h"
#import "EVAServerManager.h"
#import "EVAPostCell.h"

#import "EVAUser.h"
#import "EVAPost.h"

#import "UITableViewCell+CellForContent.h"

@interface EVAWallTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL firstTimeAppear;
@property (strong, nonatomic) NSMutableArray *postsArray;

@end

static NSInteger postsInRequest = 20;

@implementation EVAWallTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postsArray = [NSMutableArray array];
    self.firstTimeAppear = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    UIBarButtonItem *plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(postOnWall:)];
    self.navigationItem.rightBarButtonItem = plus;
    
    [self getPostsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppear) {
        self.firstTimeAppear = NO;
        [[EVAServerManager sharedManager] authorizeUser:^(EVAUser *user) {
            NSLog(@"AUTHORIZED!");
            NSLog(@"%@ %@", user.firstName, user.lastName);
        }];
    }
}
#pragma mark - Gestures
- (void) handleTapOnImageView:(UITapGestureRecognizer*) recognizer {
    
    NSLog(@"TAP WORKS!!");
    
    // Taking tapped image view from activated recognizer
    /*UIImageView* tappedImageView = (UIImageView*)recognizer.view;
    
    ANPostCell* clickedPostCell = (ANPostCell*)[UITableViewCell getParentCellFor:tappedImageView];
    
    NSIndexPath* clickedIndexPath = [self.tableView indexPathForCell:clickedPostCell];
    
    ANPost* clickedPost = [self.postsArray objectAtIndex:clickedIndexPath.row];
    
    ANJSQMessagesVC* vc = [[ANJSQMessagesVC alloc] init];
    
    vc.senderId = clickedPost.author.userID;
    
    vc.senderDisplayName = [NSString stringWithFormat:@"%@ %@", clickedPost.author.firstName, clickedPost.author.lastName];
    
    vc.avatarIncoming = clickedPost.author.imageURL;
    
    vc.avatarOutgoing = [[[ANServerManager sharedManager] currentUser] imageURL];
    
    
    [self.navigationController pushViewController:vc animated:YES];*/
    UIImageView *tappedImageView = (UIImageView*)recognizer.view;
    EVAPostCell *clickedPostCell = (EVAPostCell*)[UITableViewCell getParentCellFor:tappedImageView];
    NSIndexPath* clickedIndexPath = [self.tableView indexPathForCell:clickedPostCell];
    
    EVAPost* clickedPost = [self.postsArray objectAtIndex:clickedIndexPath.row];
    EVAMessageViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"EVAMessageViewController"];
    
    [[EVAServerManager sharedManager] getUser:clickedPost.ownerByUserID onSuccess:^(EVAUser *user) {
        controller.user = user;
        NSLog(@"%@", controller.user.firstName);
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    [self.navigationController pushViewController:controller animated:YES];
    
   /* CGPoint hitPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath* hitIndex = [self.tableView indexPathForRowAtPoint:hitPoint];
    VSChatTableViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"VSChatTableViewController"];
    VSWallPost* wall = [self.wallPostsArray objectAtIndex:hitIndex.row];
    controller.authorID = wall.ownerID;
    [self presentViewController:nav animated:YES completion:nil];*/
    
}


#pragma mark - API
-(void) postOnWall:(id) sender{
    
    [[EVAServerManager sharedManager] postText:@"Это тест из урока номер 47!" onGroupWall:@"58860049" onSuccess:^(id result) {
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
}

-(void) refreshWall{
    [[EVAServerManager sharedManager] getWallGroupWithOffset:0 count:MAX(postsInRequest, [self.postsArray count]) ownerID:@"58860049" onSuccess:^(NSArray *posts) {
        
        [self.postsArray removeAllObjects];
        [self.postsArray addObjectsFromArray:posts];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"%@ - %ld", error, statusCode);
        [self.refreshControl endRefreshing];
        
    }];
}

-(void) getPostsFromServer{
    [[EVAServerManager sharedManager] getWallGroupWithOffset:[self.postsArray count] count:postsInRequest ownerID:@"58860049" onSuccess:^(NSArray *posts) {
        
        [self.postsArray addObjectsFromArray:posts];
        NSMutableArray *newPosts = [NSMutableArray array];
        
        for (int i = (int)[self.postsArray count] - (int)[posts count]; i < [self.postsArray count]; i++) {
            [newPosts addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPosts withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@ - %ld", [error localizedDescription], statusCode);
    }];
}
#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.postsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"EVAPostCell";
    
    EVAPostCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[EVAPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    EVAPost* post = [self.postsArray objectAtIndex:indexPath.row];

    if (indexPath.row == [self.postsArray count] - 1) {
        [self getPostsFromServer];
    }
    
    [cell configureCellWithPostOnWall:post viewController:self];

    cell.postTextLabel.text = post.text;
    cell.likeLabel.text = [NSString stringWithFormat:@"likes : %@", post.likeCount];
    cell.commentLabel.text = [NSString stringWithFormat:@"comments : %@", post.commentCount];
    
    cell.nameOwnerLabel.text = post.ownerUserPostName;
    cell.dateLabel.text = post.date;
    
    
    
    if (post.postImageURL) {
        
        NSURLRequest* postImageRequest = [NSURLRequest requestWithURL:post.postImageURL];
        __weak EVAPostCell* weakCell = cell;
        cell.imagePostURL.image = nil;
        
        [cell.imagePostURL setImageWithURLRequest:postImageRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.imagePostURL.contentMode = UIViewContentModeScaleAspectFit;
            weakCell.imagePostURL.image = image;
            [weakCell layoutSubviews];
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    
    if (post.ownerUserPostPhotoURL) {
        
        // set owner photo
        NSURLRequest* ownerPostPhotoRequest = [NSURLRequest requestWithURL:post.ownerUserPostPhotoURL];
        __weak EVAPostCell* weakCell = cell;
        
        [cell.imageURL setImageWithURLRequest:ownerPostPhotoRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
            
            weakCell.imageURL.image = image;
            [weakCell layoutSubviews];
            
            weakCell.imageURL.layer.cornerRadius = CGRectGetWidth(weakCell.imageURL.bounds) / 2;
            weakCell.imageURL.layer.masksToBounds = YES;
            
        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
            
        }];
    }
    //CREATING GESTURE RECOGNIZER FOR HANDLE AUTHOR IMAGEVIEW TAP
    
    cell.imageURL.userInteractionEnabled = YES;
    
    UIGestureRecognizer* tapAuthorImageViewGesutre = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleTapOnImageView:)];
    
    [cell.imageURL addGestureRecognizer:tapAuthorImageViewGesutre];

    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    EVAPost* post = [self.postsArray objectAtIndex:indexPath.row];
    return [EVAPostCell heightForPostOnWall:post viewController:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
