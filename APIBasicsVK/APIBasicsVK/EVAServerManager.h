//
//  EVAServerManager.h
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "User.h"
#import "Subscribers.h"
#import "Wall.h"
#import "Group.h"
@interface EVAServerManager : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *requestSessionManager;

+(EVAServerManager*) sharedManager;

-(void) getFriendsWithOffset:(NSInteger) offset count:(NSInteger) count onSuccess:(void(^)(NSArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCityWithId: (NSNumber*) identifier
             onSuccess: (void(^)(NSString* cityName)) success
             onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCountryWithId: (NSNumber*) identifier
               onSuccess: (void(^)(NSString* countryName)) success
               onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getFriendWithUserID:(NSNumber*) userID onSuccess:(void(^)(User *user)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getSubscriptionsWithOffset:(NSInteger) offset count:(NSInteger) count userID:(NSNumber*) userID onSuccess:(void(^)(NSArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getFollowersWithOffset:(NSInteger) offset count:(NSInteger) count userID:(NSNumber*) userID onSuccess:(void(^)(NSMutableArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getGroupWithID:(NSNumber*) groupID onSuccess:(void(^)(Group *group)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getWallWithOwnerId: (NSNumber*) ownerId offset: (NSInteger) offset count: (NSInteger) count onSuccess: (void(^)(NSArray* wallPosts)) success onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure;


@end
