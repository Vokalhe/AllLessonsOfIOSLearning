//
//  EVAUser.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAUser.h"

@implementation EVAUser
-(id) initWithServerResponse:(NSDictionary *)responseObject{
    self = [super init];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        NSString *urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString) {
            
            self.imageURL = [NSURL URLWithString:urlString];

        }
        self.userID = [responseObject objectForKey:@"id"];
    }
    return self;    
}

@end
