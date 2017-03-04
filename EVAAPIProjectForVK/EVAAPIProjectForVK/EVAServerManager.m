//
//  EVAServerManager.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 13.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAServerManager.h"

#import "EVAAccessToken.h"
#import "EVAPost.h"
#import "EVALoginViewController.h"
#import "EVAUser.h"
#import "EVAMessageHistory.h"

static NSInteger errorDuringNetworkRequest = 999;

@implementation EVAServerManager
- (id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestSessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:url];
        
    }
    return self;
}

+(EVAServerManager*) sharedManager {
    static EVAServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EVAServerManager alloc] init];
    });
    return manager;
}

-(void) authorizeUser:(void(^)(EVAUser *user)) completion{
    EVALoginViewController *vc = [[EVALoginViewController alloc] initWithCompletionBlock:^(EVAAccessToken *token) {
        self.accessToken = token;
        if(token){
            [self getUser:self.accessToken.userID onSuccess:^(EVAUser *user) {
                if(completion){
                    completion(user);
                }
            } onFailure:^(NSError *error, NSInteger statusCode) {
                if(completion){
                    completion(nil);
                }
            }];
        }else if(completion){
            completion(nil);
        }
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [mainVC presentViewController:nav animated:YES completion:nil];
}

#pragma mark - GET
-(void) getWallGroupWithOffset:(NSInteger) offset count:(NSInteger) count ownerID:(NSString*) groupID onSuccess:(void(^)(NSArray* posts)) success onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    if (![groupID hasPrefix:@"-"]) {
        groupID = [@"-" stringByAppendingString:groupID];
    }
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                           groupID, @"owner_id",
                            @(count), @"count",
                            @(offset), @"offset",
                            @"all", @"filter", nil];
    
    [self.requestSessionManager GET:@"wall.get" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dictsArray = [responseObject objectForKey:@"response"];
        
        if([dictsArray count] > 1){
            dictsArray = [dictsArray subarrayWithRange:NSMakeRange(1, (int)[dictsArray count]-1)];
        }else{
            dictsArray = nil;
        }
        
        NSMutableArray *objectsArray = [NSMutableArray array];
        
        for(NSDictionary *dict in dictsArray){
            EVAPost *userPost = [[EVAPost alloc] initWithServerResponse:dict];
            [objectsArray addObject:userPost];
        }
        if (success) {
            success(objectsArray);
        }
        
        
    } failure:^(NSURLSessionDataTask *  task, NSError * _Nonnull error) {
        NSLog(@"error = %@", [error localizedDescription]);
        if (failure) {
            failure(error, errorDuringNetworkRequest);
        }
    }];
    
}

- (void) getUser:(NSNumber*) userID
       onSuccess:(void(^)(EVAUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userID,        @"user_ids",
     @"photo_50",   @"fields",
     @"nom",        @"name_case", nil];
    
    [self.requestSessionManager GET:@"users.get" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray* dictsArray = [responseObject objectForKey:@"response"];
        
        if ([dictsArray count] > 0) {
            EVAUser* user = [[EVAUser alloc] initWithServerResponse:[dictsArray firstObject]];
            if (success) {
                success(user);
            }
        } else {
            if (failure) {
                failure(nil, errorDuringNetworkRequest);
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, errorDuringNetworkRequest);
        }

    }];
}

#pragma mark - POST
-(void) postText:(NSString*) text onGroupWall:(NSString*) groupID onSuccess:(void(^)(id result)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    if (![groupID hasPrefix:@"-"]) {
        groupID = [@"-" stringByAppendingString:groupID];
    }

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            groupID, @"owner_id",
                            text, @"message",
                            self.accessToken.token, @"access_token",
                            @"5.62", @"v",nil];
    
    /*[self.requestSessionManager POST:@"wall.post" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        if(success){
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error, errorDuringNetworkRequest);
        }

    }];*/
    [self.requestSessionManager POST:@"wall.post"
                   parameters:params
                     progress:nil
                      success:^(NSURLSessionTask *task, id responseObject) {
                          NSLog(@"JSON: %@", responseObject);
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure:^(NSURLSessionTask *operation, NSError *error) {
                          NSLog(@"Error: %@", error);
                          NSHTTPURLResponse* htttpResponse = (NSHTTPURLResponse *)operation;
                          if (failure) {
                              failure(error,htttpResponse.statusCode);
                          }
                      }];
}

-(void) getMessageHistoryWithOffset:(NSInteger)offset count:(NSInteger)count andPreviewLength:(NSInteger)previewLength onSuccess:(void(^)(NSArray* dialogs))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure {
 
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @(previewLength),       @"preview_length",
                            @(count),               @"count",
                            @(offset),              @"offset",
                            self.accessToken.token, @"access_token",
                            @"5.60",                @"V",
                            nil];
    
    [self.requestSessionManager GET:@"messages.getDialogs"
                  parameters:params
                    progress:nil
                     success:^(NSURLSessionTask *task, id responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray* wallArray = [responseObject objectForKey:@"response"];
                         
                         if ([wallArray count] > 1){
                             wallArray = [wallArray subarrayWithRange:NSMakeRange(1, (int)[wallArray count] - 1)];
                         }else {
                             wallArray = nil;
                         }
                         
                         NSMutableArray* objectsArray = [[NSMutableArray alloc]init];
                         
                         [wallArray enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL * _Nonnull stop) {//analog for
                             EVAMessageHistory* messages = [[EVAMessageHistory alloc]initWithServerResponse:dict];
                             [objectsArray addObject:messages];
                         }];
                         
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         NSHTTPURLResponse* htttpResponse = (NSHTTPURLResponse *)operation;
                         if (failure) {
                             failure(error,htttpResponse.statusCode);
                         }
                     }];

    
}

- (void)getMessagesWithUserID:(NSNumber *)userID count:(NSInteger)count offset:(NSInteger)offset onSuccess:(void(^)(NSArray* messages))success onFailure:(void(^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userID,                 @"user_id",
                            @(count),               @"count",
                            @(offset),              @"offset",
                            self.accessToken.token, @"access_token",
                            @"0",                   @"rev",
                            @"5.60",                @"V",
                            nil];
    
    [self.requestSessionManager GET:@"messages.getHistory"
                  parameters:params
                    progress:nil
                     success:^(NSURLSessionTask *task, id responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         
                         NSArray* wallArray = [responseObject objectForKey:@"response"];
                         
                         if ([wallArray count] > 1){
                             wallArray = [wallArray subarrayWithRange:NSMakeRange(1, (int)[wallArray count] - 1)];
                         }else {
                             wallArray = nil;
                         }
                         
                         NSMutableArray* objectsArray = [[NSMutableArray alloc]init];
                         
                         [wallArray enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL * _Nonnull stop) {
                             EVAMessageHistory* messages = [[EVAMessageHistory alloc]initWithServerResponse:dict];
                             [objectsArray addObject:messages];
                         }];
                         if (success) {
                             success(objectsArray);
                         }
                     }
                     failure:^(NSURLSessionTask *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         NSHTTPURLResponse* htttpResponse = (NSHTTPURLResponse *)operation;
                         if (failure) {
                             failure(error,htttpResponse.statusCode);
                         }
                     }];
}


@end
