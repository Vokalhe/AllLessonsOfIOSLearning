//
//  EVAMessage.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 05.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAMessage.h"

@implementation EVAMessage

-(id) initWithServerResponse:(NSDictionary *)responseObject{
    
    self = [super initWithServerResponse:responseObject];
    
    self.messageID = [responseObject objectForKey:@"id"];
    self.body = [responseObject objectForKey:@"body"];
    self.fromID = [responseObject objectForKey:@"from_id"];
    
    return self;
}
@end
