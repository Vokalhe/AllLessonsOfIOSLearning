//
//  User.h
//  APIBasics
//
//  Created by Admin on 26.01.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;
-(id) initWithServerResponse:(NSDictionary*) responseObject;
@end
