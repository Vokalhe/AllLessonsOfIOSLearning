//
//  User.h
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//
@class EVAFriendsViewController;
#import <Foundation/Foundation.h>
@interface User : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;
@property (assign, nonatomic) NSNumber *userID;
@property (strong, nonatomic) NSString *birthDay;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *isOnline;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *followersCount;

@property (strong, nonatomic) EVAFriendsViewController *vc;
-(id) initWithServerResponse:(NSDictionary*) responseObject;
@end
