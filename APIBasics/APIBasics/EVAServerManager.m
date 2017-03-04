//
//  EVAServerManager.m
//  APIBasics
//
//  Created by Admin on 25.01.17.
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
                            @"photo_50", @"fields",
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

@end
