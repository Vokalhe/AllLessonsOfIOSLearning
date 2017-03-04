//
//  EVAServerManager.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 13.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class EVAAccessToken;
@class EVAUser;


@interface EVAServerManager : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *requestSessionManager;
@property (strong, nonatomic) EVAAccessToken* accessToken;

+(EVAServerManager*) sharedManager;

-(void) authorizeUser:(void(^)(EVAUser *user)) completion;

-(void) getWallGroupWithOffset:(NSInteger) offset count:(NSInteger) count ownerID:(NSString*) groupID onSuccess:(void(^)(NSArray* posts)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getUser:(NSNumber*) userID
       onSuccess:(void(^)(EVAUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure ;

-(void) postText:(NSString*) text onGroupWall:(NSString*) groupID onSuccess:(void(^)(id result)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure ;

-(void) getMessageHistoryWithOffset:(NSInteger)offset count:(NSInteger)count andPreviewLength:(NSInteger)previewLength onSuccess:(void(^)(NSArray* dialogs))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;

- (void)getMessagesWithUserID:(NSNumber *)userID count:(NSInteger)count offset:(NSInteger)offset onSuccess:(void(^)(NSArray* messages))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;
@end
