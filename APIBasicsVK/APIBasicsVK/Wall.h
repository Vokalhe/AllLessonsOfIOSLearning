//
//  Wall.h
//  APIBasicsVK
//
//  Created by Admin on 05.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EVAServerManager.h"
#import "EVAWallTableViewController.h"
#import "Group.h"

@interface Wall : NSObject
@property (strong, nonatomic) EVAWallTableViewController *vc;
@property (assign, nonatomic) BOOL postTypeIsCopy;

@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSString *date;
@property (strong,nonatomic) NSURL *postImageURL;
@property (strong,nonatomic) NSURL *ownerUserPostPhotoURL;
@property (strong,nonatomic) NSString *ownerUserPostName;

@property (strong, nonatomic) NSURL *ownerCopyPhotoURL;
@property (strong, nonatomic) NSString *ownerCopyName;
@property (strong,nonatomic) NSString * postCopydate;

@property (strong,nonatomic) NSNumber *likesCount;
@property (strong,nonatomic) NSNumber *repostCount;

@property(strong, nonatomic) NSString *type;
- (id) initWithServerResponse: (NSDictionary*) response;

@end
