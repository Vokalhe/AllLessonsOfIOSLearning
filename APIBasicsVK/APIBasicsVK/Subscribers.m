//
//  Subscribers.m
//  APIBasicsVK
//
//  Created by Admin on 02.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "Subscribers.h"

@implementation Subscribers
-(id) initWithServerResponse:(NSDictionary *)responseObject{
    self = [super self];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        NSString *urlString50 = [responseObject objectForKey:@"photo_50"];
        self.imageURL = [NSURL URLWithString:urlString50];
    }
    return self;
}
@end
