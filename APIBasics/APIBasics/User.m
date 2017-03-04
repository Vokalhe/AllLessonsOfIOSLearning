//
//  User.m
//  APIBasics
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "User.h"

@implementation User
-(id) initWithServerResponse:(NSDictionary *)responseObject{
    self = [super self];
    if (self) {
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        NSString *urlString = [responseObject objectForKey:@"photo_50"];
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }

    }
    return self;
}
@end
