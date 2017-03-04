//
//  EVAPost.m
//  EVAAPIProjectForVK
//
//  Created by Admin on 14.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAPost.h"
#import "EVAUser.h"
#import "EVAServerManager.h"


@implementation EVAPost
-(id)initWithServerResponse:(NSDictionary *)responseObject{
    self = [super initWithServerResponse:responseObject];
    if(self){
        self.text = [responseObject objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        
        self.likeCount = [[responseObject objectForKey:@"likes"] objectForKey:@"count"];
        self.commentCount = [[responseObject objectForKey:@"comments"] objectForKey:@"count"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSInteger timeInterval = [[responseObject objectForKey:@"date"] floatValue];
        if (timeInterval != 0) {
            
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
            NSString *stringValueOfDate = [dateFormatter stringFromDate:date];
            self.date = stringValueOfDate;
            
        } else {
            
            self.date = @"";
            
        }
        
        self.ownerByUserID = [responseObject objectForKey:@"from_id"];
        if ([self.ownerByUserID integerValue] > 0) {
            
            [[EVAServerManager sharedManager] getUser:self.ownerByUserID onSuccess:^(EVAUser *user) {
                
                self.ownerUserPostName = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
                self.ownerUserPostPhotoURL = user.imageURL;
                [self.vc.tableView reloadData];
                
            } onFailure:^(NSError *error, NSInteger statusCode) {
                
            }];
            
        }
        
        NSDictionary *attachment = [responseObject objectForKey:@"attachment"];
        NSString* attachmentType = [attachment objectForKey:@"type"];
        
        if ([attachmentType isEqualToString:@"photo"] || attachment == nil) {
            
            self.text = [responseObject objectForKey:@"text"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSDictionary *dictPhoto = [attachment objectForKey:@"photo"];
            NSString* urlString = [dictPhoto objectForKey:@"src_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
            
        } else if ([attachmentType isEqualToString:@"link"]) {
            
            NSDictionary *dictLink = [attachment objectForKey:@"link"];
            
            self.text = [dictLink objectForKey:@"description"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSString* urlString = [dictLink objectForKey:@"image_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
            
        } else if ([attachmentType isEqualToString:@"video"]) {
            
            NSDictionary *dictVideo = [attachment objectForKey:@"video"];
            
            self.text = [dictVideo objectForKey:@"description"];
            self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
            
            NSString* urlString = [dictVideo objectForKey:@"image_big"];
            self.postImageURL = [NSURL URLWithString:urlString];
        }
        
        
    }
    return self;
}
@end
