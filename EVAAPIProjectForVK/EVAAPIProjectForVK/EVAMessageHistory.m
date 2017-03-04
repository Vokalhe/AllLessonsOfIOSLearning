//
//  EVAMessageHistory.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 02.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAMessageHistory.h"
#import "EVAServerManager.h"
#import "EVAUser.h"
@implementation EVAMessageHistory
-(id) initWithServerResponse:(NSDictionary *)responseObject{
    
    self = [super initWithServerResponse:responseObject];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMM HH:mm:s"];
    NSInteger timeInterval = [[responseObject objectForKey:@"date"] floatValue];
    if (timeInterval != 0) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSString *stringValueOfDate = [dateFormatter stringFromDate:date];
        self.timeOfMessage = stringValueOfDate;
        
    } else {
        
        self.timeOfMessage = @"";
        
    }

    self.text = [responseObject objectForKey:@"body"];
    self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
    
    
    self.messageID = [responseObject objectForKey:@"mid"];

    self.authorID = [responseObject objectForKey:@"uid"];
    [[EVAServerManager sharedManager] getUser:self.authorID onSuccess:^(EVAUser *user) {
        self.authorImageView = user.imageURL;
        self.nameOfAuthor = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    return self;
}
@end
