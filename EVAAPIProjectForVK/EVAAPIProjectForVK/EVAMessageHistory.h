//
//  EVAMessageHistory.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 02.03.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAObjectServer.h"

@interface EVAMessageHistory : EVAObjectServer

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *nameOfAuthor;
@property (strong, nonatomic) NSString *timeOfMessage;
@property (strong, nonatomic) NSString *messageID;
@property (strong, nonatomic) NSNumber *authorID;
@property (strong, nonatomic) NSURL *authorImageView;
@end
