//
//  EVAServerManager.m
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAServerManager.h"

@implementation EVAServerManager

+(EVAServerManager*) sharedManager{
    static EVAServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EVAServerManager alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}

-(void) getFriendsWithOffset:(NSInteger) offset count:(NSInteger) count onSuccess:(void(^)(NSArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"67055315", @"user_id",
                            @"name", @"order",
                            @(count), @"count",
                            @(offset), @"offset",
                            @"photo_50, online", @"fields",
                            @"nom", @"name_case", nil];
    
    [self.requestSessionManager GET:@"friends.get" parameters: params
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictsArray = [responseObject objectForKey:@"response"];
                                NSMutableArray* objectsArray = [NSMutableArray array];
                                
                                for (NSDictionary* dict in dictsArray) {
                                    User* user = [[User alloc] initWithServerResponse:dict];
                                    [objectsArray addObject:user];
                                }
                                
                                if (success) {
                                    success(objectsArray);
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    failure(error, statusCode);
                                }
                                
                            }];
}

-(void) getFriendWithUserID:(NSNumber*) userID onSuccess:(void(^)(User *user)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString* valueForFields = @"photo_200, sex, bdate, city, country, online, followers_count";
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID, @"user_ids",
                            valueForFields, @"fields",
                            @"nom", @"name_case", nil];
    
    [self.requestSessionManager GET:@"users.get" parameters: params
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictsArray = [responseObject objectForKey:@"response"];
                                User *user = [[User alloc] initWithServerResponse:[dictsArray firstObject]];
                                if (success) {
                                    success(user);
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    failure(error, statusCode);
                                }
                                
                            }];
}


- (void) getCityWithId: (NSNumber*) identifier
             onSuccess: (void(^)(NSString* cityName)) success
             onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* parapms = [NSDictionary dictionaryWithObjectsAndKeys: identifier, @"city_ids", nil];
    
    [self.requestSessionManager GET:@"database.getCitiesById"
                  parameters:parapms
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray* dictArray = [responseObject objectForKey:@"response"];
                         NSString* cityName = [[dictArray firstObject] objectForKey:@"name"];
                         
                         if (success) {
                             success(cityName);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"error: %@", error);
                         
                         if (failure) {
                             
                             NSInteger statusCode = 0;
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             
                             if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                 statusCode = httpResponse.statusCode;
                             }
                             
                             failure(error, statusCode);
                         }
                     }];
    
}

- (void) getCountryWithId: (NSNumber*) identifier
             onSuccess: (void(^)(NSString* countryName)) success
             onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* parapms = [NSDictionary dictionaryWithObjectsAndKeys: identifier, @"country_ids", nil];
    
    [self.requestSessionManager GET:@"database.getCountriesById"
                         parameters:parapms
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictArray = [responseObject objectForKey:@"response"];
                                NSString* contryName = [[dictArray firstObject] objectForKey:@"name"];
                                
                                if (success) {
                                    success(contryName);
                                }
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    
                                    failure(error, statusCode);
                                }
                            }];
    
}

-(void) getSubscriptionsWithOffset:(NSInteger) offset count:(NSInteger) count userID:(NSNumber*) userID onSuccess:(void(^)(NSArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID, @"user_id",
                            @(1), @"extended",
                            @(count), @"count",
                            @(offset), @"offset",
                            @"photo_50, online", @"fields",
                            nil];
    
    [self.requestSessionManager GET:@"users.getSubscriptions" parameters: params
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictsArray = [responseObject objectForKey:@"response"];
                                NSMutableArray* objectsArray = [NSMutableArray array];
                                
                                for (NSDictionary* dict in dictsArray) {
                                    Subscribers *sub = [[Subscribers alloc] initWithServerResponse:dict];
                                    [objectsArray addObject:sub];
                                }
                                
                                if (success) {
                                    success(objectsArray);
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    failure(error, statusCode);
                                }
                                
                            }];
}

-(void) getFollowersWithOffset:(NSInteger) offset count:(NSInteger) count userID:(NSNumber*) userID onSuccess:(void(^)(NSMutableArray* array)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID, @"user_id",
                            @"name", @"order",
                            @(count), @"count",
                            @(offset), @"offset",
                            @"photo_50, online", @"fields",
                            @"nom", @"name_case", nil];
    NSLog(@"%@", userID);
    [self.requestSessionManager GET:@"users.getFollowers" parameters: params
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictsArray = [[responseObject objectForKey:@"response"]objectForKey:@"items"];
                                NSMutableArray* objectsArray = [NSMutableArray array];
                                
                                for (NSDictionary* dict in dictsArray) {
                                    User* user = [[User alloc] initWithServerResponse:dict];
                                    [objectsArray addObject:user];
                                }
                                
                                if (success) {
                                    success(objectsArray);
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    failure(error, statusCode);
                                }
                                
                            }];
}

-(void) getGroupWithID:(NSNumber*) groupID onSuccess:(void(^)(Group *group)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            groupID, @"group_id", nil];
    
    [self.requestSessionManager GET:@"groups.getById" parameters: params
                           progress:^(NSProgress * _Nonnull downloadProgress) {
                               
                           }
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                NSLog(@"JSON: %@", responseObject);
                                
                                NSArray* dictsArray = [responseObject objectForKey:@"response"];
                                Group *group = [[Group alloc] initWithServerResponse:[dictsArray firstObject]];
                                if (success) {
                                    success(group);
                                }
                                
                            }
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                NSLog(@"error: %@", error);
                                
                                if (failure) {
                                    
                                    NSInteger statusCode = 0;
                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                    
                                    if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                        statusCode = httpResponse.statusCode;
                                    }
                                    failure(error, statusCode);
                                }
                                
                            }];
}

- (void) getWallWithOwnerId: (NSNumber*) ownerId offset: (NSInteger) offset count: (NSInteger) count onSuccess: (void(^)(NSArray* wallPosts)) success onFailure: (void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* parapms = [NSDictionary dictionaryWithObjectsAndKeys:
                             ownerId,           @"owner_id",
                             @(count),          @"count",
                             @(offset),         @"offset",
                             @"all",            @"filter", nil];
    
    [self.requestSessionManager GET:@"wall.get"
                  parameters:parapms
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    }
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray* responceArray = [responseObject objectForKey:@"response"];
                         
                         if (responceArray != nil && responceArray.count > 1) {
                             responceArray = [responceArray subarrayWithRange:NSMakeRange(1, responceArray.count-1)];
                             
                             NSMutableArray* postsArray = [NSMutableArray array];
                             
                             for (NSDictionary* dict in responceArray) {
                                 Wall* wallPost = [[Wall alloc] initWithServerResponse:dict];
                                 NSLog(@"JSON: %@", responseObject);

                                 [postsArray addObject:wallPost];
                             }
                             
                             if (success) {
                                 success(postsArray);
                             }
                             
                         } else {
                             
                             if (success) {
                                 success(nil);
                             }
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (failure) {
                             
                             NSInteger statusCode = 0;
                             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                             
                             if ([httpResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                                 statusCode = httpResponse.statusCode;
                             }
                             
                             failure(error, statusCode);
                         }
                     }];
    
    
}

@end
