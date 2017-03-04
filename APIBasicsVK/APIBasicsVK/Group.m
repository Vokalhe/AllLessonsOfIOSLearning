//
//  Group.m
//  APIBasicsVK
//
//  Created by Admin on 05.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "Group.h"

@implementation Group
-(id)initWithServerResponse:(NSDictionary*) response{
    self = [super init];
    if (self) {
        self.name = [response objectForKey:@"name"];
        NSString* stringURL = [response objectForKey:@"photo"];
        self.imageURL = [NSURL URLWithString:stringURL];
    }
    return self;
}
@end
