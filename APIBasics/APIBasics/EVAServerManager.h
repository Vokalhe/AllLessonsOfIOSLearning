//
//  EVAServerManager.h
//  APIBasics
//
//  Created by Admin on 25.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "User.h"
@interface EVAServerManager : NSObject
@property (strong, nonatomic) AFHTTPSessionManager *requestSessionManager;

+(EVAServerManager*) sharedManager;
-(void) getFriendsWithOffset:(NSInteger) offset count:(NSInteger) count onSuccess:(void(^)(NSArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
@end
