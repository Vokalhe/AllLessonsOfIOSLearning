//
//  EVAPost.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 14.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAObjectServer.h"
#import "EVAWallTableViewController.h"

@class EVAUser;

@interface EVAPost : EVAObjectServer
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSNumber *likeCount;
@property (assign, nonatomic) NSNumber *commentCount;
@property (strong, nonatomic) NSString *date;
@property (strong,nonatomic) NSURL *postImageURL;
@property (strong,nonatomic) NSURL *ownerUserPostPhotoURL;
@property (strong,nonatomic) NSString *ownerUserPostName;
@property (strong, nonatomic) NSNumber *ownerByUserID;
@property (strong, nonatomic) EVAWallTableViewController *vc;


-(id)initWithServerResponse:(NSDictionary *)responseObject;
@end
