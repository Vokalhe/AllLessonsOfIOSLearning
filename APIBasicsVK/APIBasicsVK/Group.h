//
//  Group.h
//  APIBasicsVK
//
//  Created by Admin on 05.02.17.
//  Copyright © 2017 Ehlakov Victor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *imageURL;

-(id)initWithServerResponse:(NSDictionary*) response;
@end
