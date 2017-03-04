//
//  User.m
//  APIBasicsVK
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "User.h"
#import "EVAServerManager.h"
#import "EVAFriendsViewController.h"

@implementation User
-(id) initWithServerResponse:(NSDictionary *)responseObject{
    self = [super self];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.userID = [responseObject objectForKey:@"user_id"];
        
        NSString* count = [responseObject objectForKey:@"followers_count"];
        self.followersCount = [NSString stringWithFormat:@"follower : %@", count];
        
        NSString *urlString50 = [responseObject objectForKey:@"photo_50"];
        NSString *urlString200 = [responseObject objectForKey:@"photo_200"];
        if (urlString50) {
            self.imageURL = [NSURL URLWithString:urlString50];
        }else{
            self.imageURL = [NSURL URLWithString:urlString200];
        }

        [[EVAServerManager sharedManager] getCityWithId:(NSNumber*)[responseObject objectForKey:@"city"]
                                              onSuccess:^(NSString *cityName) {
                                                  
                                                  self.city = cityName;
                                                  self.vc.cityLabel.text = self.city;

                                              }
                                              onFailure:^(NSError *error, NSInteger statusCode) {
                                                  
                                              }];

         
        [[EVAServerManager sharedManager] getCountryWithId:[responseObject objectForKey:@"country"]
                                                 onSuccess:^(NSString *countryName) {
                                                    self.country = countryName;
                                                    self.vc.countryLabel.text = self.country;
                                                 } onFailure:^(NSError *error, NSInteger statusCode) {
                                                     
                                                 }];
        
        
        self.birthDay = [responseObject objectForKey:@"bdate"];
        
        NSInteger sexFriend = [(NSNumber*)[responseObject objectForKey:@"sex"] integerValue];
        NSString *sexStatus;
        switch (sexFriend) {
            case 0:
                sexStatus = @"пол не указан";
                break;
            case 1:
                sexStatus = @"женский";
                break;
            case 2:
                sexStatus = @"мужской";
                break;
        }
        self.sex = sexStatus;

       NSInteger isOnlineFriend = [(NSNumber*)[responseObject objectForKey:@"online"] integerValue];
        NSString *isOnlineStatus;
        switch (isOnlineFriend) {
            case 0:
                isOnlineStatus = @"offline";
                break;
            case 1:
                isOnlineStatus = @"online";
                break;
        }
        self.isOnline = isOnlineStatus;
        
    }
    return self;
}

@end

