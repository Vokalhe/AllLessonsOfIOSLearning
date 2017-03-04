//
//  EVAUser.h
//  EVAAPIProjectForVK
//
//  Created by Admin on 15.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import "EVAObjectServer.h"

@interface EVAUser : EVAObjectServer
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSNumber *userID;


-(id) initWithServerResponse:(NSDictionary *)responseObject;
@end
